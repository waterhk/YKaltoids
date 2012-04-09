//
//  YAAppConfiguration.h
//  altoids
//
//  Created by Anand Biligiri on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConfiguration.h"
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
@interface YAAppConfiguration : NSObject<AppConfiguration>

#pragma mark @property declarations
@property (strong, nonatomic) id<ConfigurationHandler> configurationHandler;

#pragma mark  Class methods

#pragma mark Instance methods

@end
