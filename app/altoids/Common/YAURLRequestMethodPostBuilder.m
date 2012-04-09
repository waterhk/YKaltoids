//
//  YAURLRequestMethodPostBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAURLRequestMethodPostBuilder.h"

#define kPostHTTPMethod @"POST"

// Private class extension
@interface YAURLRequestMethodPostBuilder ()

// @property definitions

// methods

@end

@implementation YAURLRequestMethodPostBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

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

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark URLRequestMethodBuilder delegate methods

- (NSMutableURLRequest *)buildRequestMethodForURLRequest:(NSMutableURLRequest *)aURLRequest
{
    [aURLRequest setHTTPMethod:kPostHTTPMethod];
    
    return aURLRequest;
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
#pragma mark YAURLRequestMethodPostBuilder ()

@end
