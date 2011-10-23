//
//  StationController.h
//  Next Train
//
//  Created by Peter Olsen on 02/14/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StationViewController : UIViewController <UIWebViewDelegate> 

@property (strong, nonatomic) NSArray *stationArray;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (void)refreshPage;

@end
