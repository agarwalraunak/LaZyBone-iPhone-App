//
//  ServerRequest.h
//  LaZyBone
//
//  Created by Lion User on 24/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerRequest : NSObject

@property(nonatomic, strong) NSString *venueName;
@property(nonatomic, strong) NSString *latitude;
@property(nonatomic, strong) NSString *longitude;
@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *delAddress;
@property(nonatomic, strong) NSString *orderItems; //name||price||quantity,...

@end
