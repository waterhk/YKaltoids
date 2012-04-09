//
//  YAAddressTypeDetector.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAAddressTypeDetector.h"
#import "AddressHandler.h"
#import "YAAddress.h"
#import "YAEmailAddress.h"
#import "YAEmailAddressInfo.h"
#import "YAMMCAddress.h"
#import "YAMMCAddressInfo.h"
#import "YASMSAddress.h"
#import "YASMSAddressInfo.h"

@interface YAAddressTypeDetector()
{
    // These instance variables are used only to avoid repeatedly creating new transient string objects from the kMMCAddressType etc. string literals;
    // since only one instance of YAAddressTypeDetector is ever instantiated, this has no overhead.
    NSString* smsMMCAddressType;
    NSString* mmcMMCAddressType;
    NSString* emailMMCAddressType;
}
@end

@implementation YAAddressTypeDetector

@synthesize addressHandler = addressHandler_;
@synthesize invertedDecimalDigitCharacterSet = invertedDecimalDigitCharacterSet_;

- (id) init
{
    self = [super init];
    if(self)
    {
        mmcMMCAddressType = kMMCAddressType;
        smsMMCAddressType = kSMSAddressType;
        emailMMCAddressType = kEmailAddressType;
    }
    return self;
}

- (BOOL)isEmailAddress:(YAAddress *)theAddress
{
    return [addressHandler_ isEmailAddressType:theAddress];
}

- (BOOL)isEmailAddressInfo:(YAAddressInfo *)addressInfo
{
    return [addressInfo isKindOfClass:[YAEmailAddressInfo class]];
}

- (BOOL)isEmailMMCAddressType:(NSString *)addressType
{
    return [emailMMCAddressType isEqualToString:addressType];
}

- (BOOL)isMMCAddress:(YAAddress *)theAddress
{
    return [addressHandler_ isMMCAddressType:theAddress];
}

- (BOOL)isMMCAddressInfo:(YAAddressInfo *)addressInfo
{
    return [addressInfo isKindOfClass:[YAMMCAddressInfo class]];
}

- (BOOL)isMMCMMCAddressType:(NSString *)addressType
{
    return [mmcMMCAddressType isEqualToString:addressType];
}

- (BOOL)isSMSAddress:(YAAddress *)theAddress
{
    return [addressHandler_ isSMSAddressType:theAddress];
}

- (BOOL)isSMSAddressInfo:(YAAddressInfo *)addressInfo
{
    return [addressInfo isKindOfClass:[YASMSAddressInfo class]];
}

- (BOOL)isSMSMMCAddressType:(NSString *)addressType
{
    return [smsMMCAddressType isEqualToString:addressType];
}

- (BOOL)isMMCAddressWithEmailAddressHandle:(YAAddress *)theAddress
{
    return [self isMMCAddress:theAddress] && [self isEmailAddressHandle:[[self addressHandler] handleForAddress:theAddress]];
}

- (BOOL)isMMCAddressInfoWithEmailAddressHandle:(YAAddressInfo *)addressInfo
{
    return [self isMMCAddressInfo:addressInfo] && [self isEmailAddressHandle:[addressInfo handle]];
}

- (BOOL)isMMCAddressWithSMSAddressHandle:(YAAddress *)theAddress
{
    return [self isMMCAddress:theAddress] && [self isSMSAddressHandle:[[self addressHandler] handleForAddress:theAddress]];
}

- (BOOL)isMMCAddressInfoWithSMSAddressHandle:(YAAddressInfo *)addressInfo
{
    return [self isMMCAddressInfo:addressInfo] && [self isSMSAddressHandle:[addressInfo handle]];
}

- (BOOL)isEmailAddressHandle:(NSString *)handle
{
    return [handle length] > 0 && [handle rangeOfCharacterFromSet:[self invertedDecimalDigitCharacterSet]].location != NSNotFound;
}

- (BOOL)isSMSAddressHandle:(NSString *)handle
{
    return [handle length] > 0 && [handle rangeOfCharacterFromSet:[self invertedDecimalDigitCharacterSet]].location == NSNotFound;
}

@end
