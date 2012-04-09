//
//  YAURLRequestCreator.m
//  altoids
//
//  Created by Jon Herron on 9/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientURLAndURLRequestHandling
//

#import "YAURLRequestCreator.h"

// Private class extension
@interface YAURLRequestCreator ()

// @property definitions

// methods

@end

@implementation YAURLRequestCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <URLRequestCreator> delegate methods

- (NSURLRequest *)urlRequestFromURLRequestBuilder:(id<URLRequestBuilder>)aURLRequestBuilder withURLParameters:(NSDictionary *)theURLParameters requestData:(NSData *)theRequestData
{
    NSParameterAssert(aURLRequestBuilder);
    
    NSMutableURLRequest *urlRequest = nil;
    
    urlRequest = [aURLRequestBuilder buildRequestURLWithURLParameters:theURLParameters];
    urlRequest = [aURLRequestBuilder buildRequestMethodForURLRequest:urlRequest];
    urlRequest = [aURLRequestBuilder buildRequestBodyForURLRequest:urlRequest withRequestData:theRequestData];
    urlRequest = [aURLRequestBuilder buildRequestHeadersForURLRequest:urlRequest];
    
    return urlRequest;
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
#pragma mark YAURLRequestCreator ()

@end
