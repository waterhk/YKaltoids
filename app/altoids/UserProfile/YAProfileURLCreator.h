//
//  YAProfileURLCreator.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileURLCreator.h"
#import "URLCreator.h"
#import "ProfileServerConfiguration.h"
#import "AuthInfoProvider.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAProfileURLCreator : NSObject<ProfileURLCreator>

#pragma mark @property declarations
@property (strong, nonatomic) id<URLCreator> urlCreator;
@property (strong, nonatomic) id<ProfileServerConfiguration> profileServerConfiguration;
@property (strong, nonatomic) id<AuthInfoProvider> authInfoProvider;

#pragma mark  Class methods

#pragma mark Instance methods

@end
