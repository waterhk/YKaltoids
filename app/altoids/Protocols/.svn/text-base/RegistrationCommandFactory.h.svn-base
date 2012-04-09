//
//  RegistrationCommandFactory.h
//  altoids
//
//  Created by Anand Subba Rao on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
#import "RegistrationResponseHandler.h"

@protocol RegistrationCommandFactory <NSObject>

#pragma mark -
#pragma mark @required
@required
- (id<Command>)createGetTokenCommandWithCountryCode:(NSString *)countryCode
                                        networkCode:(NSString *)networkCode
                                       subscriberID:(NSString *)subscriberID
                                    responseHandler:(id<RegistrationResponseHandler>)responseHandler
                                            context:(id)context;

- (id<Command>)createVerifyTokenCommandWithToken:(NSString *)bindToken
                                    responseHandler:(id<RegistrationResponseHandler>)responseHandler
                                            context:(id)context;

- (id<Command>)createRenewCommandWithPhoneNumber:(NSString *)phoneNumber
                                    responseHandler:(id<RegistrationResponseHandler>)responseHandler
                                            context:(id)context;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
