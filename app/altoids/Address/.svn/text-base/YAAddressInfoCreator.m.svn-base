//
//  YAAddressInfoCreator.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAAddressInfoCreator.h"
#import "AddressHandler.h"
#import "AddressTypeDetector.h"
#import "PhoneNumberNormalizer.h"
#import "YAAddressInfo.h"
#import "YASMSAddressInfo.h"
#import "YAMMCAddressInfo.h"
#import "YAEmailAddressInfo.h"
#import "YAAddress.h"
#import "YAMMCParticipant.h"

@implementation YAAddressInfoCreator

@synthesize addressHandler = addressHandler_,
            addressTypeDetector = addressTypeDetector_,
            phoneNumberNormalizer = phoneNumberNormalizer_;


- (YAAddressInfo*) addressInfoWithNormalizedSMSHandle:(NSString*)normalizedSMSHandle
{
    return [[YASMSAddressInfo alloc] initWithYE164PhoneNumber:normalizedSMSHandle];
}

- (YAAddressInfo*) addressInfoWithNormalizedMMCHandle:(NSString*)normalizedMMCHandle
{
    return [[YAMMCAddressInfo alloc] initWithNormalizedMMCAddress:normalizedMMCHandle];
}

- (YAAddressInfo*) addressInfoWithNormalizedEmailHandle:(NSString*)normalizedEmailHandle
{
    return [[YAEmailAddressInfo alloc] initWithNormalizedEmailAddress:normalizedEmailHandle];
}


- (YAAddressInfo*) addressInfoWithAddress:(YAAddress*)address
{
    if([addressTypeDetector_ isSMSAddress:address])
    {
        return [self addressInfoWithNormalizedSMSHandle:[addressHandler_ handleForAddress:address]];
    }

    if([addressTypeDetector_ isMMCAddress:address])
    {
        return [self addressInfoWithNormalizedMMCHandle:[addressHandler_ handleForAddress:address]];
    }

    if([addressTypeDetector_ isEmailAddress:address])
    {
        return [self addressInfoWithNormalizedEmailHandle:[addressHandler_ handleForAddress:address]];
    }

    return nil;
}

- (YAAddressInfo*) addressInfoWithMMCParticipant:(YAMMCParticipant*)mmcParticipant
{
    NSString* addressType = [mmcParticipant addressType];

    if([addressTypeDetector_ isSMSMMCAddressType:addressType])
    {
        return [self addressInfoWithNormalizedSMSHandle:[mmcParticipant address]];
    }
    
    if([addressTypeDetector_ isMMCMMCAddressType:addressType])
    {
        return [self addressInfoWithNormalizedMMCHandle:[mmcParticipant address]];
    }
    
    if([addressTypeDetector_ isEmailMMCAddressType:addressType])
    {
        return [self addressInfoWithNormalizedEmailHandle:[mmcParticipant address]];
    }

    return nil;
}

- (YAAddressInfo*) addressInfoWithRawPhoneNumber:(NSString*)rawPhoneNumber
{
    return [self addressInfoWithNormalizedSMSHandle:[phoneNumberNormalizer_ ye164FormatForPhoneNumber:rawPhoneNumber]];
}

- (YAAddressInfo*) addressInfoWithYE164PhoneNumber:(NSString*)ye164PhoneNumber
{
    return [self addressInfoWithNormalizedSMSHandle:ye164PhoneNumber];
}


@end
