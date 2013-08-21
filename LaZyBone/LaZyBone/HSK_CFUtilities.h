//
//  HSK_CFUtilities.h
//  Project
//
//  Created by Rushabh Mehta on 12/7/12.
//  Copyright (c) 2012 Rushabh Mehta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CFNetwork/CFNetwork.h>

void CFStreamCreatePairWithUNIXSocketPair(CFAllocatorRef alloc, CFReadStreamRef *readStream, CFWriteStreamRef *writeStream);
CFIndex CFWriteStreamWriteFully(CFWriteStreamRef outputStream, const uint8_t* buffer, CFIndex length);
