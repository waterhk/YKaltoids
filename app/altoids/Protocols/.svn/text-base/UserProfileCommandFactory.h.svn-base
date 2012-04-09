//
//  UserProfileCommandFactory.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
#import "UserProfileUpdateCommandDelegate.h"

@class YAUser;
@protocol UserProfileCommandFactory <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<Command>)createFetchUserProfileCommandWithUser:(YAUser *)user;
- (id<Command>)createUpdateProfileNameWithPermissionCommandWithUser:(YAUser *)user firstName:(NSString *)theFirstName lastName:(NSString *)theLastName updateProfileImageCommand:(id<Command>)theUpdateProfileImageCommand viewForOverlay:(UIView *)theView
    delegate:(id<UserProfileUpdateCommandDelegate>)theDelegate;
- (id<Command>)createUpdateProfileImageCommandWithUser:(YAUser *)user profileImageData:(NSData *)theProfileImageData delegate:(id<UserProfileUpdateCommandDelegate>)theDelegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
