//
//  NSStream+SKPSMTPExtensions.h
//  Project
//
//  Created by Rushabh Mehta on 12/7/12.
//  Copyright (c) 2012 Rushabh Mehta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CFNetwork/CFNetwork.h>

@interface NSStream (SKPSMTPExtensions)

+ (void)getStreamsToHostNamed:(NSString *)hostName port:(NSInteger)port inputStream:(NSInputStream **)inputStream outputStream:(NSOutputStream **)outputStream;

@end
