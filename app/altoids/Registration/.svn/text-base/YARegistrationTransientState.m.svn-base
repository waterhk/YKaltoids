//
//  YARegistrationTransientState.m
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationTransientState.h"

#import "YARegistrationTransientStateInternals.h"

@implementation YARegistrationTransientState

- (NSString *)description
{
    return [NSString stringWithFormat:@"carrierIsSupported:%d\nverificationSmsSent:%d\nsmsVerificationFailed:%d\n"
                           "smsCommand:%@\nsmsShortCode:%@\ntoken:%@\nphoneNumber:%@\nmobileCountryCode:%@\nmobileNetworkCode:%@\nmobileSubscriberId:%@\n"
                       "expirationDate:%@\ntokenHasBeenValidated:%d\n", [[self carrierIsSupported] intValue],
            [self verificationSmsSent], [self smsVerificationFailed], [self smsCommand], [self smsShortCode], [self token], [self phoneNumber], 
            [self mobileCountryCode], [self mobileNetworkCode], [self mobileSubscriberId], [self expirationDate], [self tokenHasBeenValidated]];
}

@synthesize carrierIsSupported;
@synthesize registrationAborted;
@synthesize registrationCompleted;
@synthesize registrationFailed;
@synthesize smsVerificationFailed;
@synthesize tokenHasBeenValidated;
@synthesize verificationSmsSent;
@synthesize smsCommand;
@synthesize smsShortCode;
@synthesize token;
@synthesize phoneNumber;
@synthesize mobileCountryCode;
@synthesize mobileNetworkCode;
@synthesize mobileSubscriberId;
@synthesize currentViewControllerAccessor;
@synthesize expirationDate;

@end
