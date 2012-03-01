//
//  RootViewController.m
//  Next Train
//
//  Created by Peter Olsen on 02/14/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ViewController.h"
#import "StationViewController.h"
#import "AppDelegate.h"

@implementation ViewController

@synthesize fullStationDictionary = _fullStationDictionary;
@synthesize filteredStationDictionary = _filteredStationDictionary;
@synthesize fullSectionIndexTitles = _fullSectionIndexTitles;
@synthesize filteredSectionIndexTitles = _filteredSectionIndexTitles;
@synthesize lineImages = _lineImages;
@synthesize stationViewController = _stationViewController;

// Display a specific train station's information
-(void)pushStationViewController:(NSArray *)stationArray
						animated:(BOOL)animated
{
    if (self.stationViewController == nil) {
        self.stationViewController = [[StationViewController alloc]
                                      initWithNibName:@"StationViewController"
                                               bundle:nil];
    }
	self.stationViewController.stationArray = stationArray;
	[self.navigationController pushViewController:self.stationViewController
										 animated:animated];
}

#pragma mark - UIViewController methods

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Stations";
	
	// Load station information
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Metro"
													 ofType:@"plist"];
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
	self.fullStationDictionary = dict;
	NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]
										initWithCapacity:[dict count]];
	self.filteredStationDictionary = mutableDict;
	
	// Load index of station first initials
	NSMutableArray *indexes = [[NSMutableArray alloc] init];
	[indexes addObject:UITableViewIndexSearch];
	NSArray *keyArray = [[dict allKeys] 
						 sortedArrayUsingSelector:@selector(compare:)];
	[indexes addObjectsFromArray:keyArray];	
	self.fullSectionIndexTitles = indexes;
	
	// Load images for each train line
	dict = [[NSDictionary alloc]
			initWithObjectsAndKeys:
			[UIImage imageNamed:@"Blue.png"], @"Blue",
			[UIImage imageNamed:@"Green.png"], @"Green",
			[UIImage imageNamed:@"Orange.png"], @"Orange",
			[UIImage imageNamed:@"Red.png"], @"Red",
			[UIImage imageNamed:@"Yellow.png"], @"Yellow", nil];
	self.lineImages = dict;
	
	// Restore saved state, if any
	NSFileManager *fileManager = [NSFileManager defaultManager];
	AppDelegate *appDelegate =
		[[UIApplication sharedApplication] delegate];
	NSString *filePath = [appDelegate dataFilePath];
	if ([fileManager fileExistsAtPath:filePath]) {
		NSArray *stationArray = [[NSArray alloc] initWithContentsOfFile:filePath];
		if ([stationArray count] > 0)
			[self pushStationViewController:stationArray animated:NO];
	}
}

- (void)viewDidUnload {
    self.fullStationDictionary = nil;
    self.filteredStationDictionary = nil;
    self.fullSectionIndexTitles = nil;
    self.filteredSectionIndexTitles = nil;
    self.lineImages = nil;
    self.stationViewController = nil;
    [self viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (tableView == self.searchDisplayController.searchResultsTableView)
		return [self.filteredSectionIndexTitles count];
	else
		return [self.fullSectionIndexTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		NSString *sectionTitle = 
			[self.filteredSectionIndexTitles objectAtIndex:section];
		return [[self.filteredStationDictionary objectForKey:sectionTitle] count];
	} else {	
		NSString *sectionTitle = [self.fullSectionIndexTitles objectAtIndex:section];
		return [[self.fullStationDictionary objectForKey:sectionTitle] count];
	}
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	if (tableView == self.searchDisplayController.searchResultsTableView)
		return nil; // Don't display an index
	else
		return self.fullSectionIndexTitles;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"StationCell";
    
    UITableViewCell *cell =
		[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:CellIdentifier];
    }
	
	NSDictionary *dict;
	NSArray *titles;
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		dict = self.filteredStationDictionary;
		titles = self.filteredSectionIndexTitles;
	} else {
		dict = self.fullStationDictionary;
		titles = self.fullSectionIndexTitles;
	}
	
	// Populate the station name
	NSUInteger section = [indexPath section];
	NSUInteger row = [indexPath row];
	NSString *sectionTitle = [titles objectAtIndex:section];
	NSArray *sectionArray = [dict objectForKey:sectionTitle];
	NSArray *stationArray = [sectionArray objectAtIndex:row];	
	cell.textLabel.text = [stationArray objectAtIndex:kStationNameIndex];
	
	// Create and insert the train line images
	NSArray *lineArray = [stationArray objectAtIndex:kStationLineIndex];
	NSUInteger numberOfLines = [lineArray count];
	UIView *accessoryView =
		[[UIView alloc]
		 initWithFrame:CGRectMake(0.0, 0.0, 18.0 * numberOfLines, 16.0)];
	for (int i = 0; i < numberOfLines; i++) {
		NSString *lineName = [lineArray objectAtIndex:i];
		UIImage *lineImage = [self.lineImages objectForKey:lineName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:lineImage];
		imageView.frame = CGRectMake(18.0 * i, 0.0, 16.0, 16.0);
		[accessoryView addSubview:imageView];
	}
	cell.accessoryView = accessoryView;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
	NSString *result;

	if (tableView == self.searchDisplayController.searchResultsTableView)
		result = [self.filteredSectionIndexTitles objectAtIndex:section];
	else
		result = [self.fullSectionIndexTitles objectAtIndex:section];

	return (result == UITableViewIndexSearch) ? nil : result;
}

- (NSInteger)tableView:(UITableView *)tableView
sectionForSectionIndexTitle:(NSString *)title
			   atIndex:(NSInteger)index {
	if (title == UITableViewIndexSearch) {
		[tableView setContentOffset:CGPointZero animated:NO];
		return NSNotFound;
	} else
		return index;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Display the selected station's information
	NSDictionary *dict;
	NSArray *titles;
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		dict = self.filteredStationDictionary;
		titles = self.filteredSectionIndexTitles;
	} else {
		dict = self.fullStationDictionary;
		titles = self.fullSectionIndexTitles;
	}

	NSUInteger section = [indexPath section];
	NSUInteger row = [indexPath row];
	NSString *sectionTitle = [titles objectAtIndex:section];
	NSArray *sectionArray = [dict objectForKey:sectionTitle];
	NSArray *stationArray = [sectionArray objectAtIndex:row];
	[self pushStationViewController:stationArray animated:YES];
}

#pragma mark - UISearchDisplayDelegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self.filteredStationDictionary removeAllObjects];
	
	// Load up the stations that match the search string
	for (NSArray *letter in [self.fullStationDictionary allValues]) {
		NSMutableArray *searchLetter = [[NSMutableArray alloc] init];
		for (NSArray *station in letter) {
			NSString *name = [station objectAtIndex:kStationNameIndex];
			NSRange range = [name rangeOfString:searchString 
										options:NSCaseInsensitiveSearch |
												NSDiacriticInsensitiveSearch]; 
			if (range.location != NSNotFound)
				[searchLetter addObject:station];
		}
		if ([searchLetter count] > 0) {
			NSArray *firstStation = [searchLetter objectAtIndex:0];
			NSString *firstName = [firstStation objectAtIndex:kStationNameIndex];
			NSString *firstLetter = 
			[firstName substringWithRange:NSMakeRange(0, 1)];
			[self.filteredStationDictionary setObject:searchLetter forKey:firstLetter];
		}
	}	
	
	// Build the matching index (no UITableViewIndexSearch needed)
	NSArray *indexes = [[self.filteredStationDictionary allKeys]
						sortedArrayUsingSelector:@selector(compare:)];
	self.filteredSectionIndexTitles = indexes;

    return YES;
}

@end