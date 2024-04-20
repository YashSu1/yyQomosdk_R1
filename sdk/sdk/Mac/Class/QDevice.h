//
//  QDevice.h
//  QARSDrv900
//
//  Created by Frank Lin on 5/1/09.
//  Copyright 2009 Qomo. All rights reserved.
//
// QSerial.h
#pragma once
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <errno.h>
#include <paths.h>
#include <termios.h>
#include <sysexits.h>
#include <sys/param.h>
#include <sys/select.h>
#include <sys/time.h>
#include <time.h>
#include <AvailabilityMacros.h>
#ifdef __MWERKS__
#define __CF_USE_FRAMEWORK_INCLUDES__
#endif
#include <CoreFoundation/CoreFoundation.h>

#include <IOKit/IOKitLib.h>
#include <IOKit/serial/IOSerialKeys.h>
#if defined(MAC_OS_X_VERSION_10_3) && (MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_3)
#include <IOKit/serial/ioss.h>
#endif
#include <IOKit/IOBSD.h>
#define FC_DTRDSR       0x01
#define FC_RTSCTS       0x02
#define FC_XONXOFF      0x04
#define ASCII_BEL       0x07
#define ASCII_BS        0x08
#define ASCII_LF        0x0A
#define ASCII_CR        0x0D
#define ASCII_XON       0x11
#define ASCII_XOFF      0x13

#import <Cocoa/Cocoa.h>

@interface QDevice : NSObject
{
	char	m_bsdPath[1024];
	char	deviceName[MAXPATHLEN];
	int		type;
	UInt32	locationID;
	NSString * deviceDescription;
}

- (NSString*)getDeviceDescription;
- (int)detectDevice:(const char*)bsdPath;
- (char*)getDeviceNameValue;
- (void)setDeviceNameValue:(const char*)value;
- (int)type;
- (void)setType:(int)newType;

- (BOOL)openDevice;
- (void)closeDevice;
- (int)readData:(unsigned char*)pBuffer withLen:(int)nLen;
- (BOOL)sendData:(unsigned char*)buffer withSize:(int)nSize;
- (int)readDataWaiting;
- (BOOL)clearBuf;

@end
