//
//  FourSquareCategory.h
//  GoogleMapPOC
//
//  Created by Lion User on 11/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FourSquareCategory : NSObject<NSCoding>

@property(nonatomic, strong) NSString *categoryID;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) UIImage *icon;

- (FourSquareCategory *) initWithID:(NSString *)categoryID Name:(NSString *)name andIcon:(UIImage *)icon;

@end
