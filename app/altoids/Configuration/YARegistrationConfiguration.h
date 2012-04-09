//
//  YARegistrationConfiguration.h
//  altoids
//
//  Created by Anand Subba Rao on 11/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigurationHandler.h"
#import "RegistrationConfiguration.h"
// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YARegistrationConfiguration : NSObject<RegistrationConfiguration>

#pragma mark @property declarations
@property (strong, nonatomic) id<ConfigurationHandler> configurationHandler;

#pragma mark  Class methods

#pragma mark Instance methods

@end
