//
//  MapViewController.m
//  LaZyBone
//
//  Created by Lion User on 26/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "MapViewController.h"
#import "GoogleMapsAPI.h"
#import "AppDelegate.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setVenue:(id)newDetailItem{
    _venue = newDetailItem;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    GoogleMapsAPI *google = [GoogleMapsAPI getInstance];
    
    CGRect newFrame = CGRectMake(0, 0, 276, 164);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CLLocation *currentLocation =  appDelegate.currentLocation;
    
    //[_mapView frame];
    
    NSLog(@"%f %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    NSLog(@"%f %f", _venue.longitude, _venue.latitude);
    
    
    _map = [google createMapViewWithTarget:CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude) withFrame:CGRectZero andZoom:12];
    
    _map.delegate = self;
    _map.myLocationEnabled = YES;
    _map.userInteractionEnabled = YES;
    self.view.userInteractionEnabled = YES;
    [google addMarkerOnMap:_map withLatitude:_venue.latitude Longitude:_venue.longitude Title:_venue.name andSnippet:nil];
    self.view = _map;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
