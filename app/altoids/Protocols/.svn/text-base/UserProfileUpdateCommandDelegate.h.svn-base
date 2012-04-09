//
//  UserProfileUpdateCommandDelegate.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAUserInfo.h"

@protocol UserProfileUpdateCommandDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)userProfileNameAndPermissionUpdatedForLocalUserWithObjectID:(NSManagedObjectID *)theObjectID firstName:(NSString *)theFirstName lastName:(NSString *)theLastName;

- (void)userProfileImageUpdatedForLocalUserWithObjectID:(NSManagedObjectID *)theObjectID imageData:(NSData *)theImageData;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
