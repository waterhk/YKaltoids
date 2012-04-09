//
//  UserProfileUpdateURLWithURLParametersBuilderCreator.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileUpdateNameWithPermissionURLWithURLParametersBuilder.h"
#import "YAUser.h"

@protocol UserProfileUpdateURLWithURLParametersBuilderCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<UserProfileUpdateNameWithPermissionURLWithURLParametersBuilder>)createWithUser:(YAUser *)theUser;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
