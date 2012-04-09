//
//  YAUserProfileViewControllerCreator.h
//  altoids
//
//  Created by Jon Herron on 12/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchedResultsControllerFactory.h"
#import "FetchRequestCreator.h"
#import "ManagedObjectContextFactory.h"
#import "RegistrationRepository.h"
#import "UIAlertViewFactory.h"
#import "UserProfileViewControllerCreator.h"
#import "UserProfileRepository.h"
#import "UserProfileImageScaler.h"
#import "TextFieldFormatter.h"
#import "TextFormatter.h"

@protocol NavigationBarButtonItemRepository;


// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserProfileViewControllerCreator : NSObject <UserProfileViewControllerCreator>

#pragma mark @property declarations
@property (strong, nonatomic) id<UserProfileRepository> userProfileRepository;
@property (strong, nonatomic) id<FetchedResultsControllerFactory> fetchedResultsControllerFactory;
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) NSString *nibName;
@property (strong, nonatomic) NSBundle *bundle;
@property (strong, nonatomic) id<RegistrationRepository> registrationRepository;
@property (strong, nonatomic) id<FetchRequestCreator> fetchRequestCreator;
@property (strong, nonatomic) NSArray* sortDescriptors;
@property (strong, nonatomic) id<UIAlertViewFactory> uiAlertViewFactory;
@property (strong, nonatomic) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;
@property (strong, nonatomic) id<UserProfileImageScaler> userProfileImageScaler;
@property (strong, nonatomic) id<TextFieldFormatter> textFieldFormatter;
@property (strong, nonatomic) id<TextFormatter> textFormatter;

#pragma mark  Class methods

#pragma mark Instance methods

@end
