//
//  Next_TrainAppDelegate.h
//  Next Train
//
//  Created by Peter Olsen on 02/14/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@interface Next_TrainAppDelegate : NSObject <UIApplicationDelegate> {    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (NSString *)dataFilePath;

@end
