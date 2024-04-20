//
//  DataOfFrame.m
//  QARS900
//
//  Created by yxg on 09-12-24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DataOfFrame.h"
//#import "Commdefs.h"


@implementation DataOfFrame

- (id)copyWithZone:(NSZone *)zone
{
	DataOfFrame * copy = [[DataOfFrame alloc] initWithType:type];
	[copy setCmd:cmd];
	[copy setAddr:addr];
	[copy setDataLen:dataLen];
	[copy setData:data withLen:dataLen];
	[copy setCrc:crc];
	return copy;
}

- (id)initWithType:(enum TypeOfFrame)newType
{
	if (self = [super init]) {
		cmd = 0;
		bzero(addr, sizeof(addr));
		dataLen = 0;
		bzero(data, sizeof(data));
		crc = 0;
		type = newType;
	}
	return self;
}

+ (id)DataOfFrame300
{
	return [[[DataOfFrame alloc] initWithType:FRAME_TYPE300] autorelease];
}

+ (id)DataOfFrame700
{
	return [[[DataOfFrame alloc] initWithType:FRAME_TYPE700] autorelease];
}

- (void)setCmd:(unsigned char)newCmd
{
	cmd = newCmd;
}

- (void)setAddr:(unsigned char *)newAddr
{
	assert(newAddr);
	memcpy(addr, newAddr, 2);
}

- (void)setDataLen:(unsigned char)newLen
{
	dataLen = newLen;
}

- (void)setData:(unsigned char *)newData withLen:(int)nLen
{
	assert(newData);
	assert(nLen >= 0 && nLen <= 64);
	memset(data, 0, sizeof(data));
	memcpy(data, newData, nLen);
	dataLen = nLen;
}

- (void)setCrc:(unsigned char)newCrc
{
	crc = newCrc;
}

- (BOOL)isFrameCorrect
{
	unsigned char temp;
	temp = cmd;
	
	int i;
	for (i=0; i<2; i++) {
		temp ^= addr[i];
	}
	
	if (cmd >= 0xf5) {
		temp ^= dataLen;
	}
	
	for (i=0; i<dataLen; i++) {
		temp ^= data[i];
	}
	
	return temp == crc;
}

- (unsigned char)cmd
{
	return cmd;
}

- (unsigned char *)addr
{
	return addr;
}

- (int)deviceID
{
	int nDeviceID;
	
	switch (type) {
		case FRAME_TYPE300:
			if ([self isTeacherCommand]) {								//教师机命令
				nDeviceID = 0;
			}else if ([self isStudentCommand]) {	//学生机命令
				nDeviceID = (data[0] - 0x20) * 16 + (data[1] & 0x0f);
			}
			break;
		case FRAME_TYPE700:
			nDeviceID = addr[0] + (addr[1] << 8);
//			NSLog(@"add[0]:%d   add[1]:%d",addr[0],addr[1]);
			break;
		default:
			break;
	}
//	NSLog(@"type:%d  deviceID:%d",type,nDeviceID);
	return nDeviceID;
}

- (int)dataLen
{
	int nLen;
	switch (type) {
		case FRAME_TYPE300:
			nLen = 0;
			break;
		case FRAME_TYPE700:
			nLen = dataLen;
			break;
		default:
			break;
	}
	return nLen;
}

- (unsigned char *)data
{
	return data;
}

- (unsigned char)crc
{
	return crc;
}

- (unsigned char)key
{
	unsigned char ret;
	if (type == FRAME_TYPE300) {
		if ([self isTeacherCommand]) {
			ret = data[1];
		}else if ([self isStudentCommand]) {
			ret = (((data[1] >> 4) & 0x0f) - 0x08) + 'A';
		}

	}
	return ret;
}

- (BOOL)isTeacherCommand
{
	NSLog(@"isTeacherCommand ");
	BOOL result = NO;
	if (type == FRAME_TYPE300) {
		result = data[0] == 0x00;
	}else if (type == FRAME_TYPE700) {
		result = addr[1] == 0xef;
	}
	
	return result;
}

- (BOOL)isStudentCommand
{
	BOOL result = NO;
	if (type == FRAME_TYPE300) {
		result = data[0] >= 0x20 && data[0] <= 0x39;
	}else if (type == FRAME_TYPE700) {
		result = addr[1] != 0xef;
	}
	return result;
}

- (unsigned char)teacherCommand
{
	if (![self isTeacherCommand])
		return 0;
	
	unsigned char command;
	if (type == FRAME_TYPE300) {
		command = data[1];
	}else if (type == FRAME_TYPE700) {
		command = data[0];
	}
	return command;
}

- (BOOL)isShortFrame
{
	if (type == FRAME_TYPE300) 
		return YES;
	
	return cmd >= 0xf0 && cmd < 0xf5;
}

- (BOOL)isLongFrame
{
	if (type == FRAME_TYPE300) 
		return NO;
	
	return cmd >= 0xf5;
}

@end
