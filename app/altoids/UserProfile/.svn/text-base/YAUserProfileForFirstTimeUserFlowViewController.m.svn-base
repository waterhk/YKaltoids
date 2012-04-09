//
//  YAUserProfileForFirstTimeUserFlowViewController.m
//  altoids
//
//  Created by Jon Herron on 12/8/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileForFirstTimeUserFlowViewController.h"

// Private class extension
@interface YAUserProfileForFirstTimeUserFlowViewController ()

// @property definitions

// methods

@end

@implementation YAUserProfileForFirstTimeUserFlowViewController

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setRightBarButtonItemAsDoneEditingProfileButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self titleViewLabel] setText:kNavigationItemText];
    [[self headerPromptLabel] setText:kFTUHeaderConfirmation];
    
    if (![[self tableView] isEditing]) 
    {
        [self enterEditMode];
    }
}

// Overrides
#pragma mark -
#pragma mark Overrides

- (BOOL)hideUserPhoneNumberWhileInEditMode
{
    return NO;
}

- (BOOL)allowEditModeToBeCancelled
{
    return NO;
}

- (void)updateUserProfileCompleted
{
    [super updateUserProfileCompleted];
    
    [[self delegate] userProfileViewController:self dismissUserProfileWithAnimation:YES];
}

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

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
#pragma mark YAUserProfileForFirstTimeUserFlowViewController ()

@end
