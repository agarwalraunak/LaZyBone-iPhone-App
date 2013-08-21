//
//  FourSquareCategory.m
//  GoogleMapPOC
//
//  Created by Lion User on 11/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "FourSquareCategory.h"

@implementation FourSquareCategory

@synthesize categoryID, name, icon;

- (FourSquareCategory *) initWithID:(NSString *)categoryID Name:(NSString *)name andIcon:(UIImage *)icon{
    self = [super init];
    self.categoryID = categoryID;
    self.name = name;
    self.icon = icon;
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
	[aCoder encodeObject:self.categoryID forKey:@"categoryID"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:UIImagePNGRepresentation(self.icon) forKey:@"icon"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super init]) {
		self.categoryID = [aDecoder decodeObjectForKey:@"categoryID"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.icon = [UIImage imageWithData:[aDecoder decodeObjectForKey:@"icon"]];
	}
	return self;
}


@end
