//
//  Next_TrainAppDelegate.m
//  Next Train
//
//  Created by Peter Olsen on 02/14/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Next_TrainAppDelegate.h"
#import "RootViewController.h"
#import "StationViewController.h"

@implementation Next_TrainAppDelegate

@synthesize window;
@synthesize navigationController;

// Location to store the last station viewed
- (NSString *)dataFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
														 NSUserDomainMask, YES);
	return [[paths lastObject] stringByAppendingPathComponent:kDataFilename];
}

#pragma mark -
#pragma mark UIApplicationDelegate methods

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	if ([self.navigationController.topViewController
		 isMemberOfClass:[StationViewController class]]) {
		StationViewController *stationViewController =
			(StationViewController *)self.navigationController.topViewController;
		NSArray *stationArray = stationViewController.stationArray;
		[stationArray writeToFile:[self dataFilePath] atomically:YES];
	}
	else
		[[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath]
												   error:NULL];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self applicationWillTerminate:application];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
