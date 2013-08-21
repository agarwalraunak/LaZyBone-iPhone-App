//
//  NSStream+SKPSMTPExtensions.m
//  Project
//
//  Created by Rushabh Mehta on 12/7/12.
//  Copyright (c) 2012 Rushabh Mehta. All rights reserved.
//


#import "NSStream+SKPSMTPExtensions.h"


@implementation NSStream (SKPSMTPExtensions)

+ (void)getStreamsToHostNamed:(NSString *)hostName port:(NSInteger)port inputStream:(NSInputStream **)inputStream outputStream:(NSOutputStream **)outputStream
{
    CFHostRef           host;
    CFReadStreamRef     readStream;
    CFWriteStreamRef    writeStream;
    
    readStream = NULL;
    writeStream = NULL;
    
    host = CFHostCreateWithName(NULL, (__bridge CFStringRef) hostName);
    if (host != NULL)
    {
        (void) CFStreamCreatePairWithSocketToCFHost(NULL, host, port, &readStream, &writeStream);
        CFRelease(host);
    }
    
    if (inputStream == NULL)
    {
        if (readStream != NULL)
        {
            CFRelease(readStream);
        }
    }
    else
    {
        *inputStream = (__bridge NSInputStream *) readStream ;
    }
    if (outputStream == NULL)
    {
        if (writeStream != NULL)
        {
            CFRelease(writeStream);
        }
    }
    else
    {
        *outputStream = (__bridge NSOutputStream *) writeStream;
    }
}

@end