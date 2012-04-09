//
//  YAUserProfileViewControllerCreator.m
//  altoids
//
//  Created by Jon Herron on 12/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileViewControllerCreator.h"
#import "YAUserProfileForFirstTimeUserFlowViewController.h"
#import "YAUserProfileForProfileEditViewController.h"

// Private class extension
@interface YAUserProfileViewControllerCreator ()

// @property definitions

// methods

@end

@implementation YAUserProfileViewControllerCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize userProfileRepository = userProfileRepository_;
@synthesize fetchedResultsControllerFactory = fetchedResultsControllerFactory_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize nibName = nibName_;
@synthesize bundle = bundle_;
@synthesize registrationRepository = registrationRepository_;
@synthesize fetchRequestCreator = fetchRequestCreator_;
@synthesize sortDescriptors = sortDescriptors_;
@synthesize uiAlertViewFactory = uiAlertViewFactory_;
@synthesize navigationBarButtonItemRepository = navigationBarButtonItemRepository_;
@synthesize userProfileImageScaler = userProfileImageScaler_;
@synthesize textFieldFormatter = textFieldFormatter_;
@synthesize textFormatter = textFormatter_;

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
#pragma mark UserProfileViewControllerCreator delegate methods

- (id<UserProfileViewController>)userProfileViewControllerForFTUFlow
{
    return [[YAUserProfileForFirstTimeUserFlowViewController alloc] initWithUserProfileRepository:[self userProfileRepository] 
                                                                  fetchedResultsControllerFactory:[self fetchedResultsControllerFactory] 
                                                                      managedObjectContextFactory:[self managedObjectContextFactory] 
                                                                                          nibName:[self nibName] 
                                                                                           bundle:[self bundle] 
                                                                           registrationRepository:[self registrationRepository]
                                                                              fetchRequestCreator:[self fetchRequestCreator]
                                                                                  sortDescriptors:[self sortDescriptors]
                                                                                 alertViewFactory:[self uiAlertViewFactory]
                                                                navigationBarButtonItemRepository:[self navigationBarButtonItemRepository] 
                                                                           userProfileImageScaler:[self userProfileImageScaler]
                                                                               textFieldFormatter:[self textFieldFormatter]
                                                                                    textFormatter:[self textFormatter]];
}

- (id<UserProfileViewController>)userProfileViewControllerForProfileEdit
{
    return [[YAUserProfileForProfileEditViewController alloc] initWithUserProfileRepository:[self userProfileRepository] 
                                                            fetchedResultsControllerFactory:[self fetchedResultsControllerFactory] 
                                                                managedObjectContextFactory:[self managedObjectContextFactory] 
                                                                                    nibName:[self nibName] 
                                                                                     bundle:[self bundle] 
                                                                     registrationRepository:[self registrationRepository]
                                                                        fetchRequestCreator:[self fetchRequestCreator]
                                                                            sortDescriptors:[self sortDescriptors]
                                                                           alertViewFactory:[self uiAlertViewFactory]
                                                          navigationBarButtonItemRepository:[self navigationBarButtonItemRepository]
                                                                     userProfileImageScaler:[self userProfileImageScaler]
                                                                         textFieldFormatter:[self textFieldFormatter]
                                                                              textFormatter:[self textFormatter]];
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
#pragma mark YAUserProfileViewControllerCreator ()

@end
