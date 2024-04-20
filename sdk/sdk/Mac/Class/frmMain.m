//
//  frmMain.m
//  QClickSDKDemo
//
//  Created by zheng kai on 11-1-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//   

#import "frmMain.h"
#include <dlfcn.h>

@implementation frmMain

-(id)init
{
	self = [super init];
	
	return self;
}

-(void)dealloc
{
	[super dealloc];
	
}


-(void)awakeFromNib
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleOnAnswerReceived:)
												 name:@"OnAnswerReceived"
											   object:nil];
}

-(void)handleOnAnswerReceived:(NSNotification *)noti
{
	NSString *studentAnswer = [[noti userInfo] valueForKey:@"Answer"];
	NSLog(@"get ans :%@",studentAnswer);
}

-(IBAction)OnSetChannel:(id)sender
{
//	short int channel = [cmbChannel indexOfSelectedItem];
//	SetHostChannel(channel);
	
	SetKeypadNO(0);
	
}
-(IBAction)OnInit:(id)sender
{
//	void * lib_handle = dlopen(path,1);
//	bool* (*myInitHost)(float , float) = dlsym(lib_handle, "InitHost");
	
	bool myInitHost = InitHost();
	if(myInitHost)
	{

		[cmbChannel selectItemAtIndex:[GetHostInfo(0) intValue]];
		[txtModel setStringValue:GetHostInfo(1)];
		[txtVersion setStringValue:GetHostInfo(2)];
	}
}

-(IBAction)OnStartSession:(id)sender
{
	StartSession(@"ClassName", @"TeacherName", 100, 1, NO);
}

-(IBAction)OnStopSession:(id)sender
{
	StopSession();
}

-(IBAction)OnStartQuestion:(id)sender
{
	NSString *xx = [NSString stringWithFormat:@"Test Question \n a \n b \n c \n d \n  e"];
//	NSString *xx = [NSString stringWithFormat:@"Test Question  a  b  c"];
	StartQuestion(1, 1, 5, 1, xx, @"A"); 
}

-(IBAction)OnStopQuestion:(id)sender
{
	StopQuesiton();
}

@end
