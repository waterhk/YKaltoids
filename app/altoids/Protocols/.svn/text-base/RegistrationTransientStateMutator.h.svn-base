//
//  RegistrationTransientStateMutator.h
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YARegistrationTransientState.h"
#import "ViewControllerAccessor.h"

@protocol RegistrationTransientStateMutator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withCarrierIsSupported:(NSNumber *)aCarrierIsSupported;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withCurrentViewControllerAccessor:(id<ViewControllerAccessor>)aViewControllerAccessor;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withPhoneNumber:(NSString *)aPhoneNumber;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withRegistrationAborted:(BOOL)aRegistrationAborted;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withRegistrationCompleted:(BOOL)aRegistrationCompleted;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withRegistrationFailed:(BOOL)aRegistrationFailed;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withSMSVerificationFailed:(BOOL)aSMSVerificationFailed;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withVerificationSmsSent:(BOOL)aVerificatinSmsSent;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withSMSCommand:(NSString *)aSMSCommand;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withSMSShortCode:(NSString *)aSMSShortCode;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withToken:(NSString *)aToken;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withTokenHasBeenValidated:(BOOL)aTokenHasBeenValidated;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withMobileCountryCode:(NSString *)aCountryCode;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withMobileNetworkCode:(NSString *)aNetworkCode;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withMobileSubscriberId:(NSString *)aSubscriberId;

- (void)updateRegistrationTransientState:(YARegistrationTransientState *)aRegistrationTransitentState withExpirationDate:(NSDate *)anExpirationDate;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
