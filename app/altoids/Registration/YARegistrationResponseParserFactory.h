//
//  YARegistrationResponseParserFactory.h
//  altoids
//
//  Created by Lei Cai on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationResponseParser.h"
#import "ErrorResponseParser.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YARegistrationResponseParserFactory : NSObject <RegistrationResponseParser>

#pragma mark @property declarations
@property (nonatomic, strong) id<ErrorResponseParser> errorResponseParser;

#pragma mark  Class methods

#pragma mark Instance methods

@end
