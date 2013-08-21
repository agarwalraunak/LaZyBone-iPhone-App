//
//  GoogleMapsAPI.h
//  GoogleMapPOC
//
//  Created by Lion User on 11/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface GoogleMapsAPI : NSObject

+ (GoogleMapsAPI *) getInstance;
- (GMSMapView *)createMapViewWithTarget:(CLLocationCoordinate2D) target withFrame:(CGRect)frame andZoom:(int)zoom;
- (void) addMarkerOnMap:(GMSMapView *)mapView withLatitude:(float)latitude Longitude:(float)longitude Title:(NSString *)title andSnippet:(NSString *)snippet;
- (void) addOverlayToMapView:(GMSMapView *)mapView withIcon:(UIImage *)icon Position:(CLLocationCoordinate2D)position Bearing:(float)bearing Zoom:(float)zoom;

@end
