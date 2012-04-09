//
//  YARegistrationVerifyTokenCommand.h
//  altoids
//
//  Created by Lei Cai on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Command.h"
#import "Transport.h"
#import "RegistrationRequestBuilder.h"
#import "RegistrationResponseParser.h"
#import "RegistrationResponseHandler.h"


// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YARegistrationVerifyTokenCommand : NSObject <Command>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods
- (id)initWithToken:(NSString *)bindToken
          transport:(id<Transport>)transport
requestBuilderFactory:(id<RegistrationRequestBuilder>)requestBuilderFactory
responseParserFactory:(id<RegistrationResponseParser>)responseParserFactory
    responseHandler:(id<RegistrationResponseHandler>)responseHandler
    context:(id)context;

@end
