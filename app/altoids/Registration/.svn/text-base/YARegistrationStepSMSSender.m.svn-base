//
//  YARegistrationStepSMSSender.m
//  altoids
//
//  Created by Jon Herron on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <MessageUI/MFMessageComposeViewController.h>
#import "YARegistrationStepSMSSender.h"

#undef kYALogComponent
#define kYALogComponent lcl_cRegistrationStep
// Private class extension
@interface YARegistrationStepSMSSender ()

// @property definitions
@property (strong, nonatomic) id<RegistrationConfiguration> registrationConfiguration;
@property (strong, nonatomic) id<RegistrationStepDelegate> registrationStepDelegate;
@property (strong, nonatomic) id<RegistrationTransientStateMutator> registrationTransientStateMutator;
@property (strong, nonatomic) YARegistrationTransientState *registrationTransientState;

// methods

@end

@implementation YARegistrationStepSMSSender

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithRegistrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator
                     registrationTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate
                      registrationConfiguration:(id<RegistrationConfiguration>)registrationConfiguration
{
  self = [super init];
    
  if (self) 
  {
      [self setRegistrationTransientStateMutator:aRegistrationTransientStateMutator];
      [self setRegistrationTransientState:aRegistrationTransientState];
      [self setRegistrationStepDelegate:aDelegate];
      [self setRegistrationConfiguration:registrationConfiguration];

  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize registrationStepDelegate = registrationStepDelegate_;
@synthesize registrationTransientState = registrationTransientState_;
@synthesize registrationTransientStateMutator = registrationTransientStateMutator_;
@synthesize registrationConfiguration = registrationConfiguration_;
// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <MFMessageComposeViewControllerDelegate> delegate methods

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    // MessageComposeResultCancelled,
    // MessageComposeResultSent,
    // MessageComposeResultFailed
    
    YARegistrationTransientState *transientState = [self registrationTransientState];
    
    if (result == MessageComposeResultSent) 
    {
        [[self registrationTransientStateMutator] updateRegistrationTransientState:[self registrationTransientState] withVerificationSmsSent:YES];
    }
    else
    {
        YALogError(@"SMS send failed with result %d", result);
        [[self registrationTransientStateMutator] updateRegistrationTransientState:transientState withRegistrationFailed:YES];
    }
    
    [controller dismissModalViewControllerAnimated:YES];
    
    [[self registrationStepDelegate] stepDidCompleteWithMutatedTransientState:transientState];
}

// Public methods
#pragma mark -
#pragma mark Public methods

- (void)execute
{
#if TARGET_IPHONE_SIMULATOR
    [[self registrationTransientStateMutator] updateRegistrationTransientState:[self registrationTransientState] withVerificationSmsSent:YES];
    [[self registrationStepDelegate] stepDidCompleteWithMutatedTransientState:[self registrationTransientState]];
#else
    
    if ([[self registrationConfiguration] shouldSkipRegistrationSMS] == YES) {
        [[self registrationTransientStateMutator] updateRegistrationTransientState:[self registrationTransientState] withVerificationSmsSent:YES];
        [[self registrationStepDelegate] stepDidCompleteWithMutatedTransientState:[self registrationTransientState]];
        return;
    }
    //todo: update appFactory script to support library includes so I don't need a 
    //      factory to inject:
    MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
    
    if ([MFMessageComposeViewController canSendText]) 
    {
        [vc setBody:[NSString stringWithFormat:@"%@ %@", [[self registrationConfiguration] smsPrefix],[[self registrationTransientState] token]]];
        [vc setRecipients:[NSArray arrayWithObject:[[self registrationTransientState] smsShortCode]]];
        [vc setMessageComposeDelegate:self];
        
        [[[[self registrationTransientState] currentViewControllerAccessor] viewController] presentModalViewController:vc animated:YES];
    }
    else
    {
        YALogError(@"Unable to send SMS on this device");    
    }
#endif
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YARegistrationStepSMSSender ()

@end
