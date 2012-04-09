//
//  YARegistrationCommandFactory.h
//  altoids
//
//  Created by Anand Subba Rao on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationCommandFactory.h"

#import "TransportFactory.h"
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
@interface YARegistrationCommandFactory : NSObject <RegistrationCommandFactory>

#pragma mark @property declarations
@property (nonatomic, strong) id<TransportFactory> transportFactory;
@property (nonatomic, strong) id<RegistrationRequestBuilder> registrationRequestBuilderFactory;
@property (nonatomic, strong) id<RegistrationResponseParser> registrationResponseParserFactory;

#pragma mark  Class methods

#pragma mark Instance methods

@end
