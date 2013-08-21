//
//  NSData+Base64Additions.h
//  Project
//
//  Created by Rushabh Mehta on 12/7/12.
//  Copyright (c) 2012 Rushabh Mehta. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSData (Base64Additions)

+(id)decodeBase64ForString:(NSString *)decodeString;
+(id)decodeWebSafeBase64ForString:(NSString *)decodeString;

-(NSString *)encodeBase64ForData;
-(NSString *)encodeWebSafeBase64ForData;

@end
