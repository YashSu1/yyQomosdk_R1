//
//  DataOfFrame.h
//  QARS900
//
//  Created by yxg on 09-12-24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DataOfFrame : NSObject <NSCopying> {
	unsigned char cmd;
	unsigned char addr[2];
	unsigned char dataLen;
	unsigned char data[64];
	unsigned char crc;
	
	enum TypeOfFrame {
		FRAME_TYPE300,
		FRAME_TYPE700
	} TypeOfFrame;
	enum TypeOfFrame type;
}

- (id)initWithType:(enum TypeOfFrame)newType;
+ (id)DataOfFrame300;
+ (id)DataOfFrame700;

- (void)setCmd:(unsigned char)newCmd;
- (void)setAddr:(unsigned char *)newAddr;
- (void)setDataLen:(unsigned char)newLen;
- (void)setData:(unsigned char *)newData withLen:(int)nLen;
- (void)setCrc:(unsigned char)newCrc;

- (BOOL)isFrameCorrect;					//对该帧进行crc校验,判断是否合法帧
- (unsigned char)cmd;					//返回该帧命令字节
- (unsigned char *)addr;				//返回该帧地址字节首地址
- (int)deviceID;						//返回该帧设备号
- (int)dataLen;							//返回该帧数据长
- (unsigned char *)data;				//返回该帧数据首地址
- (unsigned char)crc;					//返回该帧校验位

- (unsigned char)key;					//300帧时,返回设备点击的按键

- (BOOL)isTeacherCommand;				//判断当前帧是否为教师机发送
- (BOOL)isStudentCommand;				//判断当前帧是否为学生机发送

- (unsigned char)teacherCommand;		//返回教师机控制命令字节

- (BOOL)isShortFrame;					//700,900时判断是否为短帧(f1-f4)
- (BOOL)isLongFrame;					//700,900时判断是否为长帧(f5-ff)

@end
