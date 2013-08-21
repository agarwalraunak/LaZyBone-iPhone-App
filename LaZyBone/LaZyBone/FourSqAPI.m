//
//  4sqAPI.m
//  4sqPOC
//
//  Created by Lion User on 11/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "FourSqAPI.h"

#import <CoreLocation/CoreLocation.h>
#import "MenuSection.h"
#import "MenuItem.h"

@implementation FourSqAPI

static FourSqAPI *instance;

+ (FourSqAPI *) getInstance{
    if (!instance){
        @synchronized([FourSqAPI class]){
            if (!instance)
                instance = [[FourSqAPI alloc] init];
        }
    }
    return instance;
}


static NSString *oauth_token = @"oauth_token=KOO3GZBI1FVT3YMYFVQWSOIYC3W2LQTC0ASKTKCTSJTQVZ4G&v=20130411";


- (NSMutableArray *) getCategories{
    
    NSMutableArray *categoriesResult = [[NSMutableArray alloc] init];
    
    NSString *url = [[NSString alloc] initWithFormat:@"https://api.foursquare.com/v2/venues/categories?%@", oauth_token];

    NSDictionary *jsonData = [self getJSONDataFromURL:url];

    NSDictionary *responseData = [jsonData objectForKey:@"response"];
    NSArray *categories = [responseData objectForKey:@"categories"];
    for (id category in categories){
        NSString *categoryName = (NSString *)[category objectForKey:@"name"];
        if ([categoryName isEqualToString:@"Food"]){
            for (id subCategory in [category objectForKey:@"categories"]){
                
                NSDictionary *iconDic = [subCategory objectForKey:@"icon"];
                NSMutableString *prefix = [iconDic objectForKey:@"prefix"];
                NSString *suffix = [iconDic objectForKey:@"suffix"];
                
                
                prefix = [prefix stringByReplacingCharactersInRange:NSMakeRange([prefix length] - 1, 1) withString:@""];
                
                NSString *icon = [[NSString alloc] initWithFormat:@"%@%@?%@", prefix, suffix, oauth_token];
                NSString *iconURLString = icon;
                NSURL *url = [[NSURL alloc] initWithString:iconURLString];
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:imageData];
                
                FourSquareCategory *fourSqCat = [[FourSquareCategory alloc] initWithID:[subCategory objectForKey:@"id"] Name:[subCategory objectForKey:@"name"] andIcon:image];
                [categoriesResult addObject:fourSqCat];
            }
            break;
        }
    }
    return categoriesResult;
}

- (NSMutableArray *) getVenuesForCategory: (FourSquareCategory *)category Location:(CLLocation *)location andRadius:(int)radius{
    
    //NSString *snellLongLat = @"42.33861,-71.08794";
    //ll=%@&query=Starbucks&limit=2&radius=1000
    if (!radius){
        radius = 1000;
    }
    
    NSMutableArray *venuesResult = [[NSMutableArray alloc] init];
    
    NSString *url = [[NSString alloc] initWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%f,%f&categoryId=%@&radius=%d&%@", location.coordinate.latitude, location.coordinate.longitude, category.categoryID, radius, oauth_token];
    
    NSDictionary *jsonData = [self getJSONDataFromURL:url];

    
    NSDictionary *responseData = [jsonData objectForKey:@"response"];
    NSArray *venues = [responseData objectForKey:@"venues"];
    for (id venue in venues){
        NSString *venueName = [venue objectForKey:@"name"];
        
        NSString *venueId = [venue objectForKey:@"id"];
        NSDictionary *location = [venue objectForKey:@"location"];
        float latitude = [[location objectForKey:@"lat" ] floatValue];
        float longitude = [[location objectForKey:@"lng"] floatValue];
        int likeCount = [self getLikesForVenue:venueId];
        
        FourSquareVenue *venue = [[FourSquareVenue alloc] initWithID:venueId Name:venueName Latitude:latitude Longitude:longitude andLikes:likeCount];
        [venuesResult addObject:venue];
        
    }
    return venuesResult;
}


- (NSMutableArray *) getMenuForVenue:(NSString *) venueID{
    NSMutableArray *menuSectionList = [[NSMutableArray alloc] init];
    
    NSString *url = [[NSString alloc] initWithFormat:@"https://api.foursquare.com/v2/venues/%@/menu?%@", venueID, oauth_token];
    
    NSDictionary *jsonData = [self getJSONDataFromURL:url];
    
    NSDictionary *responseData = [jsonData objectForKey:@"response"];
    NSLog(@"%d", [[responseData objectForKey:@"menu"] count]);
    NSArray *mainMenuItems = [[[responseData objectForKey:@"menu"] objectForKey:@"menus"] objectForKey:@"items"];
    for (id mainMenuItem in mainMenuItems){
        NSDictionary *menuSections = [[mainMenuItem objectForKey:@"entries"] objectForKey:@"items"];
        for (id section in menuSections){
            MenuSection *menuSection = [[MenuSection alloc] initWithSectionID:[section objectForKey:@"sectionId"] andSectionName:[section objectForKey:@"name"]];
            for (id item in [[section objectForKey:@"entries"] objectForKey:@"items"]){
                NSArray *responsePrices = [item objectForKey:@"prices"];
                if (responsePrices.count == 0){
                    continue;
                }
                NSString *price = [[NSString alloc] initWithFormat:@"%@",responsePrices[0]];
                NSString *entryID = [item objectForKey:@"entryId"];
                NSString *name = [item objectForKey:@"name"];
                NSString *description = [item objectForKey:@"description"];
                MenuItem *menuItem = [[MenuItem alloc] initWithItemID:entryID itemName:name Price:price andDescription:description];
                
                [menuSection.menuItems addObject:menuItem];
            }
            [menuSectionList addObject:menuSection];
        }
    }
    return menuSectionList;
}

- (NSMutableArray *) getPicturesForVenue:(NSString *)venueID{
    NSMutableArray *pictureURLs = [[NSMutableArray alloc] init];
    
    NSString *url = [[NSString alloc] initWithFormat:@"https://api.foursquare.com/v2/venues/%@/photos?group=venue&%@", venueID,oauth_token];
    
    NSDictionary *jsonData = [self getJSONDataFromURL:url];
    
    NSArray *photos = [[[jsonData objectForKey:@"response"] objectForKey:@"photos"] objectForKey:@"items"];
    
    for (id photo in photos){
        NSString *prefix = [photo objectForKey:@"prefix"];
        NSString *suffix = [photo objectForKey:@"suffix"];
        NSString *picture = [[NSString alloc] initWithFormat:@"%@%@%@", prefix, @"original", suffix];
        [pictureURLs addObject:picture];
    }
    return pictureURLs;
}

- (int) getLikesForVenue:(NSString *)venueID{

    NSString *url = [[NSString alloc] initWithFormat:@"https://api.foursquare.com/v2/venues/%@/likes?%@", venueID,oauth_token];
    
    NSDictionary *jsonData = [self getJSONDataFromURL:url];
    int count = [[[[jsonData objectForKey:@"response"] objectForKey:@"likes"] objectForKey:@"count"] intValue];
    
    return count;
}

- (NSDictionary *) getJSONDataFromURL:(NSString *)url{
    
    NSMutableData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSError *error = nil;
    NSDictionary *jsonData = nil;
    if (data != nil)
        jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    return jsonData;
}

- (float) parseIntValueOfPrice:(NSString *)price{
    
    NSString *numberString;
  
    NSScanner *scanner = [NSScanner scannerWithString:price];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
    
    // Throw away characters before the first number.
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    
    // Collect numbers.
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    
    // Result.
    float number = [numberString floatValue];

    return number;

}


@end






