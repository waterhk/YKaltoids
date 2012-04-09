//
//  YAUserProfileUpdateNameWithPermissionParsedJSONResponseHandler.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
#import "UserProfileUpdateNameWithPermissionParsedJSONResponseHandler.h"
#import "UserProfileHandler.h"
#import "UserProfileErrorHandlerFactory.h"
#import "YAUser.h"
#import "UserProfileUpdateCommandDelegate.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserProfileUpdateNameWithPermissionParsedJSONResponseHandler : NSObject<UserProfileUpdateNameWithPermissionParsedJSONResponseHandler>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithUserProfileHandler:(id<UserProfileHandler>)theUserProfileHandler
  userProfileErrorHandlerFactory:(id<UserProfileErrorHandlerFactory>)theUserProfileErrorHandlerFactory
                            user:(YAUser *)theUser
                       firstName:(NSString *)theFirstName
                        lastName:(NSString *)theLastName
       updateProfileImageCommand:(id<Command>)theUpdateProfileImageCommand 
                        delegate:(id<UserProfileUpdateCommandDelegate>)theUserProfileUpdateCommandDelegate;
@end
