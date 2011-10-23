//
//  StationController.m
//  Next Train
//
//  Created by Peter Olsen on 02/14/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StationViewController.h"
#import "ViewController.h"

@implementation StationViewController

@synthesize stationArray;
@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = [stationArray objectAtIndex:kStationNameIndex];
	[self refreshPage];
}

- (void)refreshPage {
	NSString *stationId = [stationArray objectAtIndex:kStationIdIndex];
	NSString *stationString =
	[[NSString alloc] initWithFormat:
	 @"http://www.wmata.com/rider_tools/pids/showpid.cfm?station_id=%@",
	 stationId];
	NSURL *stationUrl = [[NSURL alloc] initWithString:stationString];
	NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:stationUrl];
	[self.webView loadRequest:urlRequest];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	stationArray = nil;
	webView = nil;
}

#pragma mark UIWebViewDelegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
	// Display activity indicator
	UIActivityIndicatorView *activityIndicatorView =
	[[UIActivityIndicatorView alloc]
		initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[activityIndicatorView startAnimating];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]
									  initWithCustomView:activityIndicatorView];
	self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	// Display reload button
	UIBarButtonItem *barButtonItem =
		[[UIBarButtonItem alloc]
		 initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
		 target:self
		 action:@selector(refreshPage)];
	self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	NSString *message = [[NSString alloc]
						 initWithFormat:@"Cannot display: %@.",
						 error.localizedDescription];
	[self.webView loadHTMLString:message baseURL:nil];
}

@end
