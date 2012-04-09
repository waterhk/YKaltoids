//
//  RegistrationService.h
//  altoids
//
//  Created by Anand Subba Rao on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationTokenRetrieverDelegate.h"
#import "RegistrationVerifyTokenDelegate.h"
#import "RegistrationRenewDelegate.h"

@protocol RegistrationService <NSObject>

#pragma mark -
#pragma mark @required
@required
- (void)getTokenWithCountryCode:(NSString *)countryCode networkCode:(NSString *)networkCode
                   subscriberID:(NSString *)subscriberID delegate:(id<RegistrationTokenRetrieverDelegate>)delegate;
- (void)verifyToken:(NSString *)bindToken delegate:(id<RegistrationVerifyTokenDelegate>)delegate;
- (void)renewRegistrationWithPhoneNumber:(NSString *)phoneNumber delegate:(id<RegistrationRenewDelegate>)delegate;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
