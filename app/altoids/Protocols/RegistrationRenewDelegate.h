//
//  RegistrationRenewDelegate.h
//  altoids
//
//  Created by Anand Subba Rao on 9/6/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RegistrationRenewDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required
- (void)didSendRenewRegistration;
- (void)didRenewRegistrationWithExpirationDate:(NSDate *)expirationDate;

- (void)didFailWithError:(NSError *)error;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
