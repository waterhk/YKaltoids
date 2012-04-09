//
//  YAUserProfileViewController.h
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//


#import "YABaseFetchEnabledTableViewController.h"
#import "FetchRequestCreator.h"
#import "FetchedResultsControllerFactory.h"
#import "ManagedObjectContextFactory.h"
#import "RegistrationRepository.h"
#import "UIAlertViewFactory.h"
#import "UserProfileHandler.h"
#import "UserProfileViewController.h"
#import "UserProfileViewDelegate.h"
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
@interface YAUserProfileViewController : YABaseFetchEnabledTableViewController<UserProfileViewController, UITableViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

#pragma mark @property declarations
@property (nonatomic, assign) id<UserProfileViewDelegate> delegate;
@property (strong, nonatomic) id<TextFieldFormatter> textFieldFormatter;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *headerPrompt;
@property (strong, nonatomic) IBOutlet UILabel *headerPromptLabel;
@property (strong, nonatomic) IBOutlet UIView *profileInformationWillBePublicDisclaimerView;
@property (strong, nonatomic) IBOutlet UILabel *profileInformationWillBePublicDisclaimerLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editProfileButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneEditingProfileButton;
@property (strong, nonatomic) IBOutlet UITableViewCell *userImageAndNameTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *userMobileNumberTableViewCell;
@property (strong, nonatomic) IBOutlet UILabel *userMobileNumberTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *userMobileNumberLabel;
@property (strong, nonatomic) IBOutlet UIView *userPhotoNameReadonlyView;
@property (strong, nonatomic) IBOutlet UIView *userPhotoReadonlyImageBorderView;
@property (strong, nonatomic) IBOutlet UIImageView *userPhotoReadonlyImageView;
@property (strong, nonatomic) IBOutlet UILabel *userNameReadonlyLabel;
@property (strong, nonatomic) IBOutlet UIView *userPhotoNameEditView;
@property (strong, nonatomic) IBOutlet UIButton *userPhotoEditButton;
@property (strong, nonatomic) IBOutlet UIView *userPhotoEditButtonBorderView;
@property (strong, nonatomic) IBOutlet UIView *userPhotoAndNameVerticalRuleView;
@property (strong, nonatomic) IBOutlet UIView *userNameHorizontalRuleView;
@property (strong, nonatomic) IBOutlet UITextField *userFirstNameEditTextField;
@property (strong, nonatomic) IBOutlet UITextField *userLastNameEditTextField;
@property (strong, nonatomic) IBOutlet UILabel *titleViewLabel;

#pragma mark  Class methods

#pragma mark Instance methods
- (id)initWithUserProfileRepository:(id<UserProfileRepository>)userProfileRepository
    fetchedResultsControllerFactory:(id<FetchedResultsControllerFactory>)aFetchedResultsControllerFactory
        managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory
                            nibName:(NSString *)nibNameOrNil
                             bundle:(NSBundle *)nibBundleOrNil 
             registrationRepository:(id<RegistrationRepository>)theRegistrationRepository
                fetchRequestCreator:(id<FetchRequestCreator>)fetchRequestCreator
                    sortDescriptors:(NSArray*)sortDescriptors
                   alertViewFactory:(id<UIAlertViewFactory>)uiAlertViewFactory
  navigationBarButtonItemRepository:(id<NavigationBarButtonItemRepository>) navigationBarButtonItemRepository 
             userProfileImageScaler:(id<UserProfileImageScaler>)theUserProfileImageScaler
                 textFieldFormatter:(id<TextFieldFormatter>)theTextFieldFormatter
                      textFormatter:(id<TextFormatter>)theTextFormatter;

- (IBAction)editProfile:(id)sender;
- (IBAction)doneEditingProfile:(id)sender;
- (IBAction)userNameTextFieldEditingChanged:(id)sender;
- (IBAction)userImageButtonEditRequested:(id)sender;

@property (strong, nonatomic) id<UserProfileRepository> userProfileRepository;
@property (strong, nonatomic) id<RegistrationRepository> registrationRepository;
@property (strong, nonatomic) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;
@property (strong, nonatomic) id<UserProfileImageScaler> userProfileImageScaler;
@property (strong, nonatomic) id<TextFormatter> textFormatter;


- (void)configurePhoneNumberCell:(UITableViewCell *)cell;
- (void)configureUserNameAndImageCell:(UITableViewCell *)cell;

- (UIImage *)profileImageForUser;
- (YAUser *)currentUser;
- (NSString *)currentUserFirstName;
- (NSString *)currentUserLastName;
- (void)updateCurrentUserFirstAndLastNameTextFields;

- (void)doneButtonSelected;
- (void)editButtonSelected;

- (void)setRightBarButtonItemAsEditProfileButton;
- (void)setRightBarButtonItemAsDoneEditingProfileButton;

- (BOOL)allowEditModeToBeCancelled;
- (BOOL)hideUserPhoneNumberWhileInEditMode;
- (BOOL)userPhoneNumberIsHidden;

- (void)enterEditMode;
- (void)enterReadonlyMode;

- (void)enableDoneButtonIfFirstAndLastNameAreAvailable;
- (void)setAppropriateFontForTextFields;

- (void)setTapRecognizer;
- (void)updateUserProfileCompleted;

@end
