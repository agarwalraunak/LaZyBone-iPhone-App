//
//  GoogleMapsAPI.m
//  GoogleMapPOC
//
//  Created by Lion User on 11/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "GoogleMapsAPI.h"


@implementation GoogleMapsAPI

static GoogleMapsAPI *instance;

+ (GoogleMapsAPI *) getInstance{
    if (!instance){
        @synchronized([GoogleMapsAPI class]){
            if (!instance){
                instance = [[GoogleMapsAPI alloc] init];
            }
        }
    }
    return instance;
}


- (GMSMapView *)createMapViewWithTarget:(CLLocationCoordinate2D) target withFrame:(CGRect)frame andZoom:(int)zoom{
//    mapView_.myLocationEnabled = YES;
//    mapView_.delegate = self;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:target zoom:zoom];
    GMSMapView *gmsMapView = [GMSMapView mapWithFrame:frame camera:camera];
    return gmsMapView;
}

- (void) addMarkerOnMap:(GMSMapView *)mapView withLatitude:(float)latitude Longitude:(float)longitude Title:(NSString *)title andSnippet:(NSString *)snippet{
    GMSMarkerOptions *options = [[GMSMarkerOptions alloc] init];
    options.position = CLLocationCoordinate2DMake(latitude, longitude);
    options.title = title;
    options.snippet = snippet;
    [mapView addMarkerWithOptions:options];
}

- (void) addOverlayToMapView:(GMSMapView *)mapView withIcon:(UIImage *)icon Position:(CLLocationCoordinate2D)position Bearing:(float)bearing Zoom:(float)zoom {
    GMSGroundOverlayOptions *overlayOptions = [GMSGroundOverlayOptions options];
    overlayOptions.icon = icon;
    overlayOptions.position = position;
    overlayOptions.bearing = bearing;
    overlayOptions.zoomLevel = zoom;
    [mapView addGroundOverlayWithOptions:overlayOptions];
}



- (void) api{
    GMSMapView *mapView_;
    CLLocationCoordinate2D newark = CLLocationCoordinate2DMake(40.742, -74.174);
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:newark
                                                               zoom:12];
    
    GMSGroundOverlayOptions *overlayOptions = [GMSGroundOverlayOptions options];
    overlayOptions.icon = [UIImage imageNamed:@"images.jpeg"];
    overlayOptions.position = newark;
    overlayOptions.bearing = 0;
    overlayOptions.zoomLevel = 13.6;
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    [mapView_ addGroundOverlayWithOptions:overlayOptions];
//    mapView_.delegate = self;
//    self.view = mapView_;
    
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.delegate = self;
//    self.view = mapView_;
    
    GMSMarkerOptions *options = [[GMSMarkerOptions alloc] init];
    options.position = CLLocationCoordinate2DMake(-33.8683, 151.20);
    options.title = @"Sydney";
    options.snippet = @"Australia";
    [mapView_ addMarkerWithOptions:options];
    
    GMSPolylineOptions *rectangle = [GMSPolylineOptions options];
    
    GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:CLLocationCoordinate2DMake(37.35, -122.0)];
    [path addCoordinate:CLLocationCoordinate2DMake(37.45, -122.0)];
    [path addCoordinate:CLLocationCoordinate2DMake(37.45, -122.2)];
    [path addCoordinate:CLLocationCoordinate2DMake(37.35, -122.2)];
    [path addCoordinate:CLLocationCoordinate2DMake(37.35, -122.0)];
    rectangle.path = path;
    [mapView_ addPolylineWithOptions:rectangle];
}

@end
