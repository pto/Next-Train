//
//  StationController.h
//  Next Train
//
//  Created by Peter Olsen on 02/14/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StationViewController : UIViewController <UIWebViewDelegate> {
	NSArray *stationArray;
	UIWebView *webView;
}

@property (nonatomic, retain) NSArray *stationArray;
@property (nonatomic, retain) IBOutlet UIWebView *webView;

- (void)refreshPage;

@end
