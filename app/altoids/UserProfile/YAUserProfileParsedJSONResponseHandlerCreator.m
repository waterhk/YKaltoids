//
//  YAUserProfileParsedJSONResponseHandlerCreator.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileParsedJSONResponseHandlerCreator.h"
#import "YAUserProfileUpdateNameWithPermissionParsedJSONResponseHandler.h"

// Private class extension
@interface YAUserProfileParsedJSONResponseHandlerCreator ()

// @property definitions

// methods

@end

@implementation YAUserProfileParsedJSONResponseHandlerCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize userProfileHandler = userProfileHandler_;
@synthesize userProfileErrorHandlerFactory = userProfileErrorHandlerFactory_;

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
#pragma mark <Protocol Name> delegate methods

- (id<UserProfileUpdateNameWithPermissionParsedJSONResponseHandler>)createWithUser:(YAUser *)theUser 
                                                                         firstName:(NSString *)theFirstName 
                                                                          lastName:(NSString *)theLastName 
                                                         updateProfileImageCommand:(id<Command>)theUpdateProfileImageCommand 
                                                                          delegate:(id<UserProfileUpdateCommandDelegate>)theDelegate
{
    return [[YAUserProfileUpdateNameWithPermissionParsedJSONResponseHandler alloc] initWithUserProfileHandler:[self userProfileHandler] 
                                                                               userProfileErrorHandlerFactory:[self userProfileErrorHandlerFactory] 
                                                                                                         user:theUser 
                                                                                                    firstName:theFirstName 
                                                                                                     lastName:theLastName
                                                                                    updateProfileImageCommand:theUpdateProfileImageCommand 
                                                                                                     delegate:theDelegate];
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
#pragma mark YAUserProfileParsedJSONResponseHandlerCreator ()

@end
