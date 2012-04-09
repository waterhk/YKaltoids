//
//  YAUserProfileErrorHandlerFactory.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileErrorHandlerFactory.h"
#import "ManagedObjectContextFactory.h"
#import "UserProfileHandler.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserProfileErrorHandlerFactory : NSObject<UserProfileErrorHandlerFactory>

#pragma mark @property declarations
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) id<UserProfileHandler> userProfileHandler;

#pragma mark  Class methods

#pragma mark Instance methods

@end
