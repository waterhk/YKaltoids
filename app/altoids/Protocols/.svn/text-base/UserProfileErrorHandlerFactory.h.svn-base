//
//  UserProfileErrorHandlerFactory.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorHandler.h"
#import "YAUser.h"

@protocol UserProfileErrorHandlerFactory <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<ErrorHandler>)userProfileUpdateNameWithPermissionErrorHandlerWithUser:(YAUser *)theUser;
- (id<ErrorHandler>)userProfileUpdateNameWithPermissionErrorHandlerWithUserObjectID:(NSManagedObjectID *)theUserObjectID;
- (id<ErrorHandler>)userProfileUpdateImageErrorHandlerWithUser:(YAUser *)theUser;
- (id<ErrorHandler>)userProfileUpdateImageErrorHandlerWithUserObjectID:(NSManagedObjectID *)theUserObjectID;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
