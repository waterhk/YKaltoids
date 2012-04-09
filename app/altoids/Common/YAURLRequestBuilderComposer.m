//
//  YAURLRequestBuilderComposer.m
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAURLRequestBuilderComposer.h"
#import "YACompositeURLRequestBuilder.h"
#import "URLRequestHeadersBuilder.h"

// Private class extension
@interface YAURLRequestBuilderComposer ()

// @property definitions

// methods
- (id<URLRequestBuilder>)composeFromURLWithURLParametersBuilder:(id<URLRequestURLWithURLParametersBuilder>)theURLRequestWithURLParamatersBuilder 
                                        urlRequestMethodBuilder:(id<URLRequestMethodBuilder>)theURLRequestMethodBuilder 
                                       urlRequestHeadersBuilder:(id<URLRequestHeadersBuilder>)theURLRequestHeadersBuilder 
                                          urlRequestBodyBuilder:(id<URLRequestBodyBuilder>)theURLRequestBodyBuilder;

@end

@implementation YAURLRequestBuilderComposer

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize urlRequestMethodGetBuilder = urLRequestMethodGetBuilder_;
@synthesize urlRequestMethodPostBuilder = urlRequestMethodPostBuilder_;
@synthesize urlRequestMethodPutBuilder = urlRequestMethodPutBuilder_;
@synthesize urlRequestJSONPayloadHeadersBuilder = urlRequestJSONPayloadHeadersBuilder_;
@synthesize urlRequestMultipartPayloadHeadersBuilder = urlRequestMultipartPayloadHeadersBuilder_;
@synthesize urlRequestStandardHeadersBuilder = urlRequestStandardHeadersBuilder_;
@synthesize urlRequestBodyBuilder = urlRequestBodyBuilder_;

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
#pragma mark URLRequestBuilderComposer delegate methods

- (id<URLRequestBuilder>)composeStandardGetRequestUsingURLWithURLParametersBuilder:(id<URLRequestURLWithURLParametersBuilder>)theURLRequestWithURLParamatersBuilder
{
    return [self composeFromURLWithURLParametersBuilder:theURLRequestWithURLParamatersBuilder 
                                urlRequestMethodBuilder:[self urlRequestMethodGetBuilder] 
                               urlRequestHeadersBuilder:[self urlRequestStandardHeadersBuilder] 
                                  urlRequestBodyBuilder:[self urlRequestBodyBuilder]];
}

- (id<URLRequestBuilder>)composeStandardPostRequestWithJSONPayloadUsingURLWithURLParametersBuilder:(id<URLRequestURLWithURLParametersBuilder>)theURLRequestWithURLParamatersBuilder
{
    return [self composeFromURLWithURLParametersBuilder:theURLRequestWithURLParamatersBuilder 
                                urlRequestMethodBuilder:[self urlRequestMethodPostBuilder] 
                               urlRequestHeadersBuilder:[self urlRequestJSONPayloadHeadersBuilder] 
                                  urlRequestBodyBuilder:[self urlRequestBodyBuilder]];
}

- (id<URLRequestBuilder>)composeMultipartPostRequestUsingURLWithURLParametersBuilder:(id<URLRequestURLWithURLParametersBuilder>)theURLRequestWithURLParametersBuilder
{
    return [self composeFromURLWithURLParametersBuilder:theURLRequestWithURLParametersBuilder
                                urlRequestMethodBuilder:[self urlRequestMethodPostBuilder]
                               urlRequestHeadersBuilder:[self urlRequestMultipartPayloadHeadersBuilder]
                                  urlRequestBodyBuilder:[self urlRequestBodyBuilder]];    
}

- (id<URLRequestBuilder>)composeStandardPutRequestWithJSONPayloadUsingURLWithURLParametersBuilder:(id<URLRequestURLWithURLParametersBuilder>)theURLRequestWithURLParamatersBuilder
{
    return [self composeFromURLWithURLParametersBuilder:theURLRequestWithURLParamatersBuilder 
                                urlRequestMethodBuilder:[self urlRequestMethodPutBuilder] 
                               urlRequestHeadersBuilder:[self urlRequestJSONPayloadHeadersBuilder] 
                                  urlRequestBodyBuilder:[self urlRequestBodyBuilder]];
}

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
#pragma mark YAURLRequestBuilderComposer ()

- (id<URLRequestBuilder>)composeFromURLWithURLParametersBuilder:(id<URLRequestURLWithURLParametersBuilder>)theURLRequestWithURLParamatersBuilder 
                                        urlRequestMethodBuilder:(id<URLRequestMethodBuilder>)theURLRequestMethodBuilder 
                                       urlRequestHeadersBuilder:(id<URLRequestHeadersBuilder>)theURLRequestHeadersBuilder 
                                          urlRequestBodyBuilder:(id<URLRequestBodyBuilder>)theURLRequestBodyBuilder
{
    return [[YACompositeURLRequestBuilder alloc] initWithURLWithURLParametersBuilder:theURLRequestWithURLParamatersBuilder 
                                                             urlRequestMethodBuilder:theURLRequestMethodBuilder 
                                                            urlRequestHeadersBuilder:theURLRequestHeadersBuilder 
                                                               urlRequestBodyBuilder:theURLRequestBodyBuilder];
}

@end
