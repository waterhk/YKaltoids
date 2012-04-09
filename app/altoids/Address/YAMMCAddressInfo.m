//
//  YAMMCAddressInfo.m
//  altoids
//
//  Created by Jon Herron on 11/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMMCAddressInfo.h"

@implementation YAMMCAddressInfo
@synthesize handle = handle_;

- (id) initWithNormalizedMMCAddress:(NSString*)normalizedMMCAddress
{
    self = [super init];
    if(self)
    {
        handle_ = normalizedMMCAddress;
    }
    
    return self;
}

@end
