//
//  UserProfileParsedJSONResponseHandlerCreator.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
#import "UserProfileUpdateNameWithPermissionParsedJSONResponseHandler.h"
#import "UserProfileUpdateCommandDelegate.h"
#import "YAUser.h"

@protocol UserProfileParsedJSONResponseHandlerCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<UserProfileUpdateNameWithPermissionParsedJSONResponseHandler>)createWithUser:(YAUser *)theUser 
                                                                         firstName:(NSString *)theFirstName
                                                                          lastName:(NSString *)theLastName
                                                         updateProfileImageCommand:(id<Command>)theUpdateProfileImageCommand
                                                                          delegate:(id<UserProfileUpdateCommandDelegate>)theDelegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
