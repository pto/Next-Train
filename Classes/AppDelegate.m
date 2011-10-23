//
//  Next_TrainAppDelegate.m
//  Next Train
//
//  Created by Peter Olsen on 02/14/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "StationViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

// Location to store the last station viewed
- (NSString *)dataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
														 NSUserDomainMask, YES);
	return [[paths lastObject] stringByAppendingPathComponent:kDataFilename];
}

// Save the current station information
- (void)saveStationArray
{
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

#pragma mark - UIApplicationDelegate methods

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *viewController = 
            [[ViewController alloc] initWithNibName:@"ViewController"
                                             bundle:nil];
    self.navigationController = 
            [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveStationArray];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self saveStationArray];
}

@end
