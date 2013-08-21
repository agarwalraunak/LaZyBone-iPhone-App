//
//  WallTableViewController.m
//  LaZyBone
//
//  Created by Lion User on 25/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "WallTableViewController.h"
#import <Parse/Parse.h>
#import "WallCustomCell.h"
#import "AppDelegate.h"

@interface WallTableViewController ()

@end

@implementation WallTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setDetailItem:(id) request{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];
    PFQuery *query = [PFQuery queryWithClassName:@"Request"];
    _objects = [query findObjects];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _currentLocation = appDelegate.currentLocation;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
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
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    WallCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell)
        cell = [[WallCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    PFObject *object = [_objects objectAtIndex:indexPath.row];
    
    float latitude = [[object valueForKey:@"latitude"] floatValue];
    float longitude = [[object valueForKey:@"longitude"] floatValue];
    
    CLLocation *venueLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    CLLocationDistance distance = [_currentLocation distanceFromLocation:venueLocation];
    
    NSString *venueName = [object valueForKey:@"venueName"];
    cell.venueNameLabel.text = venueName;
    cell.wageLabel.text = [[NSString alloc] initWithFormat:@"$%@", [object valueForKey:@"wage"]];
    cell.deliveryTimeLabel.text = [[NSString alloc] initWithFormat:@"Deliver By: %@",[object valueForKey:@"deliveryTime"]];
    cell.distanceLabel.text = [[NSString alloc] initWithFormat:@"%g m", distance];
    
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
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
    PFObject *object = [_objects objectAtIndex:indexpath.row];
    [[segue destinationViewController] setDetailItem:object];
}

@end
