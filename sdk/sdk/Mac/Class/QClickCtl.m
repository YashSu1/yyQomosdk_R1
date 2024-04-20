//
//  QClickCtl.m
//  QClickSDK
//
//  Created by zheng kai on 11-1-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QClickCtl.h"

#define MAX_LINES_A_QUE                 24
#define WORD_IN_LINE                    21
#define LINE_IN_FRAME                   2


@implementation QClickCtl

-(id)init
{
	self = [super init];
	deviceCtrl = [DeviceController ShareDeviceController];
	nDeviceType = [deviceCtrl currentDeviceType];
	//	appDelegate = [QARS900_AppDelegate getAppDelegate];
	device = [deviceCtrl currentDevice];
	nChannelNo = 0;
	strVersionInfo = @"";
	
	strQuizClassName = @"";
	strQuizTeacherName = @"";
	lSumofStudent = 100;
	sQuizMode = 0;
	bLogin = NO;
	nQuestionNo = 0;
	nQuestionType = 0;
	nNumberOfOption = 0;
	strQuestionInfo = @"";
	strCorrectAnswer = @"";
	randomQuizID = 0;
	randomTeacherID = 0;
	bStartSession = NO;
	bStartQuestion = NO;
	
	arrLoginStudent = [[NSMutableArray alloc] init];
	arrQueContent = [[NSMutableArray alloc] init];
	
	threadState = THREAD_QUIZEMODESED_SEND_QUESTION;
	
	NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self												
		   selector:@selector(handleDataReceive:) 
			   name:@"GetData" 
			 object:nil];
	
	bReadBySelf = NO;
	bIsThreadSendQuestionStart = NO;
	IsOpened = NO;
	
	return self;
}


-(void)dealloc
{
	[arrLoginStudent removeAllObjects];
	[arrLoginStudent release];
	arrLoginStudent = nil;
	[arrQueContent removeAllObjects];
	[arrQueContent release];
	arrQueContent = nil;
	[super dealloc];
}

-(void)initHost
{
	
}

-(BOOL)scanDevice
{
	IsOpened = [deviceCtrl sanDevice];
	return IsOpened;
}

-(int)getDeviceType
{
	nDeviceType = [deviceCtrl currentDeviceType];
	return nDeviceType;
}

-(int)getChannel
{
	return nChannelNo;
}

-(void)setChannel:(int)nChannel
{
	nChannelNo = nChannel;
}


-(bool)CheckCRC
{
	return NO;
}


-(int)getChannelNo
{
	unsigned char sd[64];
	unsigned char crc;
	int nLen = 0;
	
	if([deviceCtrl currentDeviceType] == RF_300)
	{
		sd[nLen++] = 0x59;
		sd[nLen++] = 0x00;		//无关数据
		sd[nLen++] = 0x59;
		
		device = [deviceCtrl currentDevice];
		[device sendData:sd withSize:nLen];
		
		usleep(100000);
		bReadBySelf = YES;
		[deviceCtrl readComData300];		
		frameToHandle = [[[deviceCtrl frameToHandle] retain] autorelease];
		[deviceCtrl signalConditionOfDataHandled];
		
		
		nChannelNo = [frameToHandle data][1]/2;
		bReadBySelf = NO; 
		
	}
	else
	{
		sd[nLen++] = 0xf2;
		sd[nLen++] = 0x00;		//无关数据
		sd[nLen++] = 0x00;
		sd[nLen++] = 0x80;
		
		crc = 0x00;
		int i;
		for (i=0; i<nLen; i++) {
			crc ^= sd[i];
		}
		sd[nLen++] = crc;
		device = [deviceCtrl currentDevice];
		[device sendData:sd withSize:nLen];
		
		usleep(100000);
		bReadBySelf = YES;
		[deviceCtrl readComData700];		
		frameToHandle = [[[deviceCtrl frameToHandle] retain] autorelease];
		[deviceCtrl signalConditionOfDataHandled];
		
		
		nChannelNo = [frameToHandle data][0];
		bReadBySelf = NO; 
	}
	
	return nChannelNo;
}

-(NSString*)getVersionInfo
{
	unsigned char sd[64];
	unsigned char crc;
	int nLen = 0;
	
	switch ([deviceCtrl currentDeviceType]) 
	{
		case RF_300:
			sd[nLen++] = 0x57;
			sd[nLen++] = 0x00;
			sd[nLen++] = 0x57;
			break;
		case RF_700:
		case RF_900:
			sd[nLen++] = 0xf1;
			sd[nLen++] = 0x00;
			sd[nLen++] = 0x00;
			sd[nLen++] = 0x00;
			
			crc = 0x00;
			int i;
			for (i=0; i<nLen; i++) {
				crc ^= sd[i];
			}
			sd[nLen++] = crc;
			break;
		default:
			break;
	}
	
	device = [deviceCtrl currentDevice];
	[device sendData:sd withSize:nLen];
	
	bReadBySelf = YES;
	usleep(100000);
	if([deviceCtrl currentDeviceType] == RF_300)
		[deviceCtrl readComData300];
	else
		[deviceCtrl readComData700];
	
	frameToHandle = [[[deviceCtrl frameToHandle] retain] autorelease];
	[deviceCtrl signalConditionOfDataHandled];
	bReadBySelf = NO;
	
	NSString * strDeviceHost;
	if([deviceCtrl currentDeviceType] == RF_300)
	{
		strDeviceHost = @"QRF300 Host V";
		strVersionInfo = [NSString stringWithFormat:@"%@%d.%02d", 
						  strDeviceHost, [frameToHandle data][1], [frameToHandle data][2]];
		return  strVersionInfo;
	} //700 900
	else
	{
		if([frameToHandle cmd] == 0xf1)
		{
			if ([frameToHandle addr][0] == 0x9f) 
				strDeviceHost = @"QRF900 Host V";
			else 
				strDeviceHost = @"QRF700 Host V";
			
			strVersionInfo = [NSString stringWithFormat:@"%@%d.%02d", 
							  strDeviceHost, [frameToHandle addr][1], [frameToHandle data][0]];
			return strVersionInfo;
		}
	}
	
	return @"";
}

-(long)setChannelNo:(int)newChannelNo;  
{
	if([deviceCtrl currentDeviceType] == RF_300)
	{
		if(newChannelNo < 0 || newChannelNo > 49)
			return 1;
	}
	else
	{
		if(newChannelNo < 0 || newChannelNo > 40)
			return 1;
	}
	
	unsigned char sd[64];
	unsigned char crc;
	int nLen = 0;
	
	switch ([deviceCtrl currentDeviceType]) 
	{
		case RF_300:
			sd[nLen++] = 0x5e;
			sd[nLen++] = 0x80;
			sd[nLen++] = 0xde;
			sd[nLen++] = 0xb8;
			sd[nLen++] = 0xb8;
			sd[nLen++] = 0xb8;
			sd[nLen++] = 0xb8;
			sd[nLen++] = 0xb8;
			sd[nLen++] = 0xb8;
			sd[nLen++] = 0xb0;
			sd[nLen++] = 0xb0;
			sd[9] = 0xb0 | (newChannelNo / 10);
			sd[10] = 0xb0 | (newChannelNo % 10);
			break;
		case RF_700:
		case RF_900:
			sd[nLen++] = 0xf2;
			sd[nLen++] = 0x00;
			int channelNoToSend = newChannelNo * 2 + 1;	//设置通道号 = 输入值*2+1
			sd[nLen++] = channelNoToSend;
			sd[nLen++] = 0x81;
			crc = 0x00;
			int i;
			for (i=0; i<nLen; i++) {
				crc ^= sd[i];
			}
			sd[nLen++] = crc;
			break;
		default:
			break;
	}
	
	
	device = [deviceCtrl currentDevice];
	[device sendData:sd withSize:nLen];
	
	bReadBySelf = YES;
	if([deviceCtrl currentDeviceType] == RF_300)
		[deviceCtrl readComData300];
	else
		[deviceCtrl readComData700];
	bReadBySelf = NO;
	
	frameToHandle = [[[deviceCtrl frameToHandle] retain] autorelease];
	[deviceCtrl signalConditionOfDataHandled];
	
	if([deviceCtrl currentDeviceType] == RF_300)
	{
		if([frameToHandle data][0] == 0x7a && [frameToHandle data][1] == 0x87)
			return 0;
	}
	else
	{
		if([frameToHandle cmd] == 0xf2)
		{
			if ([frameToHandle addr][2] == newChannelNo) 
			{
				return 0;
			}
		}	
	}
	
	
	
	return 0;
}

-(long)startSessionByClassName:(NSString *)_strClassName              //进入考试状态
				   TeacherName:(NSString *)_strTeacherName
					MaxStudent:(long)_nMaxStudent
				   SessionType:(short)_nSessionType
					 LoginFlag:(bool)_bLoginFlag;
{
	
	if(bStartSession)
		return 2;
	
	if([deviceCtrl currentDeviceType] == RF_300)
	{
		unsigned char sd[3] = {0x5b, 0x80, 0xdb};
		device = [deviceCtrl currentDevice];
		[device sendData:sd withSize:3];
		
		
		
	}
	else
	{
		bStartSession = YES;
		strQuizClassName = _strClassName;
		strQuizTeacherName = _strTeacherName;
		lSumofStudent = _nMaxStudent;
		sQuizMode = _nSessionType;
		bLogin = _bLoginFlag;
		
		[self setRandomQuizID];
		[self SendWakeFrame];
		bReadBySelf = YES;
		usleep(700000);
		[self RX_WakeUpByMode:0];
		bReadBySelf = NO;
	}
	return 0;
	
}

-(long)startQuestionByQuestionNo:(short)_nQuesionNo
				  ByQuestionType:(short)_nQuestionType
				ByNumberOfOption:(short)_nNumberOfOption
				ByIsSendQuestion:(bool)_bIsSendQuestion
				  ByQuestionInfo:(NSString*)_strQuestionInfo
				 ByCorrectAnswer:(NSString*)_strCorrectAnswer
{
	if(bStartQuestion)
		return 2;
	
	if([deviceCtrl currentDeviceType] == RF_300)
	{
		unsigned char sd[3] = {0x5b, 0x80, 0xdb};
		[device sendData:sd withSize:3];
		
		usleep(100000);
		
		unsigned char sd2[3] = {0x5a, 0x80, 0xda};
		device = [deviceCtrl currentDevice];
		[device sendData:sd2 withSize:3];
	}
	else
	{
		bStartQuestion = YES;
		nQuestionNo = _nQuesionNo;
		nQuestionType = _nQuestionType;
		nNumberOfOption = _nNumberOfOption;
		bIsSendQuestion = _bIsSendQuestion;
		strQuestionInfo = [_strQuestionInfo retain];
		strCorrectAnswer = _strCorrectAnswer;
		
		[self SendWakeFrame];
		bReadBySelf = YES;
		usleep(700000);
		[self RX_WakeUpByMode:1];
		bReadBySelf = NO;
	}
	
	return 0;
}

-(long)stopQuestion
{
	if(!bStartSession)
		return 2;
	
	if(!bStartQuestion)
		return 3;
	
	if([deviceCtrl currentDeviceType] == RF_700 || [deviceCtrl currentDeviceType] == RF_900)
	{
		[self sendPCState:2];
	}
	else  // 300 
	{
		unsigned char sd[3] = {0x5b, 0x80, 0xdb};
		device = [deviceCtrl currentDevice];
		[device sendData:sd withSize:3];
	}
	
	bStartQuestion = NO;
	
	return 0;
}

-(long)stopSession
{
	bReadBySelf = YES;
	[self SendWakeFrame];
	usleep(700000);
	[self RX_WakeUpByMode:2];
	bReadBySelf = NO;
	bStartSession = NO;
	bStartQuestion = NO;
	return 0;
}

-(bool)closeHost
{
	[deviceCtrl stopReadData];
	IsOpened = NO;
	return YES;
}

-(void)allowLoginByDeviceNo:(long)_nDeviceNo
				ByStudentID:(NSString*)_strStudentID
			   ByISAllowLog:(bool)_bIsAllowLogin
{
	
}

-(long)SetKeypadNO:(long)_lKeypadNO
{
	if(_lKeypadNO < 0 || _lKeypadNO > 400)
		return 3;
	
	unsigned char sd[3];
	sd[0] = 0x60 | ((unsigned char)_lKeypadNO & 0x0f);			//学生设置低字节
	sd[1] = 0x80 | (unsigned char)((_lKeypadNO >> 4) & 0x1f);	//学生设置高字节
	sd[2] = sd[0] ^ sd[1];
	device = [deviceCtrl currentDevice];
	[device sendData:sd withSize:3];
	return 0;
}

-(bool)getIsOpened
{
	return IsOpened;
}

-(NSString*)getVersion
{
	return strVersionInfo;
}

-(NSString*)getModel
{
	int mode = [deviceCtrl currentDeviceType];
	NSString * strModel;
	switch (mode) 
	{
		case 1:
			strModel = @"300";
			break;
		case 2:
			strModel = @"700";
			break;
		case 3:
			strModel = @"900";
		default:
			break;
	}
	return strModel;
}

-(void)SendWakeFrame
{
	unsigned char sd[10];
	int slen;
	unsigned char crc;
	
	slen = 0;
	sd[slen++] = 0xf4;
	sd[slen++] = 0x00;
	sd[slen++] = 0xc0;
	sd[slen++] = 0x01;
	crc = sd[0];
	for(int i=1; i<slen; i++)
	{
		crc = crc^sd[i];
	}
	sd[slen++] = crc;
	device = [deviceCtrl currentDevice];
	[device sendData:sd withSize:slen];	
}

-(void)RX_WakeUpByMode:(int)nMode
{
	if([deviceCtrl currentDeviceType] == RF_300)
		[deviceCtrl readComData300];
	else
		[deviceCtrl readComData700];
	
	frameToHandle = [[[deviceCtrl frameToHandle] retain] autorelease];
	[deviceCtrl signalConditionOfDataHandled];
	
	
	if([frameToHandle cmd] == 0xf5)
	{
		if([frameToHandle dataLen] == 1)
		{
			if([frameToHandle data][0] == 0xe3)
			{
				switch (nMode) {
					case 0:
					{
						for(int i=0; i<20; i++)
						{
							[self SendStudentLoginClassByClassName:strQuizClassName TeacherName:strQuizTeacherName MaxStudent:lSumofStudent];
							usleep(20000);
						}
						
						[self sendPCState:2];
						break;
					}
					case 1:
					{
						[self sendPCState:3];
						[self startSendQuestionThread];
						break;
					}
					case 2:
					{						
						[self sendStudentLogoutClass];
						break;
					}
					default:
						break;
				}
				
			}
		}
	}
}

-(void)RX_Login
{
	if ([frameToHandle isTeacherCommand]) 	
	{
		[self sendQuizMsgToTeacher];
		return;
	}
	else
	{
		int deviceNo = [frameToHandle deviceID];
		unsigned char * data = [frameToHandle data];
		NSString * stuID;
		//学生机登陆处理
		if ([deviceCtrl currentDeviceType] == RF_900) 
		{
			int i;
			for (i=0; i<[frameToHandle dataLen]; i++)
			{
				if (data[i] == 0x00)
				{
					break;
				}
			}
			stuID = [[NSString alloc] initWithBytes:data 
											 length:i 
										   encoding:NSUTF8StringEncoding];
			
		}
		
		
		[self sendQuizMsgToStudent:[self getLoginStudentNewDevice:stuID]];
		
		
		NSArray * values = [NSArray arrayWithObjects:[NSNumber numberWithInt:deviceNo],stuID,nil];
		NSArray * keys = [NSArray arrayWithObjects:@"KeypadNO",@"StudentID",nil];
		
		NSDictionary * dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"OnKeypadLogin" object:nil userInfo:dic];
	}			
}

-(void)RX_Login_700
{
	if([frameToHandle isStudentCommand] && [frameToHandle data][0] == 0xf7)
	{
		int deviceNo = [frameToHandle deviceID];
		unsigned char * data = [frameToHandle data];
		NSString * stuID;
		
		//取出登陆学生的ID及姓名
		int i;
		for (i=0; i<[frameToHandle dataLen]; i++)
		{
			if (data[i] == 0x00)
			{
				break;
			}
		}
		stuID = [[NSString alloc] initWithBytes:data+1 
										 length:i-1 
									   encoding:NSUTF8StringEncoding];
		
		[self sendQuizMsgToStudent:[self getLoginStudentNewDevice:stuID]];
		
		
		NSArray * values = [NSArray arrayWithObjects:[NSNumber numberWithInt:deviceNo],stuID,nil];
		NSArray * keys = [NSArray arrayWithObjects:@"KeypadNO",@"StudentID",nil];
		NSDictionary * dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"OnKeypadLogin" object:nil userInfo:dic];
	}
}

-(void)RX_Logout
{
	if ([frameToHandle data][2] == 0xef) 
	{		
		int deviceNo = [frameToHandle deviceID];
		NSString* strStudentID = [arrLoginStudent objectAtIndex:deviceNo];	
		
		NSArray * values = [NSArray arrayWithObjects:[NSNumber numberWithInt:deviceNo],strStudentID,nil];
		NSArray * keys = [NSArray arrayWithObjects:@"KeypadNO",@"StudentID",nil];
		NSDictionary * dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"OnKeypadLogout" object:nil userInfo:dic];
	}
	
}

- (void)RX_AskForQuestion
{
	
	if([frameToHandle data][2] == 0x0b)
	{
		if(bIsThreadSendQuestionStart)   //发题过程中不处理学生请求
			return;
		
		if(!bIsSendQuestion)
			return;
		
		if(!bStartQuestion)               //考试未开始，提示学生等待
		{
			[self sendStuToWaitForStart];
			return;
		}
		else 
		{
			[self sendAgreeToSend];
			usleep(100000);
			[self startSendQuestionThread];		                     			//同意发送试题内容
		}
	}
}

- (void)RX_StudentNormalAnswer
{
	int deviceNo = [frameToHandle deviceID];
	int answerLength = [frameToHandle dataLen] - 2;
	NSString * answer = [[NSString alloc] initWithBytes:[frameToHandle data] + 2 
												 length:answerLength 
											   encoding:NSUTF8StringEncoding];
	NSLog(@"post ans:%@",answer);
	NSString* strStudentID = [arrLoginStudent objectAtIndex:deviceNo];	
	NSArray * values = [NSArray arrayWithObjects:[NSNumber numberWithInt:deviceNo],strStudentID,answer,nil];
	NSArray * keys = [NSArray arrayWithObjects:@"KeypadNO",@"StudentID",@"Answer",nil];	
	NSDictionary * dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"OnAnswerReceived" object:nil userInfo:dic];
	
}

-(void)RX_StudentNormalAnswer_300
{
	NSString * answer = [NSString stringWithFormat:@"%c",[frameToHandle key]];
	NSLog(@"post ans:%@",answer);
	int deviceNo = [frameToHandle deviceID];
	NSString* strStudentID = [NSString stringWithFormat:@"%d",deviceNo];
	NSArray * values = [NSArray arrayWithObjects:[NSNumber numberWithInt:deviceNo],strStudentID,answer,nil];
	NSArray * keys = [NSArray arrayWithObjects:@"KeypadNO",@"StudentID",@"Answer",nil];	
	NSDictionary * dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"OnAnswerReceived" object:nil userInfo:dic];
	
}

-(void)RX_TeacherCommand
{
	int nCmd = 0;
	if ([frameToHandle isTeacherCommand] 
		&& [frameToHandle cmd] == CMD700_TEACHER_COMMAND) {
		int cmd = [frameToHandle teacherCommand];
		
		switch (cmd) {
			case TCOMMAND_F1:
				nCmd = 1;
				break;
			case TCOMMAND_F2:
				nCmd = 2;
				break;
			case TCOMMAND_PREVIOUS:
				nCmd = 4;
				break;
			case TCOMMAND_EXIT:
				nCmd = 10;
				break;
			case TCOMMAND_NEXT:
				nCmd = 5;
				break;
			case TCOMMAND_START:
				nCmd = 6;
				break;
			case TCOMMAND_STOP:
				nCmd = 7;
				break;
			case TCOMMAND_REPORT:
				nCmd = 9;
				break;
			case TCOMMAND_RESULT:
				nCmd = 8;
				break;
			default:
				break;
		}
	}
	
	
	NSArray * values = [NSArray arrayWithObjects:[NSNumber numberWithInt:nCmd],nil];
	NSArray * keys = [NSArray arrayWithObjects:@"Cmd",nil];	
	NSDictionary * dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"OnControlerReceived" object:nil userInfo:dic];
}

- (void)RX_TeacherCommand_300
{
	int nCmd = 0;
	unsigned char cmd = [frameToHandle teacherCommand];
	switch (cmd) {
		case CMD300_OK:
			break;
		case CMD300_RUN:
			nCmd = 10;
			break;
		case CMD300_RESULT:
			nCmd = 8;
			break;
		case CMD300_REPORT:
			nCmd = 9;
			break;
		case CMD300_START:
			nCmd = 6;
			break;
		case CMD300_STOP:
			nCmd = 7;
			break;
		case CMD300_PREV:
			nCmd = 4;
			break;
		case CMD300_NEXT:
			nCmd = 5;
			break;
		case CMD300_F1:
			nCmd = 1;
			break;
		case CMD300_F2:
			nCmd = 2;
			break;
		default:
			break;
	}
	
	
	NSArray * values = [NSArray arrayWithObjects:[NSNumber numberWithInt:nCmd],nil];
	NSArray * keys = [NSArray arrayWithObjects:@"Cmd",nil];
	NSDictionary * dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"OnControlerReceived" object:nil userInfo:dic];
}


-(void)startSendQuestionThread
{	
	if(!bIsSendQuestion)
		return;
	
	if(bIsThreadSendQuestionStart)   //发题过程中不处理请求
		return;
	
	threadState = THREAD_QUIZEMODESED_SEND_QUESTION;
	[NSThread detachNewThreadSelector:@selector(threadSendQuestion:) toTarget:self withObject:nil];
}

-(void)sendStuToWaitForStart
{
	unsigned char sd[64];
	int nLen = 0;
	unsigned char crc;
	
	sd[nLen++] = 0xf3;
	sd[nLen++] = [frameToHandle deviceID];
	sd[nLen++] = [frameToHandle deviceID]>>8;
	sd[nLen++] = 0xe2;
	crc = sd[0];
	for(int i=1; i<4; i++)
	{
		crc = crc^sd[i];
	}
	sd[nLen++] = crc;
	device = [deviceCtrl currentDevice];
	[device sendData:sd withSize:nLen];
}

-(void)sendAgreeToSend
{
	unsigned char sd[64];
	int nLen = 0;
	unsigned char crc;
	
	sd[nLen++] = 0xf3;
	sd[nLen++] = [frameToHandle deviceID];
	sd[nLen++] = [frameToHandle deviceID]>>8;
	sd[nLen++] = 0xe0;
	crc = sd[0];
	for(int i=1; i<4; i++)
	{
		crc = crc^sd[i];
	}
	sd[nLen++] = crc;
	device = [deviceCtrl currentDevice];
	[device sendData:sd withSize:nLen];
}

- (void)sendQuizMsgToTeacher
{
	unsigned char sd[64];
	unsigned char crc;
	int nLen = 0;
	
	sd[nLen++] = 0xf9;
	int deviceID = [frameToHandle deviceID];
	sd[nLen++] = deviceID;
	sd[nLen++] = deviceID >> 8;
	nLen++;
	
	NSString * className = strQuizClassName;
	int i;
	for (i=0; i<[className length]; i++) {
		int maxLen = 14;
		
		if (i >= maxLen-2 && i < [className length]-2) {
			sd[nLen++] = '.';
			sd[nLen++] = '.';
			break;
		}
		sd[nLen++] = [className characterAtIndex:i];
	}
	sd[nLen++] = 0xee;
	
	NSString * teacherName = strQuizTeacherName;
	for (i=0; i<[teacherName length]; i++) {
		int maxLen = 14;
		if (i >= maxLen-2 && i < [teacherName length]-2) {
			sd[nLen++] = '.';
			sd[nLen++] = '.';
			break;
		}
		sd[nLen++] = [teacherName characterAtIndex:i];
	}
	sd[nLen++] = 0xee;
	int mode = sQuizMode;   //软件当前模式
	
	sd[nLen++] = mode;
	
	sd[nLen++] = lSumofStudent;                     //班级总人数
	sd[nLen++] = lSumofStudent >> 8;
	
	sd[nLen++] = [arrLoginStudent count];			//已登陆学生
	sd[nLen++] = [arrLoginStudent count] >> 8;
	
	sd[nLen++] = randomTeacherID;	//教师登陆时的随机数
	
	if([deviceCtrl currentDeviceType] == RF_700)
	{
		sd[nLen++] = 0xf7;
	}
	
	
	sd[3] = nLen - 4;
	crc = [self getCRC:sd withLen:nLen];
	sd[nLen++] = crc;
	device = [deviceCtrl currentDevice];
	[device sendData:sd withSize:nLen];
}

-(void)SendStudentLoginClassByClassName:(NSString *)str_ClassName
							TeacherName:(NSString*)str_TeacherName
							 MaxStudent:(long)nMaxStudent
{
	unsigned char sd[64];
	int nLen = 0;
	unsigned char crc;
	
	sd[nLen++] = 0xf9;
	sd[nLen++] = 0x00;
	
	if([deviceCtrl currentDeviceType] == RF_700)
		sd[nLen++] = 0x00;
	else if([deviceCtrl currentDeviceType] == RF_900)
		sd[nLen++] = 0xc0;
	
	nLen++;
	NSString * strClassName = str_ClassName;
	NSString * strTeacherName = str_TeacherName;
	
	
	for(int i=0; i<[strClassName length]; i++)
	{
		int nMaxLen = 12;
		if(i >= nMaxLen && i< [strClassName length] -2)
		{
			sd[nLen++] ='.';
			sd[nLen++] ='.';
			break;
		}
		sd[nLen++] = [strClassName characterAtIndex:i];
	}
	sd[nLen++] = 0xee;
	for(int j=0; j < [strTeacherName length]; j++)
	{
		int nMaxLen = 12;
		if(j>= nMaxLen && j< [strTeacherName length] -2)
		{
			sd[nLen++] ='.';
			sd[nLen++] ='.';
			break;
		}
		sd[nLen++] = [strTeacherName characterAtIndex:j];
	}
	sd[nLen++] = 0xee;
	
	int nPartiPerson = nMaxStudent;
	
	sd[nLen++] = (unsigned char)nPartiPerson;
	sd[nLen++] = (unsigned char)(nPartiPerson>>8);
	sd[3] = nLen -4;
	crc = sd[0];
	for(int k=1; k<nLen; k++)
	{
		crc = crc^sd[k];
	}
	sd[nLen++] = crc;
	device = [deviceCtrl currentDevice];
	[device sendData:sd withSize:nLen];
}

- (void)sendPCState:(unsigned char)state
{
	unsigned char sd[64];
	unsigned char crc;
	int nLen = 0;
	
	sd[nLen++] = 0xf5;
	
	sd[nLen++] = randomQuizID;
	sd[nLen++] = randomQuizID >> 8;
	
	
	nLen++;                               //预留数据长度
	
	sd[nLen++] = state;
	
	if (state == 2) //PC_READY_EXAM
	{
		sd[nLen++] = 0x00;		//题号
		sd[nLen++] = 0x00;		//题型
		sd[nLen++] = 0x00;		//选项数
		sd[nLen++] = 0x00;		//当前题目模式
		
	}
	else if(state == 3) //PC_START_EXAM
	{
		sd[nLen++] = nQuestionNo;		//题号
		sd[nLen++] = nQuestionType;     //题型
		sd[nLen++] = nNumberOfOption;   //选项数
		sd[nLen++] = sQuizMode;         //当前题目模式
	}
	
	
	sd[3] = nLen - 4;
	crc = [self getCRC:sd withLen:nLen];
	sd[nLen++] = crc;
	device = [deviceCtrl currentDevice];
	[device sendData:sd withSize:nLen];
}

-(void)sendQuizMsgToStudent:(int)newDeviceNo
{
	unsigned char sd[64];
	unsigned char crc;
	int nLen = 0;
	
	sd[nLen++] = 0xfe;
	
	int deviceID = [frameToHandle deviceID];
	sd[nLen++] = deviceID;                        //设备低字节
	sd[nLen++] = deviceID >> 8;					  //设备高字节
	
	nLen++;										 //数据长
	
	if ([deviceCtrl currentDeviceType] == RF_700)
	{
		sd[nLen++] = 0xf7;
	}
	
	sd[nLen++] = newDeviceNo;			     	 //新设备低字节
	sd[nLen++] = newDeviceNo >> 8;				 //新设备高字节
	
	if ([deviceCtrl currentDeviceType] == RF_700)
	{
		sd[nLen++] = sQuizMode;
	}
	else if([deviceCtrl currentDeviceType] == RF_900)
	{
		int mode = sQuizMode; 
		sd[nLen++] = mode | 0x80;					 //不发题         mode | 0x80 发题目
	}
	
	
	sd[nLen++] = randomQuizID;
	sd[nLen++] = randomQuizID >> 8;
	
	//注册时的学生ID
	unsigned char * data = [frameToHandle data];
	int i;
	
	if([deviceCtrl currentDeviceType] == RF_700)
	{
		for (i=1; i<[frameToHandle dataLen]; i++) 
		{
			if (data[i] == 0x00)   //700学生登陆时,登陆帧包括学生姓名 学生id+ 0xf7要去掉
			{				
				break;
			}
			sd[nLen++] = data[i];
		}
	}
	else if([deviceCtrl currentDeviceType] == RF_900)
	{
		for (i=0; i<[frameToHandle dataLen]; i++) 
		{
			if (data[i] == 0x00)   //900学生登陆时,登陆帧包括学生姓名
			{				
				break;
			}
			sd[nLen++] = data[i];
		}
	}
	
	sd[3] = nLen - 4;
	crc = [self getCRC:sd withLen:nLen];
	sd[nLen++] = crc;
	device = [deviceCtrl currentDevice];
	[device sendData:sd withSize:nLen];
}

//广播发送试题内容
//协议格式:  0xf7 + 0x00 + oxc0  +加数据长 + CMD(0x01) +
//          总帧数 + 当前帧数 + 题目号  + 随机数 + 题目信息 + xor
-(void)sendQuestionFrame:(int)nFrame
{
	unsigned char sd[64];
	int nLen = 0;
	unsigned char crc;
	
	sd[nLen++] = 0xf7;
	sd[nLen++] = 0x00;
	sd[nLen++] = 0xc0;
	nLen++;            
	sd[nLen++] = 0x01;
	sd[nLen++] = [arrQueContent count];  
	sd[nLen++] = nFrame;	
	sd[nLen++] = nQuestionNo;
	sd[nLen++] = randomQuizID; 
	int n=0;
	NSString *strContent = [arrQueContent objectAtIndex:nFrame-1];
	for(int i=0; i<[strContent length]; i++)
	{			
		if([strContent characterAtIndex:i] == 127)
		{
			for(int j=0; j<WORD_IN_LINE-n; j++)
			{
				sd[nLen++] = 0;   
			}
			n=0;
		}
		else if([strContent characterAtIndex:i] != 0x2019 && [strContent characterAtIndex:i] != 0x2018) 
		{
			sd[nLen++] = [strContent characterAtIndex:i];  
			n++;
		}
		else
		{
			if([strContent characterAtIndex:i] == 0x2019 || [strContent characterAtIndex:i] == 0x2018)  // 单引号
			{
				sd[nLen++] ='\'';   
			}
			else
			{
				sd[nLen++] = 0;     
			}
			n++;
		}
	}
	
	for(int j=0; j<WORD_IN_LINE-n; j++)
	{
		sd[nLen++] = 0;
	}
	
	sd[3] = nLen-4;
	crc = sd[0];
	for(int i=1; i<nLen; i++)
	{
		crc = crc^sd[i];
	}
	sd[nLen++] = crc;
	device = [deviceCtrl currentDevice];
	[device sendData:sd withSize:nLen];
}

-(void)sendStudentLogoutClass
{
	//	NSLog(@"sendStudentLogoutClass");
	unsigned char sd[64];
	int nLen = 0;
	unsigned char crc;
	
	sd[nLen++] = 0xf6;
	sd[nLen++] = 0x00;
	
	sd[nLen++] = 0x00;
	
	nLen++;
	sd[nLen++] = 0x01;
	sd[nLen++] = 0xff;
	sd[nLen++] = 0xff;
	
	sd[3] = nLen-4;
	crc = sd[0];
	for(int i=1; i<nLen; i++)
	{
		crc = crc^sd[i];
	}
	sd[nLen++] = crc;
	device = [deviceCtrl currentDevice];
	[device sendData:sd withSize:nLen];
}


-(int)DismemberQuestion
{	
	[arrQueContent removeAllObjects];  
	NSString * strQueContent;		
	NSMutableArray *arrQuestionContent = [[NSMutableArray alloc] init];	
	NSMutableArray *arrQuesitonItem;
	
	NSArray * array = [strQuestionInfo componentsSeparatedByString:@"\n"];//先拆分出各项
	for(int j=0; j<[array count]; j++)
	{
		arrQuesitonItem = [[self DisMemberStringSour:[array objectAtIndex:j]] retain];  //对过长的字符串进行换行处理
		for(int k = 0; k<[arrQuesitonItem count]; k++)
		{
			[arrQuestionContent addObject:[arrQuesitonItem objectAtIndex:k]];
		}
	}
	
	
	for(int i=0; i<[arrQuestionContent count]; i++)   //堆放[0][1]一行，[2][3]一行，
	{	
		if(i%LINE_IN_FRAME == 0)
		{
			strQueContent = [arrQuestionContent objectAtIndex:i];
			NSString * strInterval = [NSString stringWithFormat:@"%c",127];                  //添加间隔符 127  回车ack码
			strQueContent = [strQueContent stringByAppendingString:strInterval];
			if(i == [arrQuestionContent count]-1)
			{
				[arrQueContent addObject:strQueContent];
			}
		}
		else if(i%LINE_IN_FRAME == 1)
		{
			strQueContent = [strQueContent stringByAppendingString:[arrQuestionContent objectAtIndex:i]];
			
			if(i == MAX_LINES_A_QUE-1)
			{
				if([strQueContent length] > WORD_IN_LINE*LINE_IN_FRAME -4)
				{
					strQueContent = [strQueContent substringToIndex:WORD_IN_LINE*LINE_IN_FRAME-4];
				}
			}
			[arrQueContent addObject:strQueContent];
		}
	}
	
	for(int i=0; i< [arrQueContent count]; i++)
	{
		NSLog(@"arrQueContent[%d] =%@",i,[arrQueContent objectAtIndex:i]);
	}
	return [arrQueContent count];
}

- (bool)IsSeparateChar:(char) cChar
{
	char  cSepChar[5] = {'!', ',', '.', '?', ' '};
	for(int i=0; i<5; i++)
	{
		if(cChar == cSepChar[i])
			return true;
	}
	return FALSE;
	
}

- (NSMutableArray *)DisMemberStringSour:(NSString*) strSour 
{
	NSMutableArray  * arrContent = [[NSMutableArray alloc] init];		
	while ([strSour length] > WORD_IN_LINE) 
	{
		if([self IsSeparateChar:[strSour characterAtIndex:WORD_IN_LINE]])  //最后一个是分割符,直接截取所有
		{
			NSString * strTemp = [strSour substringToIndex:WORD_IN_LINE];
			[arrContent addObject:strTemp];
			strSour = [strSour substringFromIndex:WORD_IN_LINE];
		}
		else if([self IsSeparateChar:[strSour characterAtIndex:WORD_IN_LINE-1]])  //最后一个不是分割符 倒数第二个是分割符 截取到分隔符后加空格
		{
			NSString * strTemp = [strSour substringToIndex:WORD_IN_LINE-1];
			strTemp = [strTemp stringByAppendingString:@" "];
			[arrContent addObject:strTemp];
			strSour = [strSour substringFromIndex:WORD_IN_LINE-1];
		}
		else                                                                  //最后一个不是分割符 倒数第二个不是分割符 截取到倒数第二个后加空格
		{
			NSString * strTemp = [strSour substringToIndex:WORD_IN_LINE-1];
			strTemp = [strTemp stringByAppendingString:@" "];
			[arrContent addObject:strTemp];
			strSour = [strSour substringFromIndex:WORD_IN_LINE-1];
		}
	}
	
	[arrContent addObject:strSour];
	[arrContent autorelease];
	return arrContent;
}


- (unsigned char)getCRC:(unsigned char *)data withLen:(int)nLen
{
	NSAssert(data != NULL && nLen >= 0 && nLen <=64, @"Error data or length.");
	unsigned char crc = 0x00;
	int i;
	for (i=0; i<nLen; i++) {
		crc ^= data[i];
	}
	return crc;
}

-(void)handleDataReceive:(NSNotification *)noti
{
	NSLog(@"handleDataReceive %d",bReadBySelf);
	if(bReadBySelf)
		return;
	switch ([deviceCtrl currentDeviceType]) {
		case RF_300:
			[self handleDataReceive300];
			break;
		case RF_700:
		case RF_900:
			[self handleDataReceive700_900];
		default:
			break;
	}
}


-(void)handleDataReceive300
{
	[deviceCtrl readComData300];
	frameToHandle = [[[deviceCtrl frameToHandle] retain] autorelease];
	[deviceCtrl signalConditionOfDataHandled];
	
	if ([frameToHandle isTeacherCommand]) 
	{
		[self RX_TeacherCommand_300];
	}
	else if ([frameToHandle isStudentCommand]) 
	{
		[self RX_StudentNormalAnswer_300];
	}
	
}

-(void)handleDataReceive700_900
{
	[deviceCtrl readComData700];
	frameToHandle = [[[deviceCtrl frameToHandle] retain] autorelease];
	[deviceCtrl signalConditionOfDataHandled];
	
	
	if ([frameToHandle isShortFrame]) 
	{
		[self RX_TeacherCommand];
	}
	else 
	{
		switch ([frameToHandle cmd]) {
			case 0xfe:
				[self RX_Login];
				break;
			case 0xf5:
				[self RX_AskForQuestion];
				break;
			case 0xf6:
				[self RX_Logout];
				break;
			case 0xf7:
				[self RX_StudentNormalAnswer];
				break;
			case 0xf8:
				[self RX_Login_700];
			default:
				break;
		}
	}
}

-(void)setRandomQuizID
{
	srandom(time(NULL));
	randomQuizID = rand(); 
	randomTeacherID = rand();
}

-(int)getLoginStudentNewDevice:(NSString*)StudentID
{
	for(int i=0; i<[arrLoginStudent count]; i++)
	{
		if([[arrLoginStudent objectAtIndex:i] isEqualTo:StudentID])
			return i;
	}
	
	[arrLoginStudent addObject:StudentID];
	return [arrLoginStudent count]-1;
}



-(void)threadSendQuestion:(id)object
{
	bIsThreadSendQuestionStart = TRUE;
	NSAutoreleasePool * pool= [[NSAutoreleasePool alloc] init];
	while (1)
	{
		switch (threadState)
		{
			case THREAD_QUIZEMODESED_SEND_QUESTION:
				[self DismemberQuestion];            //发送试卷信息
				for(int i=0; i<5; i++)
				{
					for(int i=0; i<[arrQueContent count]; i++)
					{
						[self sendQuestionFrame:i+1];
						usleep(50000);
					}
				}
				[conStartReceive_mode lock];
				[conStartReceive_mode waitUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.2]];
				[conStartReceive_mode unlock];
				threadState = THREAD_QUIZEMODESED_SEND_POLLSTUDENT;
				break;
			case THREAD_QUIZEMODESED_SEND_POLLSTUDENT:				
				threadState = THREAD_QUIZEMODESED_KILL_THREAD;
				break;
			case THREAD_QUIZEMODESED_KILL_THREAD:				
				NSLog(@"thread exit.");
				bIsThreadSendQuestionStart = FALSE;
				[pool release];
				[NSThread exit];
				break; 
			default:
				break;
		}
	}
}

@end
