//
//  YAURLRequestJSONPayloadHeadersBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/10/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLRequestJSONPayloadHeadersBuilder.h"
#import "URLRequestStandardHeadersBuilder.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAURLRequestJSONPayloadHeadersBuilder : NSObject <URLRequestJSONPayloadHeadersBuilder>

#pragma mark @property declarations
@property (strong, nonatomic) id<URLRequestStandardHeadersBuilder> urlRequestStandardHeadersBuilder;

#pragma mark  Class methods

#pragma mark Instance methods

@end
