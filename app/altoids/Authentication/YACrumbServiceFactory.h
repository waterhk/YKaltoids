//
//  YACrumbServiceFactory.h
//  altoids
//
//  Created by Anand Subba Rao on 9/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CrumbServiceFactory.h"
#import "ProfileServerConfiguration.h"
#import "ServerConfiguration.h"
// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YACrumbServiceFactory : NSObject <CrumbServiceFactory>

#pragma mark @property declarations
@property (strong, nonatomic) id<ProfileServerConfiguration> profileServerConfiguration;
@property (strong, nonatomic) id<ServerConfiguration> serverConfiguration;

#pragma mark  Class methods

#pragma mark Instance methods

@end
