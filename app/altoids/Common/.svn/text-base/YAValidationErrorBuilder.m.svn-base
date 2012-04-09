//
//  YAValidationErrorBuilder.m
//  altoids
//
//  Created by Jon Herron on 8/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAValidationErrorBuilder.h"

// Private class extension
@interface YAValidationErrorBuilder ()

// @property definitions

// methods

@end

@implementation YAValidationErrorBuilder

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
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

- (NSError *)validationErrorWithCode:(NSUInteger)aCode message:(NSString *)aMessage
{
    // setup error message here
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:aMessage forKey:NSLocalizedDescriptionKey];
    
    NSError *error = [NSError errorWithDomain:YAValidationErrorDomain code:aCode userInfo:userInfo];

    return error;
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAValidationErrorBuilder ()

@end
