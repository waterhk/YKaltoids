//
//  YACarrierInformation.m
//  altoids
//
//  Created by Jon Herron on 9/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YACarrierInformation.h"

// Private class extension
@interface YACarrierInformation ()

// @property definitions
@property (strong, nonatomic) CTCarrier *ctCarrier;

// methods

@end

@implementation YACarrierInformation

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize ctCarrier = ctCarrier_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithCTCarrier:(CTCarrier *)aCTCarrier
{
  self = [super init];
    
  if (self) 
  {
      ctCarrier_ = aCTCarrier;
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
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

- (NSString *)mobileCountryCode
{
#ifdef TARGET_IPHONE_SIMULATOR
    return @"310";
#else
    return [[self ctCarrier] mobileCountryCode];
#endif
}

- (NSString *)mobileNetworkCode
{
#ifdef TARGET_IPHONE_SIMULATOR
    return @"4234";
#else
    return [[self ctCarrier] mobileNetworkCode];
#endif    
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YACarrierInformation ()

@end
