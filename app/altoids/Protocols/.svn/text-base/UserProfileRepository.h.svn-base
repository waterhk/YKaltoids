//
//  UserProfileRepository.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAUser.h"
#import "YAUserInfo.h"

@protocol UserProfileRepository <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAUser *)createUserWithUserInfo:(YAUserInfo *)info error:(NSError **)anError;
- (YAUser *)fetchCurrentUserProfileWithError:(NSError **)anError;
- (void)fetchUserProfileForUserAsync:(YAUser *)user;
- (BOOL)saveUser:(YAUser *)user error:(NSError **)anError;
- (void)updateUserProfileWithFirstName:(NSString *)newFirstName
                              lastName:(NSString *)newLastName 
                                 image:(UIImage *)newImage 
                        viewForOverlay:(UIView *)theView
                               forUser:(YAUser *)user error:(NSError **)anError;
- (YAImageUpdateStatus)imageUpdateStatusForUser:(YAUser *)user;
- (YAProfileUpdateStatus)profileUpdateStatusForUser:(YAUser *)user;
- (void)setProfileUpdateStatus:(YAProfileUpdateStatus)profileUpdateStatus forUser:(YAUser *)user;
- (void)setImageUpdateStatus:(YAImageUpdateStatus)imageUpdateStatus forUser:(YAUser *)user;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
