//
//  RegistrationRepository.h
//  altoids
//
//  Created by Anand Subba Rao on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationInfoCommandDelegate.h"

@class YAAddressInfo;
@class YARegistrationInfo;

@protocol RegistrationRepository <NSObject>

- (BOOL)registrationRequired;
- (YARegistrationInfo *)existingRegistrationInfo;
- (YARegistrationInfo *)createRegistrationInfo;
- (void)setPhoneNumber:(NSString *)phoneNumber registrationInfo:(YARegistrationInfo *)registrationInfo;
- (void)setExpirationDate:(NSDate *)expirationDate registrationInfo:(YARegistrationInfo *)registrationInfo;
- (void)setProfileUpdated:(BOOL)profileUpdated registrationInfo:(YARegistrationInfo *)registrationInfo;
- (void)setToken:(NSString *)token registrationInfo:(YARegistrationInfo *)registrationInfo;
- (BOOL)saveRegistration:(YARegistrationInfo *)registration error:(NSError **)anError;

- (void)requestRegistrationInformationForAddress:(YAAddressInfo *)address delegate:(id<RegistrationInfoCommandDelegate>)delegate;

@end
