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

@interface RootViewController : UITableViewController 
		<UISearchDisplayDelegate> {
	NSDictionary		*fullStationDictionary;
	NSMutableDictionary *filteredStationDictionary;
	NSArray				*fullSectionIndexTitles;
	NSArray				*filteredSectionIndexTitles;
	NSDictionary		*lineImages;
}

@property (nonatomic, retain) NSDictionary *fullStationDictionary;
@property (nonatomic, retain) NSMutableDictionary *filteredStationDictionary;
@property (nonatomic, retain) NSArray *fullSectionIndexTitles;
@property (nonatomic, retain) NSArray *filteredSectionIndexTitles;
@property (nonatomic, retain) NSDictionary *lineImages;

- (void)pushStationViewController:(NSArray *)stationArray
						 animated:(BOOL)animated;
@end
