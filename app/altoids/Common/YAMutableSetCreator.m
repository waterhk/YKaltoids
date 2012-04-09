//
//  YAMutableSetCreator.m
//  altoids
//
//  Created by Anand Subba Rao on 11/3/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMutableSetCreator.h"

// Private class extension
@interface YAMutableSetCreator ()

// @property definitions

// methods

@end

@implementation YAMutableSetCreator

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
#pragma mark MutableSetCreator methods
- (NSMutableSet *)mutableSetWithCapacity:(NSUInteger)capacity
{
    return [NSMutableSet setWithCapacity:capacity];
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
#pragma mark YAMutableSetCreator ()

@end
