//
//  YASMSAddressHandleFormatValidator.m
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YASMSAddressHandleFormatValidator.h"

// Private class extension
@interface YASMSAddressHandleFormatValidator ()

// @property definitions

// methods

@end

@implementation YASMSAddressHandleFormatValidator

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
    
  if (self) 
  {
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
#pragma mark SMSAddressHandleFormatValidator delegate methods

- (BOOL)validHandleForSMSAddress:(YAAddressInfo *)anSMSAddress
{
    NSArray *matches = nil;
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error];
    NSTextCheckingResult *result;
    
    if (error) 
    {
        return NO;
    }
    
    matches = [detector matchesInString:[anSMSAddress handle] options:0 range:NSMakeRange(0, [[anSMSAddress handle] length])];
    
    if ([matches count] == 1) 
    {
        result = [matches objectAtIndex:0];
        
        return [result resultType] == NSTextCheckingTypePhoneNumber;
    }
    
    return NO;
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
#pragma mark YASMSAddressHandleFormatValidator ()

@end
