//
//  QInterface.h
//  QClick
//
//  Created by zheng kai on 11-1-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QClickCtl.h"

@interface QInterface : NSObject {

}

QClickCtl * ctlObject;

bool IsOpend();
NSString *Version();
NSString *Model();
int Channel();
void setChannel(int channel);

/* 初始化硬件 返回true表示正常 返回false表示没找到主机 */
bool InitHost();

/* 获取设备信息 lFlag=0获得通道号 lFlag=1获得型号 lFlag=2获得版本号 */
NSString *GetHostInfo(long lFlag);

/* 设置通道号 返回0表示设置成功 返回1表示非法通道  返回2表示设置失败 */
long SetHostChannel(short nChannelNO);

/* 300设置DeviceID 0表示老师 1－400表示学生 返回0表示成功 返回1表示非法 3表示不允许设定*/
long SetKeypadNO(long lKeypadNO);

/*bLoginFlag 是否需要确认登录学生在选择班级  返回0表示成功 返回1表示错误需要（init） 返回2表示需要StopSession才能进行进行操作*/
long StartSession(NSString *strClassName, NSString *strTeacherName, long lMaxStudents, short sSessionType, bool bLoginFlag);

/*返回0表示成功 返回1表示错误需要(init) 返回2表示需要StopQuestion才能进行进行操作*/
long StartQuestion(short nQuestionNo, short nQuestionType, short nNumberOfOption, 
				   bool bIsSendQuestion, NSString*strQuestionInfo, NSString*strCorrectAnswer); 

/*返回0表示成功 返回1表示错误需要(init) 返回2表示需要StartSession 返回3表示需要StartQuestion */
long StopQuesiton();

/*返回0表示成功 返回1表示错误需要(init) 返回2表示需要StartSession*/
long StopSession();

/*返回true表示关闭成功*/
bool CloseHost();

/*返回1表示成功 返回0表示错误需要(init)*/
bool AllowLogin(long lDeviceNo, NSString* strStudentID, bool bIsAllowLogin);



/*0没主机，1 900，2 700，3 600 ，4 500， 5 QRF 300,6 QIR 300*/
void OnDeviceChanged(short nHostMode,char *pChannelNO,char *pHostVersion);



@end
