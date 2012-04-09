//
//  YAServerConfiguration.h
//  altoids
//
//  Created by Anand Subba Rao on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//


#include "ServerConfiguration.h"
#include "ConfigurationHandler.h"
// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAServerConfiguration : NSObject<ServerConfiguration>

#pragma mark @property declarations
@property (strong, nonatomic) id<ConfigurationHandler> configurationHandler;

#pragma mark  Class methods

#pragma mark Instance methods

@end
