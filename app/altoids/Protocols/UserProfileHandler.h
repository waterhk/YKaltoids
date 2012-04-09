//
//  UserProfileHandler.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "YAUser.h"
#import "UserProfileUpdateStatus.h"

@protocol UserProfileHandler <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAUser *)createUserEntityInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (YAUser *)existingUserEntityInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError;

- (BOOL)save:(YAUser *)aUser inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError;

- (BOOL)save:(YAUser *)aUser error:(NSError **)anError;

- (NSString *)firstNameForUser:(YAUser *)aUser;

- (NSString *)lastNameForUser:(YAUser *)aUser;

- (NSString *)photoUrlForUser:(YAUser *)aUser;

- (NSString *)guidForUser:(YAUser *)aUser;

- (YAProfileUpdateStatus)profileUpdateStatusForUser:(YAUser *)aUser;

- (YAImageUpdateStatus)imageUpdateStatusForUser:(YAUser *)aUser;

- (BOOL)hasResidentPhotoWithURL:(NSString*)photoURL forUser:(YAUser*)user;

- (NSDate *)lastUpdatedDateForUser:(YAUser *)aUser;

- (void)setFirstName:(NSString *)aFirstName forUser:(YAUser *)aUser;

- (void)setLastName:(NSString *)aLastName forUser:(YAUser *)aUser;

- (void)setPhotoUrl:(NSString *)aPhotoUrl forUser:(YAUser *)aUser;

- (void)setGuid:(NSString *)theGuid forUser:(YAUser *)aUser;

- (void)setProfileUpdateStatus:(YAProfileUpdateStatus)theProfileUpdateStatus forUser:(YAUser *)aUser;

- (void)setImageUpdateStatus:(YAImageUpdateStatus)theImageUpdateStatus forUser:(YAUser *)aUser;

- (void)setLastUpdatedDate:(NSDate *)updatedDate forUser:(YAUser *)aUser;

- (void)setImage:(YAPersonImage *)aPersonImage forUser:(YAUser *)aUser;

- (YAPersonImage *)imageForUser:(YAUser *)aUser;

- (NSManagedObjectID *)userObjectIDForUser:(YAUser *)theUser;

- (NSData *) dataOfImageForUser:(YAUser *) user;

- (void)setImageData:(NSData *)theImageData forUser:(YAUser *)theUser;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
