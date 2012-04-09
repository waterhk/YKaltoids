//
//  YACarrierInformationCreator.m
//  altoids
//
//  Created by Jon Herron on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "YACarrierInformationCreator.h"

// Private class extension
@interface YACarrierInformationCreator ()

// @property definitions

// methods

@end

@implementation YACarrierInformationCreator

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
#pragma mark <CarrierInformationCreator> delegate methods

- (YACarrierInformation *)carrierInformation
{
    CTTelephonyNetworkInfo *telphonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
    return [[YACarrierInformation alloc] initWithCTCarrier:[telphonyNetworkInfo subscriberCellularProvider]];
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
#pragma mark YACarrierInformationCreator ()

@end
