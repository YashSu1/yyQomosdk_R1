//
//  QClickCtl.h
//  QClickSDK
//
//  Created by zheng kai on 11-1-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QDevice.h"
#import "DeviceController.h"
#import "DataOfFrame.h"
#import "QARS900_AppDelegate.h"


@interface QClickCtl : NSObject {
	DeviceController * deviceCtrl;
	QDevice * device;								//当前通讯用主机
	DataOfFrame * frameToHandle;
	int nDeviceType;
	int nChannelNo;
	NSString * strVersionInfo;
	NSMutableArray * arrQueContent;				//发送的题目内容
	NSMutableArray * arrLoginStudent;           //已经登录学生
	NSString * strQuizClassName;
	NSString * strQuizTeacherName;
	int nQuestionNo;
	int nQuestionType;
	int nNumberOfOption;
	bool bIsSendQuestion;
	NSString *strQuestionInfo;
	NSString *strCorrectAnswer;
	long  lSumofStudent;
	short sQuizMode;
	bool  bLogin;
	int randomQuizID;							 //试卷id随机数
	int randomTeacherID;						 //教师id随机数
	bool bStartSession;                          //进入考试状态
	bool bStartQuestion;						 //开始答题
	bool bReadBySelf;                            //主动读取数据
	bool bIsThreadSendQuestionStart;        //发送试卷内容线程是否开始标记
//	QARS900_AppDelegate * appDelegate;
	NSCondition * conStartReceive_mode;
	bool IsOpened;
	
}

-(void)initHost;                                     //设备初始话									
-(BOOL)scanDevice;
-(int)getDeviceType;                                 //获得设备类型
-(int)getChannelNo;									 //获得设备通道号
-(NSString*)getVersionInfo;                          //获得设备版本号
-(bool)getIsOpened;
-(long)setChannelNo:(int)newChannelNo;               //设置设备通道号

-(long)startSessionByClassName:(NSString *)_strClassName              //进入考试状态
				   TeacherName:(NSString *)_strTeacherName
					MaxStudent:(long)_nMaxStudent
				   SessionType:(short)_nSessionType
					 LoginFlag:(bool)_bLoginFlag;



-(long)startQuestionByQuestionNo:(short)_nQuesionNo
				  ByQuestionType:(short)_nQuestionType
				ByNumberOfOption:(short)_nNumberOfOption
				ByIsSendQuestion:(bool)_bIsSendQuestion
				  ByQuestionInfo:(NSString*)_strQuestionInfo
				 ByCorrectAnswer:(NSString*)_strCorrectAnswer;

-(long)stopQuestion;
-(long)stopSession;
-(bool)closeHost;
-(void)allowLoginByDeviceNo:(long)_nDeviceNo
				ByStudentID:(NSString*)_strStudentID
			   ByISAllowLog:(bool)_bIsAllowLogin;

-(long)SetKeypadNO:(long)_lKeypadNO;

-(NSString*)getVersion;
-(NSString*)getModel;
-(int)getChannel;
-(void)setChannel:(int)nChannel;

-(bool)CheckCRC;									 //校验检查
-(void)SendWakeFrame;								//发送唤醒帧:用于自动登录，自动退出，题目发送
-(void)RX_WakeUpByMode:(int)nMode;					//收到回馈唤醒
-(void)RX_Login;
-(void)RX_Login_700;
-(void)RX_Logout;
-(void)RX_AskForQuestion;							
-(void)RX_StudentNormalAnswer;						//学生机回答命令
-(void)RX_StudentNormalAnswer_300;
-(void)RX_TeacherCommand;                           //教师机控制命令
- (void)RX_TeacherCommand_300;
-(void)SendStudentLoginClassByClassName:(NSString *)str_ClassName
							TeacherName:(NSString*)str_TeacherName
							 MaxStudent:(long)nMaxStudent;


-(void)sendPCState:(unsigned char)state;

-(void)sendStudentLogoutClass;
-(void)sendQuizMsgToTeacher;                        //发送试卷信息给老师
-(void)sendQuizMsgToStudent:(int)newDeviceNo;       //发送试卷信息给学生
-(void)sendAgreeToSend;
-(void)sendAgreeToSend;

-(bool)IsSeparateChar:(char) cChar;
-(NSMutableArray *)DisMemberStringSour:(NSString*) strSour;
-(int)DismemberQuestion;							//分割题目内容
-(void)sendStuToWaitForStart;
-(void)sendQuestionFrame:(int)nFrame;				//广播发送题目内容帧
-(void)startSendQuestionThread;                     //打开发送题目进程
-(unsigned char)getCRC:(unsigned char *)data withLen:(int)nLen;

-(void)handleDataReceive:(NSNotification *)noti;    //从串口设备接收数据
-(void)handleDataReceive300;					    //300读取接收到的命令
-(void)handleDataReceive700_900;					//700_900发送数据

-(void)setRandomQuizID;
-(int)getLoginStudentNewDevice:(NSString*)StudentID;

enum ThreadSendQuestionState
{
	THREAD_QUIZEMODESED_SEND_QUESTION,                //通知发送试卷
	THREAD_QUIZEMODESED_SEND_POLLSTUDENT,			  //通知轮询学生
	THREAD_QUIZEMODESED_KILL_THREAD,                  //通知关闭线程
} THREAD_STATE_SEND;
enum ThreadSendQuestionState threadState;
@end
