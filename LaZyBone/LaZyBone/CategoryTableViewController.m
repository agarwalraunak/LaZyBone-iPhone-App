//
//  CategoryTableViewController.m
//  LaZyBone
//
//  Created by Lion User on 18/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "FourSqAPI.h"

@interface CategoryTableViewController ()

@end

@implementation CategoryTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(id)newDetailItem
{
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];;
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _categories = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/FourSquareCategories"]];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];
//    self.hidesBottomBarWhenPushed = YES;
    
//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];
    // Uncomment the following line to preserve selection between presentations.
//    self.clearsSelectionOnViewWillAppear = YES;
 
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
    if ([self.searchDisplayController isActive]){
        return _searchResult.count;
    }
    return _categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    if ([self.searchDisplayController isActive])
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    else
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    FourSquareCategory *category = nil;
    @try {
        if ([self.searchDisplayController isActive])
            category = [_searchResult objectAtIndex:indexPath.row];
        else
            category = [_categories objectAtIndex:indexPath.row];

    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception: %@", [exception reason]);
        return cell;
        
    }
    cell.textLabel.text = category.name;
    cell.textLabel.font = [UIFont fontWithName:@"Marker Felt" size:16];
    cell.imageView.image = category.icon;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if ([self.searchDisplayController isActive])
        [self performSegueWithIdentifier:@"showVenuesForCategory" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = nil;
    FourSquareCategory *category = nil;
    if ([self.searchDisplayController isActive]){
        indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        category = [_searchResult objectAtIndex:indexPath.row];
    }
    else{
        indexPath = [self.tableView indexPathForSelectedRow];
        category = [_categories objectAtIndex:indexPath.row];
    }
    [[segue destinationViewController] setDetailItem:category];
}

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name contains[cd] %@", searchText];
    if (!_searchResult) {
        _searchResult = [[NSMutableArray alloc] init];
    }
    [_searchResult removeAllObjects];
        
    for (FourSquareCategory *category in [_categories filteredArrayUsingPredicate:predicate]){
        [_searchResult addObject:category];
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

@end
