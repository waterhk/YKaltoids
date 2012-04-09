//
//  ProfileURLParametersCreator.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileUpdateNameWithPermissionURLParametersCreator.h"

@protocol ProfileURLParametersCreator <UserProfileUpdateNameWithPermissionURLParametersCreator>

#pragma mark -
#pragma mark @required
@required

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
