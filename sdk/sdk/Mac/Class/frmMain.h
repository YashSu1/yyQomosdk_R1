//
//  frmMain.h
//  QClickSDKDemo
//
//  Created by zheng kai on 11-1-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QInterface.h"

@interface frmMain : NSWindowController {

	IBOutlet NSTextField * txtModel;
	IBOutlet NSTextField * txtVersion;
	IBOutlet NSComboBox  * cmbChannel;
	IBOutlet NSButton  * btnSetChannel;
	IBOutlet NSButton  * btnInit;

}

-(IBAction)OnSetChannel:(id)sender;
-(IBAction)OnInit:(id)sender;
-(IBAction)OnStartSession:(id)sender;
-(IBAction)OnStopSession:(id)sender;
-(IBAction)OnStartQuestion:(id)sender;
-(IBAction)OnStopQuestion:(id)sender;

@end
