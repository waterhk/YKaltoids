//
//  YAUIAlertViewSelectionDetector.m
//  altoids
//
//  Created by Jon Herron on 9/6/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUIAlertViewSelectionDetector.h"

// Private class extension
@interface YAUIAlertViewSelectionDetector ()

// @property definitions

// methods

@end

@implementation YAUIAlertViewSelectionDetector

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

- (BOOL)clickedButtonIndex:(NSInteger)aClickedButtonIndex isCancelButtonIndexForUIAlertView:(UIAlertView *)aUIAlertView
{
    return [aUIAlertView cancelButtonIndex] == aClickedButtonIndex;
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAUIAlertViewSelectionDetector ()

@end
