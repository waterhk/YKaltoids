//
//  YATabBarController.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YATabBarController.h"

// Private class extension
@interface YATabBarController ()

// @property definitions

// methods

@end

@implementation YATabBarController
@synthesize navigationControllerContainer = navigationControllerContainer_;
@synthesize conversationListViewController = conversationListViewController_;
@synthesize contactsListViewController = contactsListViewController_;
@synthesize settingsListViewController = settingsListViewController_;

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark TabBarControllerAccessor delegate methods

- (UITabBarController *)tabBarController
{
    return self;
}

// Public methods
#pragma mark -
#pragma mark Public methods

- (void) viewDidLoad
{
    [super viewDidLoad];

    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];        
}

- (void)presentTabs
{
    if(![[self viewControllers] count])
    {
        NSArray *navigationControllers = [[self navigationControllerContainer] createContainersForRootViewControllers:[NSArray arrayWithObjects:[self conversationListViewController], [self contactsListViewController], [self settingsListViewController], nil]];
        [self setViewControllers:navigationControllers];
    }
    
    [self setSelectedIndex:0]; // Always loads up the conversations tab first. 
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YATabBarController ()

@end
