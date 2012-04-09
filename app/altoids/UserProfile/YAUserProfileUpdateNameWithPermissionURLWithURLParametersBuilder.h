//
//  YAUserProfileUpdateNameWithPermissionURLWithURLParametersBuilder.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileUpdateNameWithPermissionURLWithURLParametersBuilder.h"
#import "ProfileURLCreator.h"
#import "ProfileRelativeURICreator.h"
#import "ManagedObjectContextFactory.h"
#import "YAUser.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserProfileUpdateNameWithPermissionURLWithURLParametersBuilder : NSObject<UserProfileUpdateNameWithPermissionURLWithURLParametersBuilder>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithProfileURLCreator:(id<ProfileURLCreator>)theProfileURLCreator 
      profileRelativeURICreator:(id<ProfileRelativeURICreator>)theProfileRelativeURICreator
    managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory
                           user:(YAUser *)theUser;

@end
