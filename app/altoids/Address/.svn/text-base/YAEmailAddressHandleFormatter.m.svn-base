//
//  YAEmailAddressHandleFormatter.m
//  altoids
//
//  Created by Jon Herron on 11/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAEmailAddressHandleFormatter.h"
#import "AddressHandler.h"

@implementation YAEmailAddressHandleFormatter

@synthesize addressHandler = addressHandler_;

- (NSString *)formatAddressHandleForDisplay:(YAAddress *)theAddress
{
    if (!theAddress) 
    {
        return nil;
    }
    
    return [[self addressHandler] handleForAddress:theAddress];
}

- (NSString *)formatAddressHandleForServerRequest:(YAAddress *)theAddress
{
    if (!theAddress) 
    {
        return nil;
    }
    
    return [NSString stringWithFormat:@"%@:%@", kEmailAddressType, [[self addressHandler] handleForAddress:theAddress]];
}

@end
