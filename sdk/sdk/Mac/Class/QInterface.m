//
//  QInterface.m
//  QClick
//
//  Created by zheng kai on 11-1-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QInterface.h"
#import "Commdefs.h"

@implementation QInterface

//-(id)init
//{
//	self = [super init];
//	ctlObject = [[QClickCtl alloc] init];
//	return self;
//}
//
//-(void)dealloc
//{
//	[ctlObject release];
//	ctlObject = nil;
//	[super dealloc];
//}


#define EXPORT __attribute__((visibility("default")))


bool IsOpend()
{
	return [ctlObject getIsOpened];
}

NSString *Version()
{
	return [ctlObject getVersion];
}

NSString *Model()
{
	return [ctlObject getModel];
}

int Channel()
{
	return [ctlObject getChannel];
}


void setChannel(int channel)
{
	return [ctlObject setChannel:channel];
}


bool InitHost()
{
	if(!ctlObject)
		ctlObject = [[QClickCtl alloc] init];
	return [ctlObject scanDevice];
}

long SetHostChannel(short nChannelNO)
{
	if([ctlObject getDeviceType] == -1)
		return 2;
	
	return [ctlObject setChannelNo:nChannelNO];
}


NSString *GetHostInfo(long lFlag)
{
	NSString *message = @"";
	switch (lFlag) 
	{
		case 0:                                                       //通道号 
			message = [NSString stringWithFormat:@"%d",[ctlObject getChannelNo]];
			break;
		case 1:                                                       //主机型号
		{
			int myDeviceChanel = [ctlObject getDeviceType];
			switch (myDeviceChanel) 
			{
				case RF_300:
					message = @"RF_300";
					break;
				case RF_700:
					message = @"RF_700";
					break;
				case RF_900:
					message = @"RF_900";
					break;
				default:
					break;
			}
		}
			break;
		case 2:														  //版本号
			message = [ctlObject getVersionInfo];
			break;
		default:
			break;
	}
	return message;
}


long StartSession(NSString *strClassName, NSString *strTeacherName, long lMaxStudents, short sSessionType, bool bLoginFlag)
{
	if([ctlObject getDeviceType] == -1)
		return 1;
		
	return [ctlObject startSessionByClassName:strClassName 
								  TeacherName:strTeacherName
								   MaxStudent:lMaxStudents 
								  SessionType:sSessionType 
									LoginFlag:bLoginFlag];
}

long StartQuestion(short nQuestionNo, short nQuestionType, short nNumberOfOption, 
				   bool bIsSendQuestion, NSString*strQuestionInfo, NSString*strCorrectAnswer)
{
	if([ctlObject getDeviceType] == -1)
		return 1;

	return [ctlObject startQuestionByQuestionNo:nQuestionNo 
								 ByQuestionType:nQuestionType 
							   ByNumberOfOption:nNumberOfOption 
							   ByIsSendQuestion:bIsSendQuestion 
								 ByQuestionInfo:strQuestionInfo 
								ByCorrectAnswer:strCorrectAnswer];
}

long StopQuesiton()
{
	if([ctlObject getDeviceType] == -1)
		return 1;
	return [ctlObject stopQuestion];
}

long StopSession()
{
	if([ctlObject getDeviceType] == -1)
		return 1;
	return [ctlObject stopSession];
}

bool AllowLogin(long lDeviceNo, NSString* strStudentID, bool bIsAllowLogin)
{
	if([ctlObject getDeviceType] == -1)
		return 0;
	
	return YES;
}

bool CloseHost()
{
	[ctlObject closeHost];
	[ctlObject release];
	ctlObject = nil;
	return YES;
}

long SetKeypadNO(long lKeypadNO)
{
	if([ctlObject getDeviceType] == -1)
		return 1;
	
	return [ctlObject SetKeypadNO:lKeypadNO];
}


@end
