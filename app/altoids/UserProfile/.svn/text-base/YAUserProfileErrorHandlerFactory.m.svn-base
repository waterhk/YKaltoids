//
//  YAUserProfileErrorHandlerFactory.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileErrorHandlerFactory.h"
#import "YAUserProfileUpdateNameWithPermissionErrorHandler.h"
#import "YAUserProfileImageUpdateErrorHandler.h"

// Private class extension
@interface YAUserProfileErrorHandlerFactory ()

// @property definitions

// methods

@end

@implementation YAUserProfileErrorHandlerFactory

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize userProfileHandler = userProfileHandler_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark UserProfileErrorHandlerFactory protocol methods

- (id<ErrorHandler>)userProfileUpdateNameWithPermissionErrorHandlerWithUser:(YAUser *)theUser
{
    return [self userProfileUpdateNameWithPermissionErrorHandlerWithUserObjectID:[theUser objectID]];
}

- (id<ErrorHandler>)userProfileUpdateNameWithPermissionErrorHandlerWithUserObjectID:(NSManagedObjectID *)theUserObjectID
{
    return [[YAUserProfileUpdateNameWithPermissionErrorHandler alloc] initWithUserProfileHandler:[self userProfileHandler] 
                                                                     managedObjectContextFactory:[self managedObjectContextFactory] 
                                                                                    userObjectID:theUserObjectID];
}

- (id<ErrorHandler>)userProfileUpdateImageErrorHandlerWithUser:(YAUser *)theUser
{
    return [self userProfileUpdateImageErrorHandlerWithUserObjectID:[theUser objectID]];
}

- (id<ErrorHandler>)userProfileUpdateImageErrorHandlerWithUserObjectID:(NSManagedObjectID *)theUserObjectID
{
    return [[YAUserProfileImageUpdateErrorHandler alloc] initWithUserProfileHandler:[self userProfileHandler]
                                                        managedObjectContextFactory:[self managedObjectContextFactory]
                                                                       userObjectID:theUserObjectID];
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAUserProfileErrorHandlerFactory ()

@end
