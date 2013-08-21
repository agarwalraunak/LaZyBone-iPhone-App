//
//  CategoryTableViewController.h
//  LaZyBone
//
//  Created by Lion User on 18/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>

@property(strong, nonatomic)NSMutableArray *categories;
@property(strong, nonatomic)NSMutableArray *searchResult;

@end
