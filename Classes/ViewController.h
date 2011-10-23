//
//  RootViewController.h
//  Next Train
//
//  Created by Peter Olsen on 02/14/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

// The root controller is a Table View showing all the stations in the system.

#define kStationNameIndex 0
#define kStationIdIndex 1
#define kStationLineIndex 2

#define kDataFilename @"data.plist"

@interface ViewController : UITableViewController <UISearchDisplayDelegate>

@property (strong, nonatomic) NSDictionary *fullStationDictionary;
@property (strong, nonatomic) NSMutableDictionary *filteredStationDictionary;
@property (strong, nonatomic) NSArray *fullSectionIndexTitles;
@property (strong, nonatomic) NSArray *filteredSectionIndexTitles;
@property (strong, nonatomic) NSDictionary *lineImages;

- (void)pushStationViewController:(NSArray *)stationArray
						 animated:(BOOL)animated;
@end
