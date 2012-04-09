//
//  ProfileRelativeURICreator.h
//  altoids
//
//  Created by Jon Herron on 10/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAUser.h"

@protocol ProfileRelativeURICreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSString *)createRelativeURIToUpdateProfileNameWithPermissionForUser:(YAUser *)theUser;
- (NSString *)createRelativeURIToUpdateProfileImageForUser:(YAUser *)theUser;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
