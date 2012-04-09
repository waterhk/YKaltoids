//
//  YACarrierInformation.h
//  altoids
//
//  Created by Jon Herron on 9/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreTelephony/CTCarrier.h>
#import <Foundation/Foundation.h>

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YACarrierInformation : NSObject

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithCTCarrier:(CTCarrier *)aCTCarrier;

- (NSString *)mobileCountryCode;
- (NSString *)mobileNetworkCode;

@end
