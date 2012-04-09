//
//  YARegistrationService.m
//  altoids
//
//  Created by Anand Subba Rao on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationService.h"

#import "YARegistrationGetTokenResponse.h"
#import "YARegistrationVerifyTokenResponse.h"
#import "YARegistrationRenewResponse.h"

// Private class extension
@interface YARegistrationService ()
// methods

@end

@implementation YARegistrationService
// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize registrationCommandFactory = registrationCommandFactory_;
@synthesize mmcCommandQueue = mmcCommandQueue_;

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides
// Delegate methods
#pragma mark -
#pragma mark RegistrationService methods
- (void)getTokenWithCountryCode:(NSString *)countryCode networkCode:(NSString *)networkCode
                   subscriberID:(NSString *)subscriberID delegate:(id<RegistrationTokenRetrieverDelegate>)delegate
{
    
    id<Command> command = [[self registrationCommandFactory] createGetTokenCommandWithCountryCode:countryCode networkCode:networkCode subscriberID:subscriberID
                                                                      responseHandler:self context:delegate];
    [[self mmcCommandQueue] append:command];
    [delegate didSendGetToken];
}

- (void)verifyToken:(NSString *)bindToken delegate:(id<RegistrationVerifyTokenDelegate>)delegate
{
    id<Command> command = [[self registrationCommandFactory] createVerifyTokenCommandWithToken:bindToken responseHandler:self context:delegate];
    
    [[self mmcCommandQueue] append:command];
    [delegate didSendVerifyToken];
}

- (void)renewRegistrationWithPhoneNumber:(NSString *)phoneNumber delegate:(id<RegistrationRenewDelegate>)delegate
{
    id<Command> command = [[self registrationCommandFactory] createRenewCommandWithPhoneNumber:phoneNumber responseHandler:self context:delegate];
    [[self mmcCommandQueue] append:command];
    [delegate didSendRenewRegistration];
}

#pragma mark -
#pragma mark RegistrationResponseHandler methods
- (void)handleGetTokenResponse:(YARegistrationGetTokenResponse *)response context:(id)context
{
    id<RegistrationTokenRetrieverDelegate> delegate = context;
    
    if ([response error]) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            [delegate didFailWithError:[response error]]; 
        });
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        [delegate didReceiveBindToken:[response bindToken] shortCode:[response shortCode]];
    });    
}

- (void)handleVerifyTokenResponse:(YARegistrationVerifyTokenResponse *)response context:(id)context
{
    id<RegistrationVerifyTokenDelegate> delegate = context;
    
    if ([response error]) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            [delegate didFailWithError:[response error]]; 
        });
        return;
    }
        
    dispatch_async(dispatch_get_main_queue(), ^ {
        [delegate didReceivePhoneNumber:[response number] expirationDate:[NSDate dateWithTimeIntervalSinceNow:[response remainingTime]]];
    });
}

- (void)handleRenewResponse:(YARegistrationRenewResponse *)response context:(id)context
{
    id<RegistrationRenewDelegate> delegate = context;
    
    if ([response error]) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            [delegate didFailWithError:[response error]]; 
        });
        return;
    }
        
    dispatch_async(dispatch_get_main_queue(), ^ {
        [delegate didRenewRegistrationWithExpirationDate:[NSDate dateWithTimeIntervalSinceNow:[response remainingTime]]];
    });    
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YARegistrationService ()

@end
