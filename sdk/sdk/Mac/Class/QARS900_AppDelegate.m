//
//  QARS900_AppDelegate.m
//  QARS900
//
//  Created by Frank Lin on 5/1/09.
//  Copyright Qomo 2009 . All rights reserved.
//

#import "QARS900_AppDelegate.h"
#import "DeviceController.h"
#import "DataOfFrame.h"

static QARS900_AppDelegate* pAppDelegate = nil;

@implementation QARS900_AppDelegate

-(id)init															
{
	[super init];
	
	deviceCtrl = [DeviceController ShareDeviceController];
	
	return self;
}

+ (QARS900_AppDelegate*)getAppDelegate
{
	return pAppDelegate;
}


- (QDevice*)currentDevice
{
	return [deviceCtrl currentDevice];
}

//- (DeviceType)currentDeviceType
//{
//	return [deviceCtrl currentDeviceType];
//}

/*
- (void)setDeviceType:(DeviceType)newType
{
	[deviceCtrl setDeviceType:newType];
}
*/


/*
    Returns the support folder for the application, used to store the Core Data
    store file.  This code uses a folder named "QARS900" for
    the content, either in the NSApplicationSupportDirectory location or (if the
    former cannot be found), the system's temporary directory.
 */

- (NSString *)applicationSupportFolder {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"QARS900"];
}

/**
    Creates, retains, and returns the managed object model for the application 
    by merging all of the models found in the application bundle.
 */
 
/*
- (NSManagedObjectModel *)managedObjectModel {

    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
	
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}
*/



/**
    Returns the NSUndoManager for the application.  In this case, the manager
    returned is that of the managed object context for the application.
 */
 
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
//    return [[self managedObjectContext] undoManager];
	return nil;
}


/**
    Performs the save action for the application, which is to send the save:
    message to the application's managed object context.  Any encountered errors
    are presented to the user.
 */
 
- (IBAction) saveAction:(id)sender
{

    NSError *error = nil;
//    if (![[self managedObjectContext] save:&error])
	{
        [[NSApplication sharedApplication] presentError:error];
    }
}


/**
    Implementation of the applicationShouldTerminate: method, used here to
    handle the saving of changes in the application managed object context
    before the application terminates.
 */
 
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    NSError *error;
    int reply = NSTerminateNow;
    
    if (managedObjectContext != nil)
	{
        if ([managedObjectContext commitEditing])
		{
            if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
			{
				
                // This error handling simply presents error information in a panel with an 
                // "Ok" button, which does not include any attempt at error recovery (meaning, 
                // attempting to fix the error.)  As a result, this implementation will 
                // present the information to the user and then follow up with a panel asking 
                // if the user wishes to "Quit Anyway", without saving the changes.

                // Typically, this process should be altered to include application-specific 
                // recovery steps.  

                BOOL errorResult = [[NSApplication sharedApplication] presentError:error];
				
                if (errorResult == YES)
				{
                    reply = NSTerminateCancel;
                } 

                else 
				{
                    int alertReturn = NSRunAlertPanel(nil, @"Couldn't save changes while quitting. Quit anyway?" , @"Quit anyway", @"Cancel", nil);
                    if (alertReturn == NSAlertAlternateReturn)
					{
                        reply = NSTerminateCancel;	
                    }
                }
            }
        }
        else
		{
            reply = NSTerminateCancel;
        }
    }
    
    return reply;
}


/**
    Implementation of dealloc, to release the retained variables.
 */
 
- (void) dealloc
{
	[deviceCtrl release], deviceCtrl = nil;
    [managedObjectContext release], managedObjectContext = nil;
    [persistentStoreCoordinator release], persistentStoreCoordinator = nil;
    [managedObjectModel release], managedObjectModel = nil;
    [super dealloc];
}

- (void)setObjectToReceiveCommData:(id)object
{
	[deviceCtrl setDelegateOfPort:object];
}

- (DataOfFrame *)frameToHandle
{
	return [[[deviceCtrl frameToHandle] retain] autorelease];
}

- (void)signalConditionOfDataHandled
{
	[deviceCtrl signalConditionOfDataHandled];
}


@end


@implementation QARS900_AppDelegate (NSApplicationDelegateMethods)

// Suppress default behavior of opening an "Untitled" browser on launch.
- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
    return NO;
}

// Auto-open a browser on launch.
- (void)applicationDidFinishLaunching:(NSNotification *)notification 
{
//	isLogin = FALSE;
//	pAppDelegate = self;
//
//	NSImage * appIcon = [NSImage imageNamed:@"tabctrl"];
//	[NSApp setApplicationIconImage:appIcon];
//	[self openMainWindow: self];
}





@end

