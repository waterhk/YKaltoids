//
//  YAUserProfileUpdateNameWithPermissionErrorHandler.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorHandler.h"
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
@interface YAUserProfileUpdateNameWithPermissionErrorHandler : NSObject<ErrorHandler>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithUserProfileHandler:(id<UserProfileHandler>)theUserProfileHandler 
      managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory 
             userObjectID:(NSManagedObjectID *)theUserObjectID;

@end
