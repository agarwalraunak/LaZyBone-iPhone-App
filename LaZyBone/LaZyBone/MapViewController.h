//
//  MapViewController.h
//  LaZyBone
//
//  Created by Lion User on 26/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourSquareVenue.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController : UIViewController <GMSMapViewDelegate>


@property (nonatomic, strong) FourSquareVenue *venue;

@property (strong, nonatomic) GMSMapView *map;

@end
