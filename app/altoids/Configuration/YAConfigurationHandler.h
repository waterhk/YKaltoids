//
//  YAConfigurationHandler.h
//  altoids
//
//  Created by Anand Subba Rao on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigurationHandler.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConfigurationHandler : NSObject <ConfigurationHandler>

#pragma mark @property declarations
@property (strong, nonatomic) NSBundle *bundleContainingDefaultSettings;

#pragma mark  Class methods

#pragma mark Instance methods

@end
