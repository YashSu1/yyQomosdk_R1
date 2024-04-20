//
//  QSerial.h
//  QARSDrv900
//
//  Created by Frank Lin on 5/9/09.
//  Copyright 2009 Qomo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Commdefs.h"
#import "QDevice.h"

@interface QSerial : QDevice
{
	int m_fileDescriptor;
	unsigned char bufferMsg[1024];
	struct termios gOriginalTTYAttrs;
}

- (BOOL)openPort:(const char*)bsdPath withBuadRate:(int)nBaud;
- (BOOL)closePort;
- (BOOL)clearBuf;
- (int)readData:(unsigned char*)pBuffer withLen:(int)nLen;
- (BOOL)sendData:(unsigned char*)buffer withSize:(int)nSize;
- (int)readDataWaiting;

@end
