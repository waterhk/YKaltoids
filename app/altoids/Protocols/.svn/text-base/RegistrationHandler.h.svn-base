//
//  RegistrationHandler.h
//  altoids
//
//  Created by Anand Subba Rao on 11/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YARegistrationInfo.h"

@protocol RegistrationHandler <NSObject>

#pragma mark -
#pragma mark @required
@required
- (YARegistrationInfo *)createRegistrationInfoEntityInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (void)setPhoneNumber:(NSString *)phoneNumber registrationInfo:(YARegistrationInfo *)registrationInfo;
- (void)setExpirationDate:(NSDate *)expirationDate registrationInfo:(YARegistrationInfo *)registrationInfo;
- (void)setProfileUpdated:(BOOL)profileUpdated registrationInfo:(YARegistrationInfo *)registrationInfo;
- (void)setToken:(NSString *)token registrationInfo:(YARegistrationInfo *)registrationInfo;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
