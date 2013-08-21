//
//  VenueDetailViewController.m
//  LaZyBone
//
//  Created by Lion User on 19/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "VenueDetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AppDelegate.h"
#import "MapViewController.h"

@interface VenueDetailViewController ()

@end

@implementation VenueDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(id)newDetailItem{
    _venue = newDetailItem;
}

- (void) setVenue:(id)venue{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _uiUtil = [UIUtil getInstance];
    _google = [GoogleMapsAPI getInstance];
    
    [_uiUtil beautifyViewBackground:self.view];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CLLocation *currentLocation =  appDelegate.currentLocation;
    
//    CGRect frame = [_mapViewButton convertRect:_mapViewButton.bounds toView:self.view];
    CGRect newFrame = CGRectMake(0, 0, 276, 164);
    
    //[_mapView frame];
    
    NSLog(@"%f %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    NSLog(@"%f %f", _venue.longitude, _venue.latitude);
    
    GMSMapView *map = [_google createMapViewWithTarget:CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude) withFrame:newFrame andZoom:12];

    map.delegate = self;
    map.myLocationEnabled = YES;
    map.userInteractionEnabled = NO;
    [_google addMarkerOnMap:map withLatitude:_venue.latitude Longitude:_venue.longitude Title:_venue.name andSnippet:nil];
    _mapViewButton.userInteractionEnabled = YES;
    [_mapViewButton addSubview:map];
    
    for (UIView *view in [self.view subviews])
        [_uiUtil addShadowToView:view];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"MapSegue"]){
        [[segue destinationViewController] setVenue:_venue];
    }
    else{
        [[segue destinationViewController] setDetailItem:_venue];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end









