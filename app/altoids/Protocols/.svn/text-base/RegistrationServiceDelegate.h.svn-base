//
//  RegistrationServiceDelegate.h
//  altoids
//
//  Created by Anand Subba Rao on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RegistrationServiceDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required
- (void)didSendGetToken;
- (void)didReceiveBindToken:(NSString *)bindToken shortCode:(NSString *)shortCode;

- (void)didSendVerifyToken;
- (void)didReceivePhoneNumber:(NSString *)phoneNumber expirationDate:(NSDate *)expirationDate;

- (void)didSendRenewRegistration;
- (void)didRenewRegistrationWithExpirationDate:(NSDate *)expirationDate;

- (void)didFailWithError:(NSError *)error;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
