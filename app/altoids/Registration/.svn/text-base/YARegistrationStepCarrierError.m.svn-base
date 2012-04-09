//
//  YARegistrationStepCarrierError.m
//  altoids
//
//  Created by Jon Herron on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationStepCarrierError.h"

// Private class extension
@interface YARegistrationStepCarrierError ()

// @property definitions
@property (strong, nonatomic) id<RegistrationStepDelegate> registrationStepDelegate;
@property (strong, nonatomic) id<RegistrationTransientStateMutator> registrationTransientStateMutator;
@property (strong, nonatomic) id<UIAlertViewFactory> UIAlertViewFactory;
@property (strong, nonatomic) id<UIAlertViewSelectionDetector> UIAlertViewSelectionDetector;
@property (strong, nonatomic) YARegistrationTransientState *registrationTransientState;

// methods

@end

@implementation YARegistrationStepCarrierError

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithRegistrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator uiAlertViewFactory:(id<UIAlertViewFactory>)aUIAlertViewFactory uiAlertViewSelectionDetector:(id<UIAlertViewSelectionDetector>)aUIAlertViewSelectionDetector registrationTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate
{
    self = [super init];
    
    if (self) 
    {
        [self setRegistrationTransientStateMutator:aRegistrationTransientStateMutator];
        [self setUIAlertViewFactory:aUIAlertViewFactory];
        [self setUIAlertViewSelectionDetector:aUIAlertViewSelectionDetector];
        [self setRegistrationTransientState:aRegistrationTransientState];
        [self setRegistrationStepDelegate:aDelegate];
    }
    
    return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize registrationStepDelegate;
@synthesize registrationTransientState;
@synthesize registrationTransientStateMutator;
@synthesize UIAlertViewFactory;
@synthesize UIAlertViewSelectionDetector;

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <UIAlertViewDelegate> delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    YARegistrationTransientState *transientState = [self registrationTransientState];
    
    if ([[self UIAlertViewSelectionDetector] clickedButtonIndex:buttonIndex isCancelButtonIndexForUIAlertView:alertView])
    {
        [[self registrationTransientStateMutator] updateRegistrationTransientState:transientState withRegistrationAborted:YES];
    }
    else
    {
        [[self registrationTransientStateMutator] updateRegistrationTransientState:transientState withCarrierIsSupported:nil];
    }
    
    [[self registrationStepDelegate] stepDidCompleteWithMutatedTransientState:transientState];
}

// Public methods
#pragma mark -
#pragma mark Public methods

- (void)execute
{
    NSArray *otherButtonTitles = [NSArray arrayWithObject:REGISTRATION_STEP_CARRIER_ERROR_RETRY];
    UIAlertView *alertView = [[self UIAlertViewFactory] createWithTitle:REGISTRATION_STEP_CARRIER_ERROR_TITLE
                                                                message:REGISTRATION_STEP_CARRIER_ERROR_MESSAGE
                                                               delegate:self 
                                                      cancelButtonTitle:REGISTRATION_STEP_CARRIER_ERROR_CANCEL
                                                      otherButtonTitles:otherButtonTitles];
    
    [alertView show];
}


// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YARegistrationStepCarrierError ()

@end
