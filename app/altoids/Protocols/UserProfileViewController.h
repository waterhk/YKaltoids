//
//  UserProfileViewController.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/9/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileViewDelegate.h"
#import "ViewControllerAccessor.h"


@protocol UserProfileViewController <ViewControllerAccessor>

#pragma mark -
#pragma mark @required
@required

- (void)setDelegate:(id<UserProfileViewDelegate>)theDelegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
