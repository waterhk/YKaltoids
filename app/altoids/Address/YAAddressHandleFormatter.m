//
//  YAAddressHandleFormatter.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAAddressHandleFormatter.h"
#import "AddressHandleFormatter.h"
#import "AddressNormalizer.h"
#import "AddressTypeDetector.h"
#import "YAAddress.h"

@implementation YAAddressHandleFormatter

@synthesize addressTypeDetector = addressTypeDetector_,
            addressNormalizer = addressNormalizer_,
            smsAddressHandleFormatter = smsAddressHandleFormatter_,
            emailAddressHandleFormatter = emailAddressHandleFormatter_;



- (id<AddressHandleFormatter>) addressHandleFormatterForAddress:(YAAddress*)address
{
    if([[self addressTypeDetector] isSMSAddress:address] || [[self addressTypeDetector] isMMCAddressWithSMSAddressHandle:address])
    {
        return smsAddressHandleFormatter_;
    }

    if([[self addressTypeDetector] isEmailAddress:address] || [[self addressTypeDetector] isMMCAddressWithEmailAddressHandle:address])
    {
        return emailAddressHandleFormatter_;
    }
    
    return nil;
}

- (NSString*) formatAddressHandleForDisplay:(YAAddress*)address
{
    return [[self addressHandleFormatterForAddress:address] formatAddressHandleForDisplay:address];
}

- (NSString*) formatAddressHandleForServerRequest:(YAAddress*)address
{
    return [[self addressHandleFormatterForAddress:address] formatAddressHandleForServerRequest:address];
}

@end
