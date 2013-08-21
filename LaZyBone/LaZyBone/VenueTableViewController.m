//
//  VenueTableViewController.m
//  LaZyBone
//
//  Created by Lion User on 18/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "VenueTableViewController.h"
#import "AppDelegate.h"

@interface VenueTableViewController ()

@end

@implementation VenueTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(id)newDetailItem{
    _category = newDetailItem;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];;
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _currentLocation = appDelegate.currentLocation;
    _venues = [[FourSqAPI getInstance] getVenuesForCategory:_category Location:_currentLocation andRadius:5000];
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if ([self.searchDisplayController isActive])
        return _searchResult.count;
    return [_venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    

    
    UITableViewCell *cell = nil;
    if ([self.searchDisplayController isActive]){
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    // Configure the cell...
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    FourSquareVenue *venue = nil;
    
     @try {
        if ([self.searchDisplayController isActive])
            venue = [_searchResult objectAtIndex:indexPath.row];
        else
            venue = [_venues objectAtIndex:indexPath.row];
     }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", [exception reason]);
        return cell;
    }
    
    CLLocation *venueLocation = [[CLLocation alloc] initWithLatitude:venue.latitude longitude:venue.longitude];
    
    CLLocationDistance distance = [_currentLocation distanceFromLocation:venueLocation];
    
    cell.textLabel.text = venue.name;
    cell.textLabel.font = [UIFont fontWithName:@"Marker Felt" size:16];
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat: @"Likes: %d Distance: %g meters",venue.likes, distance];
    cell.detailTextLabel.textColor = [UIColor blueColor];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.searchDisplayController isActive])
        [self performSegueWithIdentifier:@"venueDetailSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = nil;
    FourSquareVenue *venue = nil;
    if ([self.searchDisplayController isActive]){
        indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        venue = [_searchResult objectAtIndex:indexPath.row];
    }
    else{
        indexPath = [self.tableView indexPathForSelectedRow];
        venue = [_venues objectAtIndex:indexPath.row];
    }
    [[segue destinationViewController] setDetailItem:venue];
}

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name contains[cd] %@", searchText];
    if (!_searchResult) {
        _searchResult = [[NSMutableArray alloc] init];
    }
    [_searchResult removeAllObjects];
    
    for (FourSquareVenue *venue in [_venues filteredArrayUsingPredicate:predicate]){
        [_searchResult addObject:venue];
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}


@end
