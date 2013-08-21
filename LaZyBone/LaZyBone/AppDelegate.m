//
//  AppDelegate.m
//  LaZyBone
//
//  Created by Lion User on 12/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>
#import "UIUtil.h"
#import "FourSqAPI.h"

@implementation AppDelegate

@synthesize currentLocation = _currentLocation;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Navbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [GMSServices provideAPIKey:@"AIzaSyDyjSbCqYPb1ZpbzVpYVlbCRRcsW96yahE"];
    
    [Parse setApplicationId:@"McRInAgZBNlYM0YG4LTfN0Cn9zr8E60BAO1Jtxwc" clientKey:@"1KbThrrZ8Ov3asm5b9HoAxeaOi0kSemOgYW5Uqn9"];
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *HomeScreenViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeScreenViewController"];
        
        self.window.rootViewController = HomeScreenViewController;

    }
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager performSelectorInBackground:@selector(startUpdatingLocation) withObject:nil];

    
    dispatch_async(dispatch_get_global_queue(0, 0),^ {
        [self downloadFourSquareCategories];
    });
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splash.png"]];
    [self.window.rootViewController.view addSubview:imageView];
    [self.window.rootViewController.view bringSubviewToFront:imageView];
    
    [UIView transitionWithView:self.window duration:10.0f options:UIViewAnimationOptionTransitionNone animations:^(void){imageView.alpha=0.0f;} completion:^(BOOL finished){[imageView removeFromSuperview];}];


    return YES;
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    _currentLocation = [locations lastObject];
//    [_locationManager stopUpdatingLocation];
}

- (void) downloadFourSquareCategories{
    NSArray *categories = [[FourSqAPI getInstance] getCategories];
    [NSKeyedArchiver archiveRootObject:categories toFile:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/FourSquareCategories"]];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
