//
//  DeviceController.m
//  QARSDrv900
//
//  Created by Frank Lin on 5/9/09.
//  Copyright 2009 Qomo. All rights reserved.
//

#import "DeviceController.h"

static DeviceController * pDeviceController = nil;

kern_return_t GetModemPath(io_object_t serialPortIterator, char *bsdPath, CFIndex maxPathSize);
static IONotificationPortRef	gNotifyPort;
static io_iterator_t	gAddedIter;
static CFRunLoopRef	gRunLoop;
static void deviceNotification(void* refCon, io_service_t service, natural_t messageType, void* messageArgument);
static void deviceAdded(void*refCon, io_iterator_t iterator);


kern_return_t GetModemPath(io_object_t serialPortIterator, char *bsdPath, CFIndex maxPathSize)
{
    io_object_t		modemService = serialPortIterator;
    kern_return_t	kernResult = KERN_FAILURE;
    Boolean			modemFound = false;
	
    // Initialize the returned path
    *bsdPath = '\0';
    
    // Iterate across all modems found. In this example, we bail after finding the first modem.
	CFTypeRef	bsdPathAsCFString;
	
	// Get the callout device's path (/dev/cu.xxxxx). The callout device should almost always be
	// used: the dialin device (/dev/tty.xxxxx) would be used when monitoring a serial port for
	// incoming calls, e.g. a fax listener.
		
	bsdPathAsCFString = IORegistryEntryCreateCFProperty(modemService,
														CFSTR(kIOCalloutDeviceKey),
														kCFAllocatorDefault,
														0);
	if (bsdPathAsCFString)
	{
		Boolean result;
            
		// Convert the path from a CFString to a C (NUL-terminated) string for use
		// with the POSIX open() call.
			
		result = CFStringGetCString((CFStringRef)bsdPathAsCFString,
									bsdPath,
									maxPathSize, 
									kCFStringEncodingUTF8);
		NSLog(@"\nbsdPath = %s\n",bsdPath);
			
		CFRelease(bsdPathAsCFString);
			
		if (result)
		{
			modemFound = true;
			kernResult = KERN_SUCCESS;
		}
	}
	
    return kernResult;
}

void deviceNotification(void* refCon, io_service_t service, natural_t messageType, void* messageArgument)
{
	kern_return_t	kr;
    char bsdPath[MAXPATHLEN];
    
	MyPrivateData * privateDataRef = (MyPrivateData *)refCon;
	
    if (messageType == kIOMessageServiceIsTerminated) 
	{
		// Dump our private data to stderr just to see what it looks like.
		//fprintf(stderr, "privateDataRef->deviceName: ");
		//CFShow(privateDataRef->deviceName);
		//fprintf(stderr, "privateDataRef->locationID: 0x%lx.\n\n", privateDataRef->locationID);
		
		// Free the data we're no longer using now that the device is going away
		if(privateDataRef)
		{
			CFStringGetCString((CFStringRef)privateDataRef->deviceName,
							   bsdPath,
							   MAXPATHLEN, 
							   kCFStringEncodingUTF8);
			if(strstr(bsdPath, "IOSerialBSDClient"))
			{
				int nIndex = privateDataRef->currentDeviceIndex;
				if (nIndex >= 0) {
					//创建线程,移除串口设备
					[NSThread detachNewThreadSelector:@selector(threadDeviceRemoved:) toTarget:[DeviceController ShareDeviceController] withObject:[NSNumber numberWithInt:nIndex]];
				}
			}
			
			CFRelease(privateDataRef->deviceName);
			if (privateDataRef->deviceInterface) 
			{
				kr = (*privateDataRef->deviceInterface)->Release(privateDataRef->deviceInterface);
			}
			
			kr = IOObjectRelease(privateDataRef->notification);
			
			free(privateDataRef);
		}
    }
}

//有设备插入时的回调函数，当有感兴趣的设备插入时，发送DeviceAdded消息
void deviceAdded(void* refCon, io_iterator_t iterator)
{
	//创建线程,扫描串口设备
	[NSThread detachNewThreadSelector:@selector(threadDeviceAdded:) toTarget:[DeviceController ShareDeviceController] withObject:[NSNumber numberWithUnsignedInt:iterator]];
}

@implementation DeviceController

+ (id)ShareDeviceController
{
	@synchronized(self) {
		if (pDeviceController == nil) {
			pDeviceController = [[self alloc] init];
		}
	}
	return pDeviceController;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (pDeviceController == nil) {
            pDeviceController = [super allocWithZone:zone];
            return pDeviceController;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

- (id)retain
{
	return self;
}

- (unsigned)retainCount
{
	return NSUIntegerMax;
}

- (void)release
{
	
}

- (id)autorelease
{
	return self;
}

- (id)init
{
    self = [super init];
	
    arrayDevices = [[NSMutableArray alloc] init];
	curDeviceIndex = -1;
	curDevice = nil;
//	curDeviceType = CURRENT_DEVICE_TYPE;
	curDeviceType = -1;
	isQuizStart = NO;
	bFoundDevice = NO;
	
	timer = nil;
	
	bIsReceiveComplete = YES;
	receiveFrames = [[NSMutableArray alloc] init];
	conNewDataReceived = [[NSCondition alloc] init];
	conDataFrameHandled = [[NSCondition alloc] init];
	
	threadState = THREAD_TERMINATE;
	
	machPort = [[NSMachPort alloc] init];
	[[NSRunLoop currentRunLoop] addPort:machPort forMode:(NSString *)kCFRunLoopCommonModes];
	
//	[self addInterestInDeviceType:curDeviceType];

	return self;
}

- (void) dealloc
{
	if (curDeviceIndex >= 0) {
		[self stopToRead];
		[curDevice closeDevice];
	}
	
    [arrayDevices release];
	[receiveFrames release];
	[conNewDataReceived release];
	[conDataFrameHandled release];
	[machPort release];
    [super dealloc];
}

- (void)addInterestInDeviceType:(NSInteger)deviceType
{

	CFMutableDictionaryRef 	matchingDict;
    CFRunLoopSourceRef		runLoopSource;
    CFNumberRef				numberRef;
    kern_return_t			kr;
	
    // Set up the matching criteria for the devices we're interested in. The matching criteria needs to follow
    // the same rules as kernel drivers: mainly it needs to follow the USB Common Class Specification, pp. 6-7.
    // See also Technical Q&A QA1076 "Tips on USB driver matching on Mac OS X" 
	// <http://developer.apple.com/qa/qa2001/qa1076.html>.
    // One exception is that you can use the matching dictionary "as is", i.e. without adding any matching 
    // criteria to it and it will match every IOUSBDevice in the system. IOServiceAddMatchingNotification will 
    // consume this dictionary reference, so there is no need to release it later on.
    
    //matchingDict = IOServiceMatching(kIOUSBDeviceClassName);	// Interested in instances of class
    matchingDict = IOServiceMatching(kIOSerialBSDServiceValue);	// Interested in instances of class
	// IOUSBDevice and its subclasses
    if (matchingDict == NULL)
	{
    }
	else
	{
        CFDictionarySetValue(matchingDict,
                             CFSTR(kIOSerialBSDTypeKey),
                             CFSTR(kIOSerialBSDRS232Type));
	}		
	/*    
	 // We are interested in all USB devices (as opposed to USB interfaces).  The Common Class Specification
	 // tells us that we need to specify the idVendor, idProduct, and bcdDevice fields, or, if we're not interested
	 // in particular bcdDevices, just the idVendor and idProduct.  Note that if we were trying to match an 
	 // IOUSBInterface, we would need to set more values in the matching dictionary (e.g. idVendor, idProduct, 
	 // bInterfaceNumber and bConfigurationValue.
	 
	 // Create a CFNumber for the idVendor and set the value in the dictionary
	 numberRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &usbVendor);
	 CFDictionarySetValue(matchingDict, 
	 CFSTR(kUSBVendorID), 
	 numberRef);
	 CFRelease(numberRef);
	 
	 // Create a CFNumber for the idProduct and set the value in the dictionary
	 numberRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &usbProduct);
	 CFDictionarySetValue(matchingDict, 
	 CFSTR(kUSBProductID), 
	 numberRef);
	 CFRelease(numberRef);
	 */    
    numberRef = NULL;
	
    // Create a notification port and add its run loop event source to our run loop
    // This is how async notifications get set up.
    
    gNotifyPort = IONotificationPortCreate(kIOMasterPortDefault);
    runLoopSource = IONotificationPortGetRunLoopSource(gNotifyPort);
    
    gRunLoop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(gRunLoop, runLoopSource, kCFRunLoopCommonModes);
    
    // Now set up a notification to be called when a device is first matched by I/O Kit.
    kr = IOServiceAddMatchingNotification(gNotifyPort,					// notifyPort
                                          kIOFirstMatchNotification,	// notificationType
                                          matchingDict,					// matching
                                          deviceAdded,					// callback
                                          NULL,							// refCon
                                          &gAddedIter					// notification
                                          );		
	
    // Iterate once to get already-present devices and arm the notification    
	deviceAdded(NULL, gAddedIter);
	

}

#pragma mark 串口设备拔插,相应操作

- (NSInteger)addDeviceToArray:(QDevice *)device
{
	int i;
	for (i=0; i<[arrayDevices count]; i++) {
		if ([arrayDevices objectAtIndex:i] == @"") {
			[arrayDevices replaceObjectAtIndex:i withObject:device];
			return i;
		}
		
	}
	
	[arrayDevices addObject:device];
	return [arrayDevices count]-1;
}

- (void)removeDeviceFromArray:(NSInteger)index
{
	if (index >= [arrayDevices count]) {
		return;
	}
	
	[arrayDevices replaceObjectAtIndex:index withObject:@""];
}

- (void)threadDeviceAdded:(id)object
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	io_iterator_t iterator = [object unsignedIntValue];
	int nIndex = [self scanDevice:iterator];
	if (nIndex >= 0) {
		NSLog(@"index of device : %d", nIndex);
		[self myDeviceAdded:nIndex];
	}
	
	[pool release];
}

- (NSInteger)scanDevice:(io_iterator_t)iterator
{
	int indexOfDevice = -1;
	
	io_service_t serialDevice;
	while ((serialDevice = IOIteratorNext(iterator))) {
		char bsdPath[MAXPATHLEN];
		kern_return_t kr;
		
		kr = GetModemPath(serialDevice, bsdPath, MAXPATHLEN);
		if (kr != KERN_SUCCESS) {
			continue;
		}
		

		if (strstr(bsdPath, "SLAB_USBtoUART")
				   || strstr(bsdPath, "usbserial-") ) {
			QDevice * pDevice;
			Boolean bFound = false;
			char deviceString[100];
			
			usleep(50000);						//打开设备前,休眠50ms,避免出现打开设备文件失败
			
			switch (1) {
//				case IR_300:
//					pDevice = [[QIR300 alloc] init];
//					if([pDevice detectDevice:bsdPath])
//					{
//						bFound = true;
//						strcpy(deviceString, "QIR300");
//						[pDevice setDeviceNameValue:deviceString];
//						[pDevice setValue:@"QIR300" forKey:@"deviceDescription"];
//						indexOfDevice = [self addDeviceToArray:pDevice];
//						[pDevice release];
//						[self setCurDeviceType:IR_300];
//						break;
//					}				
//					[pDevice release];
				case 1://RF_300
					pDevice = [[QRF300 alloc] init];
					if([pDevice detectDevice:bsdPath])
					{
						bFound = true;
						strcpy(deviceString, "QRF300");
						[pDevice setDeviceNameValue:deviceString];
						[pDevice setValue:@"QRF300" forKey:@"deviceDescription"];
						indexOfDevice = [self addDeviceToArray:pDevice];
						[pDevice release];
						[self setCurDeviceType:RF_300];
						break;
					}			
					[pDevice release];
				case 2://RF_700 RF_900
					
					pDevice = [[QRF700_900 alloc] init];
					int type = [pDevice detectDevice:bsdPath];
					if(type) {
						bFound = true;
						if(type == RF_700)
						{
							strcpy(deviceString, "QRF700");
							[pDevice setDeviceNameValue:deviceString];
							[pDevice setValue:@"QRF700" forKey:@"deviceDescription"];
							indexOfDevice = [self addDeviceToArray:pDevice];
							[pDevice release];
							[self setCurDeviceType:RF_700];
						}
						else if(type == RF_900)
						{
							strcpy(deviceString, "QRF900");
							[pDevice setDeviceNameValue:deviceString];
							[pDevice setValue:@"QRF900" forKey:@"deviceDescription"];
							indexOfDevice = [self addDeviceToArray:pDevice];
							[pDevice release];
							[self setCurDeviceType:RF_900];
							break;
						}
						break;
					}
					[pDevice release];
//				case RF_900:
//					pDevice = [[QRF900 alloc] init];
//					if([pDevice detectDevice:bsdPath]) {
//						bFound = true;
//						strcpy(deviceString, "QRF900");
//						[pDevice setDeviceNameValue:deviceString];
//						[pDevice setValue:@"QRF900" forKey:@"deviceDescription"];
//						indexOfDevice = [self addDeviceToArray:pDevice];
//						[pDevice release];
//						[self setCurDeviceType:RF_900];
//						break;
//					}
//					[pDevice release];
				default:
					break;
			}
			
			if(bFound) {
				bFoundDevice = YES;//add code................................
				// Add some app-specific information about this device.
				// Create a buffer to hold the data.
				MyPrivateData * privateDataRef = NULL;
				privateDataRef = malloc(sizeof(MyPrivateData));
				bzero(privateDataRef, sizeof(MyPrivateData));
				
				// Get the Serial device's name.
				io_name_t deviceName;
				kr = IORegistryEntryGetName(serialDevice, deviceName);
				if (KERN_SUCCESS != kr)
				{
					deviceName[0] = '\0';
				}
				
				// add device to the list;
				CFStringRef	deviceNameAsCFString;
				deviceNameAsCFString = CFStringCreateWithCString(kCFAllocatorDefault, deviceName, 
																 kCFStringEncodingASCII);
				
				// Save the device's name to our private data.        
				privateDataRef->deviceName = deviceNameAsCFString;
				strcpy(privateDataRef->deviceDesc, deviceString);
				privateDataRef->currentDeviceIndex = indexOfDevice;
				
				// Register for an interest notification of this device being removed. Use a reference to our
				// private data as the refCon which will be passed to the notification callback.
				kr = IOServiceAddInterestNotification(gNotifyPort,						// notifyPort
													  serialDevice,						// service
													  kIOGeneralInterest,				// interestType
													  deviceNotification,				// callback
													  privateDataRef,					// refCon
													  &(privateDataRef->notification)	// notification
													  );
				
			}
		}
	}
	return indexOfDevice;
}

-(void)myDeviceAdded:(NSInteger)indexOfDevice
{
	if (isQuizStart && curDeviceIndex >= 0) {		//当前正在考试,且有串口设备进行数据接收
		return;
	}
	
	if (isQuizStart && curDeviceIndex == -1) {		//当前正在考试,且没有串口设备进行数据接收
		QDevice * device = [arrayDevices objectAtIndex:indexOfDevice];
		int deviceType = [device type];
		if (deviceType != curDeviceType) {			//插入的设备与考试开始时的设备类型不同
			return;
		}
	}
	
	//关闭当前的设备
	if (curDeviceIndex > 0) {
		[self stopToRead];
		[curDevice closeDevice];
	}
	
	//打开新插入的设备并开始从设备接收数据
	curDeviceIndex = indexOfDevice;
	curDevice = [arrayDevices objectAtIndex:indexOfDevice];
//	curDeviceType = [curDevice type];
	[curDevice openDevice];
	[self startToRead];
	
	//通知当前设备更改
	NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
	[nc postNotificationName:@"DeviceChanged" object:nil];
	
}

- (void)threadDeviceRemoved:(id)object
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	int nIndex = [object intValue];
	[self myDeviceRemoved:nIndex];
	
	[pool release];
}

-(void)myDeviceRemoved:(NSInteger)indexOfDevice
{
	if (indexOfDevice == curDeviceIndex) {				//如果拔出的设备为当前通讯设备
		[self stopToRead];								//停止接收
		[curDevice closeDevice];
		[self removeDeviceFromArray:indexOfDevice];
		
		if (isQuizStart) {
			curDeviceIndex = -1;
			curDevice = nil;
			
			//通知当前设备更改
			NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
			[nc postNotificationName:@"DeviceChanged" object:nil];
			return;
		}
		
		//非考试状态下,查找最后一个插入的设备
		int i;
		for (i=[arrayDevices count]-1; i>=0; i--) {		//遍历设备队列，找出最后插入的设备
			if ([arrayDevices objectAtIndex:i] != @"") {
				break;
			}
		}
		curDeviceIndex = i;
		NSLog(@"cur device index after remove : %d", curDeviceIndex);
		
		if (curDeviceIndex >= 0) {
			curDevice = [arrayDevices objectAtIndex:curDeviceIndex];
//			curDeviceType = [curDevice type];
			[curDevice openDevice];
			[self startToRead];
		}else {
			curDevice = nil;
		}
		
		//通知当前设备更改
		NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
		[nc postNotificationName:@"DeviceChanged" object:nil];
	}else {												//拔出设备不是当前的通讯设备
		[self removeDeviceFromArray:indexOfDevice];
	}
}

#pragma mark 创建，销毁定时器及读取串口数据 

- (void)startToRead
{
	NSLog(@"start to read com\n");

	if (timer == nil)
	{
		timer = [[NSTimer timerWithTimeInterval:0.01
										 target:self
									   selector:@selector(readComData:)
									   userInfo:nil
										repeats:YES] retain];
		
		NSRunLoop * curRunLoop = [NSRunLoop mainRunLoop];
		[curRunLoop addTimer:timer forMode:NSRunLoopCommonModes];
	}
	
	threadState = THREAD_WAIT_NEW_DATA_SIGNAL;
	[NSThread detachNewThreadSelector:@selector(threadSend:) toTarget:self withObject:nil];
}

- (void)stopToRead
{
	NSLog(@"stop to read com\n");
	if (timer != nil) {
		[timer invalidate];
		[timer release];
		timer = nil;
	}
	
	threadState = THREAD_TERMINATE;
}

- (void)readComData:(NSTimer *)aTimer
{
	if (curDevice == nil) {
		[self stopToRead];
		return;
	}
	
	switch (curDeviceType) {
		case RF_300:
			[self readComData300];
			break;
		case RF_700:
		case RF_900:
			[self readComData700];
			break;
		default:
			break;
	}
}

- (void)readComData300
{
	unsigned char temp[64];
	unsigned char clearComm[1024];
	int nLen;
	
//	NSLog(@"readComData300 %d",[curDevice readDataWaiting]);
	if ([curDevice readDataWaiting] >= 3/*3*/) {
		memset(temp, 0, sizeof(temp));
		nLen = 3;
		[curDevice readData:temp withLen:nLen];
		
		if (temp[2] != (temp[0]^temp[1])) {
			if (temp[0] != 0x57) {								//300在读取主机版本号时，回馈帧不满足CRC
				nLen = [curDevice readDataWaiting];
				[curDevice readData:clearComm withLen:nLen];
				return;
			}
		}
		
		frame = [DataOfFrame DataOfFrame300];
		[frame setData:temp withLen:3];
		[receiveFrames addObject:frame];
		
		NSLog(@"receive data : %02x	%02x	%02x\n",temp[0],temp[1],temp[2]);

		//通知串口数据接收
		[self signalConditionOfNewDataReceived];
	}
}

- (void)readComData700
{
	unsigned char temp[64];
	unsigned char * p;
	int nLen;
	
	if (bIsReceiveComplete)
	{		//上一帧接收完整,开始新的一帧的接收
		if ([curDevice readDataWaiting] >= 5)
		{	
			memset(temp, 0, sizeof(temp));
			nLen = 1;
			[curDevice readData:temp withLen:nLen];
			
			if (temp[0] & 0xf0 != 0xf0 || temp[0] == 0xff)
			{	//无效字节
				NSLog(@"error data.");
				return;
			}
			
			frame = [DataOfFrame DataOfFrame700];				//可能内存泄露
			[frame setCmd:temp[0]];
			
			if (temp[0] >= 0xf0 && temp[0] < 0xf5)
			{													//短帧数据
				memset(temp, 0, sizeof(temp));
				nLen = 4;
				[curDevice readData:temp withLen:nLen];
				p = temp;
				[frame setAddr:p];
				p += 2;
				[frame setDataLen:1];
				[frame setData:p withLen:1];
				p += [frame dataLen];
				[frame setCrc:*p];
				
				[receiveFrames addObject:frame];
				printf("Receive:%02x  ", [frame cmd]);
				printf("%02x %02x  ", [frame addr][0], [frame addr][1]);
				int i;
				for (i=0; i<[frame dataLen]; i++) 
				{
					printf("%02x ", [frame data][i]);
				}
				printf(" %02x\n", [frame crc]);
				//通知串口数据接收
				[self signalConditionOfNewDataReceived];
				
				bIsReceiveComplete = YES;
			}
			else 
			{												//长帧数据
				memset(temp, 0, sizeof(temp));
				nLen = 3;
				[curDevice readData:temp withLen:nLen];
				p = temp;
				[frame setAddr:p];
				p += 2;
				[frame setDataLen:*p];
				
				if ([curDevice readDataWaiting] >= [frame dataLen] + 1) 
				{	//数据长+校验位
					memset(temp, 0, sizeof(temp));
					nLen = [frame dataLen] + 1;
					[curDevice readData:temp withLen:nLen];
					p = temp;
					[frame setData:p withLen:[frame dataLen]];
					p += [frame dataLen];
					[frame setCrc:*p];
					
					[receiveFrames addObject:frame];
					printf("Receive:%02x  ", [frame cmd]);
					printf("%02x %02x  ", [frame addr][0], [frame addr][1]);
					printf("%02x  ", [frame dataLen]);
					int i;
					for (i=0; i<[frame dataLen]; i++) 
					{
						printf("%02x ", [frame data][i]);
					}
					printf(" %02x\n", [frame crc]);
					//通知串口数据接收
					[self signalConditionOfNewDataReceived];
					
					bIsReceiveComplete = YES;
				}
				else 
				{
					bIsReceiveComplete = NO;
				}
			}
		}
	}
	else
	{															//一帧的数据接收不完整,继续等待至数据接收完整
		if ([curDevice readDataWaiting] >= [frame dataLen] + 1)
		{	//数据长+校验位
			memset(temp, 0, sizeof(temp));
			nLen = [frame dataLen] + 1;
			[curDevice readData:temp withLen:nLen];
			p = temp;
			[frame setData:p withLen:[frame dataLen]];
			p += [frame dataLen];
			[frame setCrc:*p];
			
			[receiveFrames addObject:frame];
			printf("Receive:%02x  ", [frame cmd]);
			printf("%02x %02x  ", [frame addr][0], [frame addr][1]);
			printf("%02x  ", [frame dataLen]);
			int i;
			for (i=0; i<[frame dataLen]; i++)
			{
				printf("%02x ", [frame data][i]);
			}
			printf(" %02x\n", [frame crc]);
			//通知串口数据接收
			[self signalConditionOfNewDataReceived];
			
			bIsReceiveComplete = YES;
		}
		else
		{
			bIsReceiveComplete = NO;
		}
	}
}

- (void)setDelegateOfPort:(id)object
{
	[machPort setDelegate:object];
}

#pragma mark 发送串口消息线程相关

- (void)threadSend:(id)object
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	while (1) {
		switch (threadState) {
			case THREAD_WAIT_HANDLED_SIGNAL:
				[conDataFrameHandled lock];
				if ([conDataFrameHandled waitUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]] == NO)  //等待上一帧处理完成,超时提示并自动通知下一帧处理.
					NSLog(@"wait time out.");
				[conDataFrameHandled unlock];
				
				if ([receiveFrames count] > 0) {				//移除上一个已被处理,或处理超时的帧
					[receiveFrames removeObjectAtIndex:0];
				}
				
				if ([receiveFrames count] == 0) {				//如果待处理帧数组为空,等待串口数据接收
					threadState = THREAD_WAIT_NEW_DATA_SIGNAL;
				}else {
					[machPort sendBeforeDate:[NSDate date] components:nil from:nil reserved:0];
				}
				break;
			case THREAD_WAIT_NEW_DATA_SIGNAL:
				[conNewDataReceived lock];
				if ([conNewDataReceived waitUntilDate:[NSDate dateWithTimeIntervalSinceNow:3/*3*/]]) {
					[machPort sendBeforeDate:[NSDate date] components:nil from:nil reserved:0];
					threadState = THREAD_WAIT_HANDLED_SIGNAL;
				}
				[conNewDataReceived unlock];
				break;
			case THREAD_TERMINATE:
				NSLog(@"thread exit.");
				[pool release];
				[NSThread exit];
				break;
			default:
				break;
		}
	}
}

- (DataOfFrame *)frameToHandle
{
	DataOfFrame * frameToHandle;
	if ([receiveFrames count] == 0) {
		frameToHandle = nil;
	}else {
		frameToHandle = [receiveFrames objectAtIndex:0];
	}
	return frameToHandle;
}

- (void)signalConditionOfNewDataReceived
{
	[conNewDataReceived lock];
	[conNewDataReceived signal];
	[conNewDataReceived unlock];
	
	NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
	[nc postNotificationName:@"GetData" object:nil];
}

- (void)signalConditionOfDataHandled
{
	[conDataFrameHandled lock];
	[conDataFrameHandled signal];
	[conDataFrameHandled unlock];	
}

#pragma mark 外部接口

- (void)setIsQuizStart:(BOOL)state
{
	isQuizStart = state;
}

- (QDevice*)currentDevice
{
	return curDevice;
}

- (int)currentDeviceType
{
	return curDeviceType;
}

-(void)setCurDeviceType:(int)nDeviceType
{
	curDeviceType = nDeviceType;
}

-(void)checkChannels
{
//	unsigned char sd[5];
//	int slen;
//	unsigned char crc;
//	
//	slen = 0;
//	sd[slen++] = 0xf4;
//	sd[slen++] = 0x00;
//	sd[slen++] = 0xc0;
//	sd[slen++] = 0x02;
//	crc = sd[0];
//	for(int i=1; i<slen; i++)
//	{
//		crc = crc^sd[i];
//	}
//	sd[slen++] = crc;
//	[curDevice sendData:sd withSize:slen];	
//	
//	unsigned  char rdMessage[10];
//	usleep(1000000); // 10 ms
//
//		if([curDevice readData:rdMessage withLen:10])
//		{
//			if(rdMessage[0]==0xf5 && rdMessage[1]==0x00 && rdMessage[2]==0xc0 && rdMessage[3]==0x01 && rdMessage[4]==0xe1)
//			{
//				NSAlert * alert = [NSAlert alertWithMessageText:@"QClick ARS"
//												  defaultButton:@"OK"
//												alternateButton:nil
//													otherButton:nil
//									  informativeTextWithFormat:@"Two main receivers have the same channel, please change the channel number for any one of them."];
//				[alert runModal];
//			}
//		}
}

- (BOOL)sanDevice
{
	bFoundDevice = NO;
	[self stopReadData];
		
	CFMutableDictionaryRef 	matchingDict;
    CFRunLoopSourceRef		runLoopSource;
    CFNumberRef				numberRef;
    kern_return_t			kr;
	
    // Set up the matching criteria for the devices we're interested in. The matching criteria needs to follow
    // the same rules as kernel drivers: mainly it needs to follow the USB Common Class Specification, pp. 6-7.
    // See also Technical Q&A QA1076 "Tips on USB driver matching on Mac OS X" 
	// <http://developer.apple.com/qa/qa2001/qa1076.html>.
    // One exception is that you can use the matching dictionary "as is", i.e. without adding any matching 
    // criteria to it and it will match every IOUSBDevice in the system. IOServiceAddMatchingNotification will 
    // consume this dictionary reference, so there is no need to release it later on.
    
    //matchingDict = IOServiceMatching(kIOUSBDeviceClassName);	// Interested in instances of class
    matchingDict = IOServiceMatching(kIOSerialBSDServiceValue);	// Interested in instances of class
	// IOUSBDevice and its subclasses
    if (matchingDict == NULL)
	{
    }
	else
	{
        CFDictionarySetValue(matchingDict,
                             CFSTR(kIOSerialBSDTypeKey),
                             CFSTR(kIOSerialBSDRS232Type));
	}		
	/*    
	 // We are interested in all USB devices (as opposed to USB interfaces).  The Common Class Specification
	 // tells us that we need to specify the idVendor, idProduct, and bcdDevice fields, or, if we're not interested
	 // in particular bcdDevices, just the idVendor and idProduct.  Note that if we were trying to match an 
	 // IOUSBInterface, we would need to set more values in the matching dictionary (e.g. idVendor, idProduct, 
	 // bInterfaceNumber and bConfigurationValue.
	 
	 // Create a CFNumber for the idVendor and set the value in the dictionary
	 numberRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &usbVendor);
	 CFDictionarySetValue(matchingDict, 
	 CFSTR(kUSBVendorID), 
	 numberRef);
	 CFRelease(numberRef);
	 
	 // Create a CFNumber for the idProduct and set the value in the dictionary
	 numberRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &usbProduct);
	 CFDictionarySetValue(matchingDict, 
	 CFSTR(kUSBProductID), 
	 numberRef);
	 CFRelease(numberRef);
	 */    
    numberRef = NULL;
	
    // Create a notification port and add its run loop event source to our run loop
    // This is how async notifications get set up.
    
    gNotifyPort = IONotificationPortCreate(kIOMasterPortDefault);
    runLoopSource = IONotificationPortGetRunLoopSource(gNotifyPort);
    
    gRunLoop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(gRunLoop, runLoopSource, kCFRunLoopCommonModes);
    
    // Now set up a notification to be called when a device is first matched by I/O Kit.
    kr = IOServiceAddMatchingNotification(gNotifyPort,					// notifyPort
                                          kIOFirstMatchNotification,	// notificationType
                                          matchingDict,					// matching
                                          deviceAdded,					// callback
                                          NULL,							// refCon
                                          &gAddedIter					// notification
                                          );		
	
    // Iterate once to get already-present devices and arm the notification    
	deviceAdded(NULL, gAddedIter);
	usleep(4000000);
	return bFoundDevice;
}

-(void)stopReadData
{
	if (curDeviceIndex >= 0) {
		[self stopToRead];
		[curDevice closeDevice];
	}
}

@end
