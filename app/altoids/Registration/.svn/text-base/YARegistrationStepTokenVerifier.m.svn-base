//
//  YARegistrationStepTokenVerifier.m
//  altoids
//
//  Created by Jon Herron on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationStepTokenVerifier.h"
#import "YAAppFactory.h"
#import "ActivityIndicatorOverlay.h"

#undef kYALogComponent
#define kYALogComponent lcl_cRegistrationStep
#define kNoError 0

@interface YARegistrationStepTokenVerifier ()

@property (strong, nonatomic) id<ViewControllerAccessor> viewControllerAccessor;
@property (strong, nonatomic) id<RegistrationService> registrationService;
@property (strong, nonatomic) id<RegistrationTransientStateMutator> registrationTransientStateMutator;
@property (assign, nonatomic) id<RegistrationStepDelegate> registrationStepDelegate;
@property (strong, nonatomic) YARegistrationTransientState *registrationTransientState;
@property (assign, nonatomic) int retries;
@property (strong, nonatomic) id<ActivityIndicatorOverlayInstanceFactory> activityIndicatorOverlayInstanceFactory;
@property (strong, nonatomic) id<ActivityIndicatorOverlay> activityIndicatorOverlay;

- (void)completeStepForFailedRegistration;
- (void)completeStepForSuccessfulRegistration;
- (void)completeStepWithRegistrationCompletedFlag:(BOOL)flag;
- (void)hideActivityIndicator;
- (void)performVerifyToken;

@end

@implementation YARegistrationStepTokenVerifier

@synthesize viewControllerAccessor;
@synthesize registrationService;
@synthesize registrationTransientState;
@synthesize registrationTransientStateMutator;
@synthesize registrationStepDelegate;
@synthesize retries;
@synthesize activityIndicatorOverlayInstanceFactory = activityIndicatorOverlayInstanceFactory_;
@synthesize activityIndicatorOverlay = activityIndicatorOverlay_;

- (id)initWithRegistrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator
                     registrationTransientState:(YARegistrationTransientState *)aTransientState
        activityIndicatorOverlayInstanceFactory:(id<ActivityIndicatorOverlayInstanceFactory>)activityIndicatorOverlayInstanceFactory 
                          currentViewController:(id<ViewControllerAccessor>)aCurrentViewController
                            registrationService:(id<RegistrationService>)aRegistrationService
                                       delegate:(id<RegistrationStepDelegate>)aRegistrationStepDelegate
{
  self = [super init];
    
  if (self) 
  {
      [self setViewControllerAccessor:aCurrentViewController];
      [self setRegistrationTransientState:aTransientState];
      [self setRegistrationTransientStateMutator:aRegistrationTransientStateMutator];
      [self setRegistrationService:aRegistrationService];
      [self setRegistrationStepDelegate:aRegistrationStepDelegate];
      [self setRetries:10];
      
      activityIndicatorOverlayInstanceFactory_ = activityIndicatorOverlayInstanceFactory;
  }
  
  return self;
}

- (void)didSendVerifyToken
{
    // this is called once per try, so showing UI elements here is not a good idea
}

- (void)didFailWithError:(NSError *)error
{
    if ([error code] != kNoError && [self retries]) {
        [self setRetries:([self retries] - 1)];
        YALogTrace(@"Received NumberNotFound and retries remaining = %d", [self retries]);
        [self performSelector:@selector(performVerifyToken) withObject:nil afterDelay:5];
        return;
    }
    
    YALogError(@"Unable to retrieve phone number with token %@", [[self registrationTransientState] token]);
    
    [self completeStepForFailedRegistration];
}

- (void)didReceivePhoneNumber:(NSString *)phoneNumber expirationDate:(NSDate *)expirationDate
{
    YARegistrationTransientState *transientState = [self registrationTransientState];
    [[self registrationTransientStateMutator] updateRegistrationTransientState:transientState withPhoneNumber:phoneNumber];
    [[self registrationTransientStateMutator] updateRegistrationTransientState:transientState withExpirationDate:expirationDate];
    [[self registrationTransientStateMutator] updateRegistrationTransientState:transientState withTokenHasBeenValidated:YES];
    
    [activityIndicatorOverlay_ indicateCurrentActivityHasCompleted];
    
    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(completeStepForSuccessfulRegistration) userInfo:nil repeats:NO];
}

- (void)execute
{
    activityIndicatorOverlay_ = [activityIndicatorOverlayInstanceFactory_ createActivityIndicatorOverlay];
    
    [activityIndicatorOverlay_ showActivityIndicatorOverylayWithSendingSMSTextInParentView:[[viewControllerAccessor viewController] view]];
    
    [self performVerifyToken];
}


- (void)completeStepForFailedRegistration
{
    [self completeStepWithRegistrationCompletedFlag:NO];
}

- (void)completeStepForSuccessfulRegistration
{
    [self completeStepWithRegistrationCompletedFlag:YES];
}

- (void)completeStepWithRegistrationCompletedFlag:(BOOL)flag
{
    [self hideActivityIndicator];
    
    [[self registrationTransientStateMutator] updateRegistrationTransientState:[self registrationTransientState] withRegistrationCompleted:flag];
    
    [[self registrationStepDelegate] stepDidCompleteWithMutatedTransientState:[self registrationTransientState]];
}

- (void)hideActivityIndicator
{
    [activityIndicatorOverlay_ hideActivityIndicatorOverlay];
    
    activityIndicatorOverlay_ = nil;
}

- (void)performVerifyToken
{
    [[self registrationService] verifyToken:[[self registrationTransientState] token] delegate:self];
}

@end
