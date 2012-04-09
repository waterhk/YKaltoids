//
//  YAURLRequestMultipartPayloadHeadersBuilder.h
//  altoids
//
//  Created by Anand Biligiri on 12/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLRequestMultipartPayloadHeadersBuilder.h"
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
@interface YAURLRequestMultipartPayloadHeadersBuilder : NSObject<URLRequestMultipartPayloadHeadersBuilder>

#pragma mark @property declarations
@property (strong, nonatomic) id<URLRequestStandardHeadersBuilder> urlRequestStandardHeadersBuilder;

#pragma mark  Class methods

#pragma mark Instance methods

@end
