//
//  YAAddressHandleFormatter.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YASMSAddressHandleFormatter.h"
#import "AddressHandler.h"

@implementation YASMSAddressHandleFormatter

@synthesize addressHandler = addressHandler_;


- (NSString *)formatAddressHandleForDisplay:(YAAddress *)theAddress
{
    return [addressHandler_ handleForAddress:theAddress];
}

- (NSString *)formatAddressHandleForServerRequest:(YAAddress *)theAddress
{
    return [NSString stringWithFormat:@"%@:%@", kSMSAddressType, [addressHandler_ handleForAddress:theAddress]];
}

@end
