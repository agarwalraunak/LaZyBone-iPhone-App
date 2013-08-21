//
//  Base64Transcoder.h
//  Project
//
//  Created by Rushabh Mehta on 12/7/12.
//  Copyright (c) 2012 Rushabh Mehta. All rights reserved.
//

#include <UIKit/UIKit.h>

extern size_t EstimateBas64EncodedDataSize(size_t inDataSize);
extern size_t EstimateBas64DecodedDataSize(size_t inDataSize);

extern bool Base64EncodeData(const void *inInputData, size_t inInputDataSize, char *outOutputData, size_t *ioOutputDataSize);
extern bool Base64DecodeData(const void *inInputData, size_t inInputDataSize, void *ioOutputData, size_t *ioOutputDataSize);