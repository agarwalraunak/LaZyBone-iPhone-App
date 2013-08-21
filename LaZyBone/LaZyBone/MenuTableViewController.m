//
//  MenuTableViewController.m
//  LaZyBone
//
//  Created by Lion User on 22/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "MenuTableViewController.h"
#import "OrderItemViewController.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void)setDetailItem:(id)newDetailItem{
    _venue = newDetailItem;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];;
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FourSqAPI *fourSquare = [FourSqAPI getInstance];
    _menuSectionList = [fourSquare getMenuForVenue:_venue.venueID];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
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
    return [_menuSectionList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[[_menuSectionList objectAtIndex:section] menuItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    MenuSection *menuSection = [_menuSectionList objectAtIndex:indexPath.section];
    NSMutableArray *menuItems = menuSection.menuItems;
    MenuItem *menuItem = [menuItems objectAtIndex:indexPath.row];
    cell.textLabel.text = menuItem.itemName;
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"Price : %@", menuItem.price];
    cell.detailTextLabel.textColor = [UIColor blueColor];
    
    return cell;
}


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

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    MenuSection *menuSection = [_menuSectionList objectAtIndex:section];
    return menuSection.sectionName;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqual:@"orderItemSegue"]){
        NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
        MenuSection *menuSection = [_menuSectionList objectAtIndex:indexpath.section];
        MenuItem *menuItem = [menuSection.menuItems objectAtIndex:indexpath.row];
        [[segue destinationViewController] setDetailItem:menuItem venue:(id)_venue];
    }
}

@end
