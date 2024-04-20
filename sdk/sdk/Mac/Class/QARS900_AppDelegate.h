//
//  QARS900_AppDelegate.h
//  QARS900
//
//  Created by Frank Lin on 5/1/09.
//  Copyright Qomo 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DeviceController;
@class QDevice;
@class DataOfFrame;
#import "Commdefs.h"




@interface QARS900_AppDelegate : NSResponder 
{
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
		
	DeviceController * deviceCtrl;
}

+ (QARS900_AppDelegate*)getAppDelegate;

- (QDevice*)currentDevice;
//- (DeviceType)currentDeviceType;
//- (void)setDeviceType:(DeviceType)newType;

- (void)setObjectToReceiveCommData:(id)object;
- (DataOfFrame *)frameToHandle;
- (void)signalConditionOfDataHandled;

@end
