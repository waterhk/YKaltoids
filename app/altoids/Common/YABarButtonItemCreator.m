//
//  YABarButtonItemCreator.m
//  altoids
//
//  Created by Derrick Whittle on 1/19/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import "YABarButtonItemCreator.h"

// Private class extension
@interface YABarButtonItemCreator ()

// @property definitions

// methods

@end

@implementation YABarButtonItemCreator

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

// Dealloc
#pragma mark -
#pragma mark dealloc

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

- (UIBarButtonItem*) createBarButtonItemWithCustomView:(UIView *)view
{
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YABarButtonItemCreator ()

@end
