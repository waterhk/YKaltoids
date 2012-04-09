//
//  YACompositeURLRequestBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YACompositeURLRequestBuilder.h"

// Private class extension
@interface YACompositeURLRequestBuilder ()

// @property definitions
@property (strong, nonatomic) id<URLRequestURLWithURLParametersBuilder> urlRequestWithURLParamatersBuilder;
@property (strong, nonatomic) id<URLRequestMethodBuilder> urlRequestMethodBuilder;
@property (strong, nonatomic) id<URLRequestHeadersBuilder> urlRequestHeadersBuilder;
@property (strong, nonatomic) id<URLRequestBodyBuilder> urlRequestBodyBuilder;

// methods

@end

@implementation YACompositeURLRequestBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize urlRequestWithURLParamatersBuilder = urlRequestWithURLParamatersBuilder_;
@synthesize urlRequestMethodBuilder = urlRequestMethodBuilder_;
@synthesize urlRequestHeadersBuilder = urlRequestHeadersBuilder_;
@synthesize urlRequestBodyBuilder = urlRequestBodyBuilder_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithURLWithURLParametersBuilder:(id<URLRequestURLWithURLParametersBuilder>)theURLRequestWithURLParamatersBuilder 
                  urlRequestMethodBuilder:(id<URLRequestMethodBuilder>)theURLRequestMethodBuilder 
                 urlRequestHeadersBuilder:(id<URLRequestHeadersBuilder>)theURLRequestHeadersBuilder 
                    urlRequestBodyBuilder:(id<URLRequestBodyBuilder>)theURLRequestBodyBuilder
{
  self = [super init];
    
  if (self) 
  {
      urlRequestWithURLParamatersBuilder_ = theURLRequestWithURLParamatersBuilder;
      urlRequestMethodBuilder_ = theURLRequestMethodBuilder;
      urlRequestHeadersBuilder_ = theURLRequestHeadersBuilder;
      urlRequestBodyBuilder_ = theURLRequestBodyBuilder;
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark URLRequestBuilder delegate methods

- (NSMutableURLRequest *)buildRequestURLWithURLParameters:(NSDictionary *)aURLParameters
{
    return [[self urlRequestWithURLParamatersBuilder] buildRequestURLWithURLParameters:aURLParameters];
}

- (NSMutableURLRequest *)buildRequestMethodForURLRequest:(NSMutableURLRequest *)aURLRequest
{
    return [[self urlRequestMethodBuilder] buildRequestMethodForURLRequest:aURLRequest];
}

- (NSMutableURLRequest *)buildRequestHeadersForURLRequest:(NSMutableURLRequest *)aURLRequest
{
    return [[self urlRequestHeadersBuilder] buildRequestHeadersForURLRequest:aURLRequest];
}

- (NSMutableURLRequest *)buildRequestBodyForURLRequest:(NSMutableURLRequest *)aURLRequest withRequestData:(NSData *)theRequestData
{
    return [[self urlRequestBodyBuilder] buildRequestBodyForURLRequest:aURLRequest withRequestData:theRequestData];
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
#pragma mark YACompositeURLRequestBuilder ()

@end
