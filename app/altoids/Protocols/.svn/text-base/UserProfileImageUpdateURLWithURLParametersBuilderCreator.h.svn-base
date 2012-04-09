//
//  UserProfileImageUpdateURLWithURLParametersBuilderCreator.h
//  altoids
//
//  Created by Anand Subba Rao on 12/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileImageUpdateURLWithURLParametersBuilder.h"
#import "YAUser.h"

@protocol UserProfileImageUpdateURLWithURLParametersBuilderCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<UserProfileImageUpdateURLWithURLParametersBuilder>)createWithUser:(YAUser *)user;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
