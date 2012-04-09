//
//  YASMSAddressNormalizer.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YASMSAddressNormalizer.h"
#import "AddressHandler.h"
#import "PhoneNumberNormalizer.h"
#import "YAAddress.h"

@implementation YASMSAddressNormalizer

@synthesize addressHandler = addressHandler_,
            phoneNumberNormalizer = phoneNumberNormalizer_;


- (NSString *)normalizeAddress:(YAAddress *)theAddress
{
    if (!theAddress) 
    {
        return nil;
    }
    
    NSString *addressHandle = [addressHandler_ handleForAddress:theAddress];
    
    if (!addressHandle) 
    {
        return nil;
    }
    
    return [phoneNumberNormalizer_ ye164FormatForPhoneNumber:addressHandle];
}

@end
