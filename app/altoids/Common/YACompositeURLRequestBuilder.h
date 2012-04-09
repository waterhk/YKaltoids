//
//  YACompositeURLRequestBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLRequestBuilder.h"
#import "URLRequestURLWithURLParametersBuilder.h"
#import "URLRequestMethodBuilder.h"
#import "URLRequestHeadersBuilder.h"
#import "URLRequestBodyBuilder.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YACompositeURLRequestBuilder : NSObject <URLRequestBuilder>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithURLWithURLParametersBuilder:(id<URLRequestURLWithURLParametersBuilder>)theURLRequestWithURLParamatersBuilder 
                  urlRequestMethodBuilder:(id<URLRequestMethodBuilder>)theURLRequestMethodBuilder 
                 urlRequestHeadersBuilder:(id<URLRequestHeadersBuilder>)theURLRequestHeadersBuilder 
                    urlRequestBodyBuilder:(id<URLRequestBodyBuilder>)theURLRequestBodyBuilder;

@end
