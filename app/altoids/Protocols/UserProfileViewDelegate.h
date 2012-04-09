//
//  UserProfileViewDelegate.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/9/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerAccessor.h"

@protocol UserProfileViewDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)userProfileViewController:(id<ViewControllerAccessor>)userProfileViewController dismissUserProfileWithAnimation:(BOOL)animated;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
