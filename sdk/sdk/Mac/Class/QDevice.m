//
//  QDevice.m
//  QARSDrv900
//
//  Created by Frank Lin on 5/1/09.
//  Copyright 2009 Qomo. All rights reserved.

#import "QDevice.h"

@implementation QDevice : NSObject

- (BOOL)openDevice
{
	return NO;
}

- (void)closeDevice
{
	
}

- (NSString*)getDeviceDescription
{
	NSString * strTest = [[NSString alloc] initWithCString:[self getDeviceNameValue] encoding:NSASCIIStringEncoding];
	return [strTest copy];
}

- (int)detectDevice:(const char*)bsdPath
{
	return -1;
}

- (char*)getDeviceNameValue
{
	return deviceName;
}

- (void)setDeviceNameValue:(const char*)value
{
	strcpy(deviceName, value);
}

- (int)type
{
	return type;
}



- (void)setType:(int)newType
{
	type = newType;
}

- (int)readData:(unsigned char*)pBuffer withLen:(int)nLen
{
	return 0;
}


- (BOOL)sendData:(unsigned char*)buffer withSize:(int)nSize
{
	return NO;
}

- (int)readDataWaiting
{
	return 0;
}

- (BOOL)clearBuf
{
	return NO;
}

@end
