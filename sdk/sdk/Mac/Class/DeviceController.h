//
//  DeviceController.h
//  QARSDrv900
//
//  Created by Frank Lin on 5/9/09.
//  Copyright 2009 Qomo. All rights reserved.
//
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
#include <IOKit/IOMessage.h>
#include <IOKit/IOCFPlugIn.h>
#include <IOKit/usb/IOUSBLib.h>

#import <Cocoa/Cocoa.h>
#import "QDevice.h"
#import "QRF300.h"
#import "QRF700.h"
#import "QRF900.h"
#import "QRF700_900.h"
#import "DataOfFrame.h"
#import "QDevice.h"

#define kMyVendorID			0x10C4
#define kMyProductID		0xEA60

#define MAX_ARS_SYSTEMS		100
#define MESSAGE_RECEIVE_DATA		@"RECEIVE_DATA"


typedef struct MyPrivateData {
    io_object_t				notification;
    IOUSBDeviceInterface	**deviceInterface;
    CFStringRef				deviceName;
    CFStringRef				devicePath;
    UInt32					locationID;
    UInt32					currentDeviceIndex;
	char					deviceDesc[255];
} MyPrivateData;

@interface DeviceController : NSObject
{
	NSMutableArray * arrayDevices;		//设备数组
	int curDeviceIndex;					//当前设备下标
	QDevice * curDevice;				//当前通讯设备
	int curDeviceType;					//当前设备类型
//	int nChannelNo;                     //当前设备通道
//	NSString * strVersionInfo;          //当前设备版本
	BOOL isQuizStart;					//考试开始标志
	
	NSTimer * timer;					//定时器，用来定时扫描串口数据
	bool bIsReceiveComplete;			//判断接收到的串口数据是否是一个完整的命令帧
	DataOfFrame * frame;				//接收到的帧
	
	NSMachPort * machPort;				//通知串口消息的port
	NSMutableArray * receiveFrames;		//数组保存接收到的帧
	
	NSCondition * conNewDataReceived;	//新的串口数据到达通知
	NSCondition * conDataFrameHandled;	//上一帧串口数据处理完成通知
	
	enum ThreadSendState {
		THREAD_WAIT_HANDLED_SIGNAL,		//线程当前等待上一帧处理完成信号
		THREAD_WAIT_NEW_DATA_SIGNAL,	//线程当前等待新的数据帧到达信号
		THREAD_TERMINATE				//线程结束
	} THREAD_STATE;
	enum ThreadSendState threadState;
	
	QDevice * device;
	BOOL bFoundDevice;
}

+ (id)ShareDeviceController;						//单态接口

- (void)addInterestInDeviceType:(NSInteger)deviceType;

//设备拔插响应
- (NSInteger)addDeviceToArray:(QDevice *)device;	//添加设备到队列，返回队列下标
- (void)removeDeviceFromArray:(NSInteger)index;		//从队列中移除下标为index为设备

- (void)threadDeviceAdded:(id)object;				//当设备插入时,扫描设备类型线程
- (NSInteger)scanDevice:(io_iterator_t)iterator;	//扫描插入的设备
- (void)myDeviceAdded:(NSInteger)indexOfDevice;		//新的设备插入处理

- (void)threadDeviceRemoved:(id)object;				//当设备拔出时,移除设备线程
- (void)myDeviceRemoved:(NSInteger)indexOfDevice;	//移除设备处理

//串口读取
- (void)startToRead;
- (void)stopToRead;
- (void)readComData:(NSTimer *)aTimer;
- (void)readComData300;
- (void)readComData700;

//外部处理串口数据对象设置
- (void)setDelegateOfPort:(id)object;

//通知串口消息处理
- (DataOfFrame *)frameToHandle;
- (void)signalConditionOfNewDataReceived;
- (void)signalConditionOfDataHandled;

//外部接口
- (void)setIsQuizStart:(BOOL)state;

- (QDevice *)currentDevice;
- (int)currentDeviceType;
- (void)setCurDeviceType:(int)nDeviceType;
- (void)checkChannels;
- (BOOL)sanDevice;
- (void)stopReadData;

@end
