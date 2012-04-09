//
//  RegistrationCoordinatorDelegate.h
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RegistrationStepCoordinatorDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)registrationDidCompleteWithPhoneNumber:(NSString *)phoneNumber bindToken:(NSString *)token expirationDate:(NSDate *)expirationDate;
- (void)registrationDidFail;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
