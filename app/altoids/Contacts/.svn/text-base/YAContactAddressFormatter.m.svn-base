//
//  YAContactAddressFormatter.m
//  altoids
//
//  Created by Derrick Whittle on 2/21/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactAddressFormatter.h"
#import "ContactAddressLabelFormatter.h"
#import "YAContactAddress.h"
#import "YAContactPhoneNumberAddress.h"

@implementation YAContactAddressFormatter

@synthesize contactAddressLabelFormatter = contactAddressLabelFormatter_;


- (NSString*) formattedAddressAndLabel:(YAContactAddress*)address
{
    // I don't like inspecting the class and casting... but don't have a better idea right now
    // We could consider making a generic (YAContactAddress-declared) accessor for the address "string", but I'm not crazy about that either -- that's really this formatter's job, not the value object's.
    if([address isKindOfClass:[YAContactPhoneNumberAddress class]])
    {
        YAContactPhoneNumberAddress* phoneNumberAddress = (YAContactPhoneNumberAddress*)address;
        return [NSString stringWithFormat:@"%@ (%@)", [phoneNumberAddress displayPhoneNumber], [contactAddressLabelFormatter_ formattedLabelForAddress:phoneNumberAddress]];
    }
    
    return @"";
}

@end
