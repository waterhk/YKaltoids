//
//  YABaseResponse.m
//  altoids
//
//  Created by Anand Subba Rao on 8/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YABaseResponse.h"

@implementation YABaseResponse

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
@synthesize statusCode = statusCode_;
@synthesize contentLength = contentLength_;
@synthesize body = body_;
@synthesize error = error_;

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

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
#pragma mark YABaseResponse ()

@end
