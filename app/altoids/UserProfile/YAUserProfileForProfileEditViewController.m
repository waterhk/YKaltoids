//
//  YAUserProfileForProfileEditViewController.m
//  altoids
//
//  Created by Jon Herron on 12/8/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileForProfileEditViewController.h"

// Private class extension
@interface YAUserProfileForProfileEditViewController ()

// @property definitions

// methods
- (void)hideHeaderPrompt;
- (void)restoreHeaderPrompt;

@end

@implementation YAUserProfileForProfileEditViewController

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
    
    [self enterReadonlyMode];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self hideHeaderPrompt];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self restoreHeaderPrompt];
}

// Overrides
#pragma mark -
#pragma mark Overrides

- (void)enterEditMode
{
    [super enterEditMode];
    
    [[self titleViewLabel] setText:kUserEditProfileViewTitle];
}

- (void)enterReadonlyMode
{
    [super enterReadonlyMode];
    
    [[self titleViewLabel] setText:kUserProfileViewTitle];
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
#pragma mark YAUserProfileForProfileEditViewController ()

- (void)hideHeaderPrompt
{
    CGRect headerPromptFrame = [[self headerPrompt] frame];
    CGRect tableFrame = [[self table] frame];
    
    tableFrame.origin.y -= headerPromptFrame.size.height;
    tableFrame.size.height += headerPromptFrame.size.height;
    
    [[self headerPrompt] setHidden:YES];
    [[self table] setFrame:tableFrame];
}

- (void)restoreHeaderPrompt
{
    CGRect headerPromptFrame = [[self headerPrompt] frame];
    CGRect tableFrame = [[self table] frame];
    
    tableFrame.origin.y += headerPromptFrame.size.height;
    tableFrame.size.height -= headerPromptFrame.size.height;
    
    [[self headerPrompt] setHidden:NO];
    [[self table] setFrame:tableFrame];
}

@end
