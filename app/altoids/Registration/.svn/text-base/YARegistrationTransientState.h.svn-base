//
//  YARegistrationTransientState.h
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerAccessor.h"

@interface YARegistrationTransientState : NSObject

@property (strong, readonly, nonatomic) NSNumber *carrierIsSupported;
@property (assign, readonly, nonatomic) BOOL registrationAborted;
@property (assign, readonly, nonatomic) BOOL registrationCompleted;
@property (assign, readonly, nonatomic) BOOL registrationFailed;
@property (assign, readonly, nonatomic) BOOL smsVerificationFailed;
@property (assign, readonly, nonatomic) BOOL tokenHasBeenValidated;
@property (assign, readonly, nonatomic) BOOL verificationSmsSent;
@property (copy,   readonly, nonatomic) NSString *smsCommand;
@property (copy,   readonly, nonatomic) NSString *smsShortCode;
@property (copy,   readonly, nonatomic) NSString *token;
@property (copy,   readonly, nonatomic) NSString *phoneNumber;
@property (copy,   readonly, nonatomic) NSString *mobileCountryCode;
@property (copy,   readonly, nonatomic) NSString *mobileNetworkCode;
@property (copy,   readonly, nonatomic) NSString *mobileSubscriberId;
@property (copy,   readonly, nonatomic) NSDate *expirationDate;
@property (strong, readonly, nonatomic) id<ViewControllerAccessor> currentViewControllerAccessor;

@end
