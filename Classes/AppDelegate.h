//
//  Next_TrainAppDelegate.h
//  Next Train
//
//  Created by Peter Olsen on 02/14/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> 

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

- (NSString *)dataFilePath;
- (void)saveStationArray;

@end
