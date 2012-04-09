//
//  UserProfileViewControllerCreator.h
//  altoids
//
//  Created by Jon Herron on 12/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileViewController.h"

@protocol UserProfileViewControllerCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<UserProfileViewController>)userProfileViewControllerForFTUFlow;
- (id<UserProfileViewController>)userProfileViewControllerForProfileEdit;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
