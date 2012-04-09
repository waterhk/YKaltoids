//
//  YAURLRequestBuilderComposer.h
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLRequestBuilderComposer.h"
#import "URLRequestBodyBuilder.h"
#import "URLRequestJSONPayloadHeadersBuilder.h"
#import "URLRequestMultipartPayloadHeadersBuilder.h"
#import "URLRequestStandardHeadersBuilder.h"
#import "URLRequestMethodGetBuilder.h"
#import "URLRequestMethodPostBuilder.h"
#import "URLRequestMethodPutBuilder.h"


// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAURLRequestBuilderComposer : NSObject <URLRequestBuilderComposer>

#pragma mark @property declarations
@property (strong, nonatomic) id<URLRequestMethodGetBuilder> urlRequestMethodGetBuilder;
@property (strong, nonatomic) id<URLRequestMethodPostBuilder> urlRequestMethodPostBuilder;
@property (strong, nonatomic) id<URLRequestMethodPutBuilder> urlRequestMethodPutBuilder;
@property (strong, nonatomic) id<URLRequestJSONPayloadHeadersBuilder> urlRequestJSONPayloadHeadersBuilder;
@property (strong, nonatomic) id<URLRequestMultipartPayloadHeadersBuilder> urlRequestMultipartPayloadHeadersBuilder;
@property (strong, nonatomic) id<URLRequestStandardHeadersBuilder> urlRequestStandardHeadersBuilder;
@property (strong, nonatomic) id<URLRequestBodyBuilder> urlRequestBodyBuilder;

#pragma mark  Class methods

#pragma mark Instance methods

@end
