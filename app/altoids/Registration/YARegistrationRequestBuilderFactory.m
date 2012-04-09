//
//  YARegistrationRequestBuilderFactory.m
//  altoids
//
//  Created by Lei Cai on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationRequestBuilderFactory.h"

#import <SBJson/SBJson.h>
// Private class extension
@interface YARegistrationRequestBuilderFactory ()

// @property definitions

// methods

@end

@implementation YARegistrationRequestBuilderFactory
// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize serverConfiguration = serverConfiguration_;
@synthesize authInfoProvider = authInfoProvider_;

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods
- (NSURLRequest *)buildGetTokenRequestWithMCC:(NSString*)mcc andMNC:(NSString*)mnc andMSID:(NSString*)msid
{
    NSURL *requestUrl = [[self authInfoProvider] buildURLWithScheme:@"http" server:[[self serverConfiguration] registrationServer]
                                                        relativeURI:@"mmc/reg/v1/bindToken"
                                                             params:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     @"getToken", @"action",
                                                                     mcc, @"mcc",
                                                                     mnc, @"mnc",
                                                                     [[self serverConfiguration] mmcServiceName], @"service",
                                                                     nil]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [urlRequest setHTTPMethod:@"GET"];
    [[self authInfoProvider] addAuthenticationInfo:urlRequest];
    [[self authInfoProvider] addDefaultHTTPHeadersForRequest:urlRequest withServerInfo:[[self serverConfiguration] registrationServer]];

    return urlRequest;
}

- (NSURLRequest*)buildVerifyTokenRequestWithBindToken:(NSString*)bindToken
{
    NSURL *requestUrl = [[self authInfoProvider] buildURLWithScheme:@"http" server:[[self serverConfiguration] registrationServer]
                                                        relativeURI:@"mmc/reg/v1/bindToken"
                                                             params:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     @"verifyToken", @"action", 
                                                                     bindToken, @"bindToken",
                                                                     [[self serverConfiguration] mmcServiceName], @"service",
                                                                     nil]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [urlRequest setHTTPMethod:@"GET"];
    [[self authInfoProvider] addAuthenticationInfo:urlRequest];
    [[self authInfoProvider] addDefaultHTTPHeadersForRequest:urlRequest withServerInfo:[[self serverConfiguration] registrationServer]];

    return urlRequest;
}

- (NSURLRequest*)buildRenewRequestWithNumber:(NSString*)number
{
    NSURL *requestUrl = [[self authInfoProvider] buildURLWithScheme:@"http" server:[[self serverConfiguration] mmcServerHostname]
                                                        relativeURI:@"mmc/reg/v1/registration/my"
                                                             params:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     @"renew", @"action",
                                                                     number, @"number",
                                                                     [[self serverConfiguration] mmcServiceName], @"service",
                                                                     nil]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [urlRequest setHTTPMethod:@"POST"];
    [[self authInfoProvider] addAuthenticationInfo:urlRequest];
    [[self authInfoProvider] addDefaultHTTPHeadersForRequest:urlRequest withServerInfo:[[self serverConfiguration] registrationServer]];

    return urlRequest;
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YARegistrationRequestBuilderFactory ()

@end
