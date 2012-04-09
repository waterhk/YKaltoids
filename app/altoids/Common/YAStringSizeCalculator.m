//
//  YAStringSizeCalculator.m
//  altoids
//
//  Created by Jon Herron on 10/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAStringSizeCalculator.h"

// Private class extension
@interface YAStringSizeCalculator ()

// @property definitions

// methods

@end

@implementation YAStringSizeCalculator

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
#pragma mark StringSizeCalculator delegate methods

- (CGSize)sizeOfString:(NSString *)theString withFont:(UIFont *)theFont
{
    return [theString sizeWithFont:theFont];
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
#pragma mark YAStringSizeCalculator ()

@end
