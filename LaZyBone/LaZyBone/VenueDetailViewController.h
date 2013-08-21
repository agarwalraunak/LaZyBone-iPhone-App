//
//  VenueDetailViewController.h
//  LaZyBone
//
//  Created by Lion User on 19/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIUtil.h"
#import "FourSqAPI.h"
#import "GoogleMapsAPI.h"

@interface VenueDetailViewController : UIViewController <GMSMapViewDelegate>

@property(nonatomic, retain) UIUtil *uiUtil;
@property(nonatomic, strong) FourSquareVenue *venue;
//@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property(strong, nonatomic) GoogleMapsAPI *google;
@property (strong, nonatomic) IBOutlet UIButton *mapViewButton;


@end
