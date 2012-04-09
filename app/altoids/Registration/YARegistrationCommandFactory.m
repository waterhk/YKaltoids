//
//  YARegistrationCommandFactory.m
//  altoids
//
//  Created by Anand Subba Rao on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationCommandFactory.h"

#import "YARegistrationGetTokenCommand.h"
#import "YARegistrationVerifyTokenCommand.h"
#import "YARegistrationRenewCommand.h"

// Private class extension
@interface YARegistrationCommandFactory ()

// @property definitions

// methods

@end

@implementation YARegistrationCommandFactory
// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize transportFactory = transportFactory_;
@synthesize registrationRequestBuilderFactory = registrationRequestBuilderFactory_;
@synthesize registrationResponseParserFactory = registrationResponseParserFactory_;

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
- (id<Command>)createGetTokenCommandWithCountryCode:(NSString *)countryCode
                                        networkCode:(NSString *)networkCode
                                       subscriberID:(NSString *)subscriberID
                                    responseHandler:(id<RegistrationResponseHandler>)responseHandler
                                            context:(id)context

{
    return [[YARegistrationGetTokenCommand alloc] initWithCountryCode:countryCode
                                                          networkCode:networkCode
                                                         subscriberID:subscriberID
                                                            transport:[[self transportFactory] serverTransport]
                                                requestBuilderFactory:[self registrationRequestBuilderFactory]
                                                responseParserFactory:[self registrationResponseParserFactory]
                                                      responseHandler:responseHandler
                                                              context:context];
}

- (id<Command>)createVerifyTokenCommandWithToken:(NSString *)bindToken
                                 responseHandler:(id<RegistrationResponseHandler>)responseHandler
                                         context:(id)context
{
    return [[YARegistrationVerifyTokenCommand alloc] initWithToken:bindToken
                                                         transport:[[self transportFactory] serverTransport]
                                             requestBuilderFactory:[self registrationRequestBuilderFactory]
                                             responseParserFactory:[self registrationResponseParserFactory]
                                                   responseHandler:responseHandler
                                                           context:context];
}

- (id<Command>)createRenewCommandWithPhoneNumber:(NSString *)phoneNumber
                                 responseHandler:(id<RegistrationResponseHandler>)responseHandler
                                         context:(id)context
{
    return [[YARegistrationRenewCommand alloc] initWithPhoneNumber:phoneNumber
                                                         transport:[[self transportFactory] serverTransport]
                                             requestBuilderFactory:[self registrationRequestBuilderFactory]
                                             responseParserFactory:[self registrationResponseParserFactory]
                                                   responseHandler:responseHandler
                                                           context:context];
}
// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YARegistrationCommandFactory ()

@end
