//
//  QSerial.m
//  QARSDrv900
//
//  Created by Frank Lin on 5/9/09.
//  Copyright 2009 Qomo. All rights reserved.
//

#import "QSerial.h"

@implementation QSerial

- (id)init
{
	self = [super init];
	
	return self;
}

- (void)closeDevice
{
	[self closePort];
}

- (void) dealloc
{
	[self closePort];
    [super dealloc];
}

- (BOOL)openPort:(const char*)bsdPath withBuadRate:(int)nBaud
{
    int	handshake;
    struct termios	options;
	unsigned long mics = 1UL;
	m_fileDescriptor = -1;
	speed_t speed;
	
	UInt32 beginOpen, endOpen;
	beginOpen = TickCount();
	
    // Open the serial port read/write, with no controlling terminal, and don't wait for a connection.
    // The O_NONBLOCK flag also causes subsequent I/O on the device to be non-blocking.
    // See open(2) ("man 2 open") for details.
    usleep(800000);
    m_fileDescriptor = open(bsdPath, O_RDWR | O_NOCTTY | O_NONBLOCK);
    if (m_fileDescriptor == -1)
    {
		NSLog(@"open failed.");
		NSLog(@"%s", strerror(errno));
        goto error;
    }
	
    // Note that open() follows POSIX semantics: multiple open() calls to the same file will succeed
    // unless the TIOCEXCL ioctl is issued. This will prevent additional opens except by root-owned
    // processes.
    // See tty(4) ("man 4 tty") and ioctl(2) ("man 2 ioctl") for details.
    
    if (ioctl(m_fileDescriptor, TIOCEXCL) == -1)
    {
        goto error;
    }
    
    // Now that the device is open, clear the O_NONBLOCK flag so subsequent I/O will block.
    // See fcntl(2) ("man 2 fcntl") for details.
    
    if (fcntl(m_fileDescriptor, F_SETFL, 0) == -1)
    {
        goto error;
    }
    
    // Get the current options and save them so we can restore the default settings later.
    if (tcgetattr(m_fileDescriptor, &gOriginalTTYAttrs) == -1)
    {
        goto error;
    }
	
    // The serial port attributes such as timeouts and baud rate are set by modifying the termios
    // structure and then calling tcsetattr() to cause the changes to take effect. Note that the
    // changes will not become effective without the tcsetattr() call.
    // See tcsetattr(4) ("man 4 tcsetattr") for details.
    
    options = gOriginalTTYAttrs;
    
    // Print the current input and output baud rates.
    // See tcsetattr(4) ("man 4 tcsetattr") for details.
	
    // Set raw input (non-canonical) mode, with reads blocking until either a single character 
    // has been received or a one second timeout expires.
    // See tcsetattr(4) ("man 4 tcsetattr") and termios(4) ("man 4 termios") for details.
    
    cfmakeraw(&options);
    options.c_cc[VMIN] = 0;
    options.c_cc[VTIME] = 0;
	
    // The baud rate, word length, and handshake options can be set as follows:
    //N,8,1
    cfsetspeed(&options, nBaud);		   
    options.c_cflag &= ~PARENB;
    options.c_cflag &= ~CSTOPB;
    options.c_cflag &= ~CSIZE;
    options.c_cflag |= CS8;
	
#if defined(MAC_OS_X_VERSION_10_4) && (MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_4)
	// Starting with Tiger, the IOSSIOSPEED ioctl can be used to set arbitrary baud rates
	// other than those specified by POSIX. The driver for the underlying serial hardware
	// ultimately determines which baud rates can be used. This ioctl sets both the input
	// and output speed. 
	
	speed = nBaud; // Set baud
    if (ioctl(m_fileDescriptor, IOSSIOSPEED, &speed) == -1)
    {
    }
#endif
    
    // Print the new input and output baud rates. Note that the IOSSIOSPEED ioctl interacts with the serial driver 
	// directly bypassing the termios struct. This means that the following two calls will not be able to read
	// the current baud rate if the IOSSIOSPEED ioctl was used but will instead return the speed set by the last call
	// to cfsetspeed.
	
    // Cause the new options to take effect immediately.
    if (tcsetattr(m_fileDescriptor, TCSANOW, &options) == -1)
    {
        goto error;
    }
	
    // To set the modem handshake lines, use the following ioctls.
    // See tty(4) ("man 4 tty") and ioctl(2) ("man 2 ioctl") for details.
    
    if (ioctl(m_fileDescriptor, TIOCSDTR) == -1) // Assert Data Terminal Ready (DTR)
    {
    }
    
    if (ioctl(m_fileDescriptor, TIOCCDTR) == -1) // Clear Data Terminal Ready (DTR)
    {
    }
    
    handshake = TIOCM_DTR | TIOCM_RTS | TIOCM_CTS | TIOCM_DSR;
    if (ioctl(m_fileDescriptor, TIOCMSET, &handshake) == -1)
		// Set the modem lines depending on the bits set in handshake
    {
    }
    
    // To read the state of the modem lines, use the following ioctl.
    // See tty(4) ("man 4 tty") and ioctl(2) ("man 2 ioctl") for details.
    
    if (ioctl(m_fileDescriptor, TIOCMGET, &handshake) == -1)
		// Store the state of the modem lines in handshake
    {
    }
	
#if defined(MAC_OS_X_VERSION_10_3) && (MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_3)
	mics = 1UL;
	
	// Set the receive latency in microseconds. Serial drivers use this value to determine how often to
	// dequeue characters received by the hardware. Most applications don't need to set this value: if an
	// app reads lines of characters, the app can't do anything until the line termination character has been
	// received anyway. The most common applications which are sensitive to read latency are MIDI and IrDA
	// applications.
	
	if (ioctl(m_fileDescriptor, IOSSDATALAT, &mics) == -1)
	{
		// set latency to 1 microsecond
        goto error;
	}
#endif
    
	endOpen = TickCount();
	NSLog(@"time : %.2f", (endOpen - beginOpen) / 60.0);
	
    // Success
    return TRUE;
    
    // Failure path
error:
    if (m_fileDescriptor != -1)
    {
        close(m_fileDescriptor);
		m_fileDescriptor = -1;
    }
	return FALSE;	
}

- (BOOL)closePort
{
    if (m_fileDescriptor != -1)
    {
        close(m_fileDescriptor);
		m_fileDescriptor = -1;
    }
	return TRUE;
}

- (BOOL)clearBuf
{
	int mode = TCIOFLUSH;
	BOOL result = (tcflush(m_fileDescriptor, mode) != -1);
	return result;
}

- (int)readData:(unsigned char*)buffer withLen:(int)nLen
{
    ssize_t nBytesRead;
	
    nBytesRead = read(m_fileDescriptor, buffer, nLen);
    if (nBytesRead == -1)
    {
    	 return 0;
    }
	
    return nBytesRead;
}

- (BOOL)sendData:(unsigned char*)buffer withSize:(int)nSize
{
	int i;
	printf("Send:");
	for (i=0; i<nSize; i++) {
		printf("%02x ", buffer[i]);
	}
	printf("\n");
	
	int sentSize;
	sentSize = write(m_fileDescriptor, buffer, nSize);
	return (sentSize==nSize);	
}

- (int)readDataWaiting
{
    int bytes = 0;
	int withWait = 10000;
	usleep(withWait);
    ioctl(m_fileDescriptor, FIONREAD, &bytes);
    return bytes;
}

@end
