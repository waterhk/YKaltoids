//
//  YAUserProfileViewController.m
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "YAAddress.h"
#import "YARegistrationInfo.h"
#import "YAPersonImage.h"
#import "NavigationBarButtonItemRepository.h"

#define kNumberOfSectionsInTableView 2
#define kNumberOfRowsInTableViewSection 1

#define kUserNameAndImageSection 0
#define kUserMobileNumberSection 1

// Private class extension
@interface YAUserProfileViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) UIBarButtonItem *cancelButton;
@property (strong, nonatomic) id<FetchRequestCreator> fetchRequestCreator;
@property (strong, nonatomic) NSArray* sortDescriptors;
@property (strong, nonatomic) id<UIAlertViewFactory> uiAlertViewFactory;
@property (assign, nonatomic) BOOL profileIsUpdating;
@property (strong, nonatomic) UIAlertView *failedToUpdateProfileAlertView;

@property (assign, nonatomic, getter = shouldFetchUserInfo) BOOL fetchUserInfo;
- (void)cancelButtonSelected:(id)sender;
- (void)displayProfileUpdateError;
- (void)hideKeyboard;
- (void)updateUserProfile;
- (void)updateUserProfileCompleted;
- (void)setEditControlsEnabled:(BOOL)enabled;
- (void)treatViewWithBorder:(UIView*)view;
@end

int const kCameraButtonIndex = 0;
int const kPhotoLibraryButtonIndex = 1;

@implementation YAUserProfileViewController

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize delegate = delegate_;
@synthesize textFieldFormatter = textFieldFormatter_; 
@synthesize table;
@synthesize headerPrompt;
@synthesize headerPromptLabel;
@synthesize profileInformationWillBePublicDisclaimerView;
@synthesize profileInformationWillBePublicDisclaimerLabel;
@synthesize editProfileButton;
@synthesize doneEditingProfileButton;
@synthesize userImageAndNameTableViewCell;
@synthesize userMobileNumberTableViewCell;
@synthesize userMobileNumberTypeLabel;
@synthesize userMobileNumberLabel;
@synthesize userPhotoNameReadonlyView;
@synthesize userPhotoReadonlyImageView;
@synthesize userNameReadonlyLabel;
@synthesize userPhotoNameEditView;
@synthesize userPhotoEditButton;
@synthesize userFirstNameEditTextField;
@synthesize userLastNameEditTextField;
@synthesize titleViewLabel;
@synthesize userPhotoReadonlyImageBorderView;
@synthesize userPhotoEditButtonBorderView;
@synthesize userPhotoAndNameVerticalRuleView;
@synthesize userNameHorizontalRuleView;
@synthesize userProfileRepository = userProfileRepository_;
@synthesize registrationRepository = registrationRepository_;
@synthesize navigationBarButtonItemRepository = navigationBarButtonItemRepository_;
@synthesize cancelButton = cancelButton_;
@synthesize fetchRequestCreator = fetchRequestCreator_;
@synthesize sortDescriptors = sortDescriptors_;
@synthesize uiAlertViewFactory = uiAlertViewFactory_;
@synthesize fetchUserInfo = fetchUserInfo_;
@synthesize profileIsUpdating = profileIsUpdating_;
@synthesize failedToUpdateProfileAlertView = failedToUpdateProfileAlertView_;
@synthesize userProfileImageScaler = userProfileImageScaler_;
@synthesize textFormatter = textFormatter_;

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

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
                      textFormatter:(id<TextFormatter>)theTextFormatter
{
    self = [super initWithFetchedResultsControllerFactory:aFetchedResultsControllerFactory 
                              managedObjectContextFactory:theManagedObjectContextFactory 
                                                  nibName:nibNameOrNil 
                                                   bundle:nibBundleOrNil];
    
    if (self) {
        userProfileRepository_=userProfileRepository;
        registrationRepository_ = theRegistrationRepository;
        navigationBarButtonItemRepository_ = navigationBarButtonItemRepository;
        fetchRequestCreator_ = fetchRequestCreator;
        sortDescriptors_ = sortDescriptors;
        uiAlertViewFactory_ = uiAlertViewFactory;
        fetchUserInfo_ = YES;
        profileIsUpdating_ = NO;
        userProfileImageScaler_ = theUserProfileImageScaler;
        textFieldFormatter_ = theTextFieldFormatter;
        textFormatter_ = theTextFormatter;
        [self setHidesBottomBarWhenPushed:YES];
    }
    
    return self;
}


// Dealloc
#pragma mark -
#pragma mark dealloc

- (void) dealloc
{
    // Set the fetched results controller's deletegate to nil on dealloc
    // ARC will release the FRC itself
    [[self fetchedResultsController] setDelegate:nil];
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

#pragma mark -
#pragma mark Memory warning

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    // Note: loadView should NOT be used to create a view and instead
    // all views should be created using Nib files
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setEditProfileButton:[[self navigationBarButtonItemRepository] editButtonItemWithTarget:self action:@selector(editProfile:)]];
    [[[self userPhotoEditButton] imageView] setContentMode:UIViewContentModeScaleAspectFit];

    [self setDoneEditingProfileButton:[[self navigationBarButtonItemRepository] doneButtonItemWithTarget:self action:@selector(doneEditingProfile:)]];
    
    [self setCancelButton:[[self navigationBarButtonItemRepository] cancelButtonItemWithTarget:self action:@selector(cancelButtonSelected:)]];

    [self setRightBarButtonItemAsEditProfileButton];
    
    [[self userFirstNameEditTextField] setPlaceholder:kFirstNamePlaceholderText];
    [[self userLastNameEditTextField] setPlaceholder:kLastNamePlaceholderText];
    
    [self setTapRecognizer];

    [self treatViewWithBorder:[self userPhotoReadonlyImageBorderView]];
    [self treatViewWithBorder:[self userPhotoEditButtonBorderView]];
    [self treatViewWithBorder:[self userPhotoAndNameVerticalRuleView]];
    [self treatViewWithBorder:[self userNameHorizontalRuleView]];
        
    [[self navigationItem] setTitleView:[self titleViewLabel]];
    
    [[self tableView] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kScreenBackgroundImage]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    // TODO: show progress indicator
    
    NSError *error;
    YAUser *user = [[self userProfileRepository] createUserWithUserInfo:nil error:&error];
    
    if (!user) 
    {
        // todo: present error dialog
    }
    
    if ([self shouldFetchUserInfo]) {
        [[self userProfileRepository] fetchUserProfileForUserAsync:user];
        [self setFetchUserInfo:NO];
    }
    
    [super viewWillAppear:animated];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
    [self setTable:nil];
    [self setHeaderPrompt:nil];
    [self setHeaderPromptLabel:nil];
    [self setProfileInformationWillBePublicDisclaimerView:nil];
    [self setProfileInformationWillBePublicDisclaimerLabel:nil];
    [self setEditProfileButton:nil];
    [self setDoneEditingProfileButton:nil];
    [self setUserImageAndNameTableViewCell:nil];
    [self setUserMobileNumberTableViewCell:nil];
    [self setUserMobileNumberTypeLabel:nil];
    [self setUserMobileNumberLabel:nil];
    [self setUserPhotoNameReadonlyView:nil];
    [self setUserPhotoNameEditView:nil];
    [self setUserPhotoReadonlyImageView:nil];
    [self setUserNameReadonlyLabel:nil];
    [self setUserPhotoEditButton:nil];
    [self setUserFirstNameEditTextField:nil];
    [self setUserLastNameEditTextField:nil];
    [self setTitleViewLabel:nil];
    [self setUserPhotoEditButtonBorderView:nil];
    [self setUserPhotoAndNameVerticalRuleView:nil];
    [self setUserNameHorizontalRuleView:nil];
    [self setUserPhotoReadonlyImageBorderView:nil];
    [super viewDidUnload];
}

// Overrides
#pragma mark -
#pragma mark Overrides  

// Delegate methods
#pragma mark -
#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == [self userFirstNameEditTextField]) 
    {
        [[self userLastNameEditTextField] becomeFirstResponder];
    }
    else
    {
        [[self userFirstNameEditTextField] becomeFirstResponder];
    }
    
    return NO;
}

#pragma mark -
#pragma mark UITableViewDataSource delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return kNumberOfSectionsInTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kNumberOfRowsInTableViewSection;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if ([indexPath section] == kUserNameAndImageSection)
    {
        cell = [self userImageAndNameTableViewCell];
    }
    else
    {
        cell = [self userMobileNumberTableViewCell];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{   
    if ([indexPath section] == kUserNameAndImageSection) 
    {
        [self configureUserNameAndImageCell:cell];
    }
    else if ([indexPath section] == kUserMobileNumberSection)
    {
        [self configurePhoneNumberCell:cell];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

#pragma mark -
#pragma mark Table view delegate methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    
    if (section == kUserNameAndImageSection) 
    {
        return kParticipantOrUserNameAndImageTableViewCellHeight;
    }
    
    if (section == kUserMobileNumberSection && [self userPhoneNumberIsHidden]) 
    {
        return 0;
    }
    
    return kDefaultTableViewCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section != kUserMobileNumberSection) 
    {
        return nil;
    }
    
    [[self profileInformationWillBePublicDisclaimerLabel] setText:kProfileInformationWillBeMadePublicMessage];
    
    return [self profileInformationWillBePublicDisclaimerView];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark -
#pragma mark UIActionSheetDelegate delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [actionSheet cancelButtonIndex]) {
        return;
    }
    
    UIImagePickerControllerSourceType sourceType;
    
    switch (buttonIndex) {
        case kCameraButtonIndex:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
            
        case kPhotoLibraryButtonIndex:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        default:
            return;
    }
    
    if (!([UIImagePickerController isSourceTypeAvailable:sourceType])) {
        return;
    } 
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setSourceType:sourceType];
    [imagePicker setAllowsEditing:YES];
    
    [self presentModalViewController:imagePicker animated:YES];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // dismiss the image picker
    [self dismissModalViewControllerAnimated:YES];
    
    // get the captured/selected image
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    
    if (image == nil) {
        image = [info valueForKey:UIImagePickerControllerOriginalImage];
    }
    
    if (image == nil) {
        return;
    }
    
    image = [[self userProfileImageScaler] scaleUserProfileImage:image];
    
    [[self userPhotoEditButton] setImage:image forState:UIControlStateNormal];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate methods

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath 
{
    [super controller:controller didChangeObject:anObject atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
    
    if ([self profileIsUpdating] && (type == NSFetchedResultsChangeInsert || type == NSFetchedResultsChangeUpdate)) 
    {
        YAImageUpdateStatus imageUpdateStatus = [[self userProfileRepository] imageUpdateStatusForUser:[self currentUser]];
        YAProfileUpdateStatus profileUpdateStatus = [[self userProfileRepository] profileUpdateStatusForUser:[self currentUser]];
        
        if (imageUpdateStatus == YAImageUpdateStatusError || profileUpdateStatus == YAProfileUpdateStatusError) 
        {
            
            [self displayProfileUpdateError];
        }
        else
        {
            [self updateUserProfileCompleted];
        }
    }
}

// Public methods
#pragma mark -
#pragma mark Public methods

- (IBAction)editProfile:(id)sender 
{
    [self editButtonSelected];
}

- (IBAction)doneEditingProfile:(id)sender 
{
    [self doneButtonSelected];
}

- (IBAction)userNameTextFieldEditingChanged:(id)sender 
{
    [textFieldFormatter_ boldUserInputInTextField:sender evenWhenTextLengthIsGreaterThanOne:NO];    
    [self enableDoneButtonIfFirstAndLastNameAreAvailable];
}

- (IBAction)userImageButtonEditRequested:(id)sender 
{
    UIActionSheet *sheet = [[UIActionSheet alloc] 
                            initWithTitle:nil
                            delegate:self
                            cancelButtonTitle:kCancelText
                            destructiveButtonTitle:nil
                            otherButtonTitles:kCameraText, kPhotoLibraryText, nil];
    
    [sheet showInView:[self view]];
}

- (void)doneButtonSelected
{
    [self updateUserProfile];
}

- (void)editButtonSelected
{
    [self enterEditMode];
}

- (BOOL)hideUserPhoneNumberWhileInEditMode
{
    return YES;
}

- (BOOL)allowEditModeToBeCancelled
{
    return YES;
}

- (void)enterEditMode
{
    [self setRightBarButtonItemAsDoneEditingProfileButton];
    
    if ([self allowEditModeToBeCancelled]) 
    {
        [[self navigationItem] setLeftBarButtonItem:[self cancelButton]];
    }
    
    [[self tableView] setEditing:YES];
    [[self tableView] reloadData];
}

- (void)enterReadonlyMode
{
    [self setRightBarButtonItemAsEditProfileButton];
    
    if ([self allowEditModeToBeCancelled]) 
    {
        [[self navigationItem] setLeftBarButtonItem:nil];
    }

    [[self tableView] setEditing:NO];
    [[self tableView] reloadData];
}

- (void)enableDoneButtonIfFirstAndLastNameAreAvailable
{
    BOOL doneButtonEnabled;
    NSUInteger userFirstNameLength;
    NSUInteger userLastNameLength;
    
    userFirstNameLength = [[[self userFirstNameEditTextField] text] length];
    userLastNameLength = [[[self userLastNameEditTextField] text] length];
    
    doneButtonEnabled = userFirstNameLength > 0 && userLastNameLength > 0;
    
    [[self doneEditingProfileButton] setEnabled:doneButtonEnabled];
}

- (BOOL)userPhoneNumberIsHidden
{
    return [[self tableView] isEditing] && [self hideUserPhoneNumberWhileInEditMode];
}

- (void)setAppropriateFontForTextFields
{
    [textFieldFormatter_ boldUserInputInTextField:[self userFirstNameEditTextField] evenWhenTextLengthIsGreaterThanOne:YES];
    [textFieldFormatter_ boldUserInputInTextField:[self userLastNameEditTextField] evenWhenTextLengthIsGreaterThanOne:YES];
}

- (void)setTapRecognizer
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    [tapRecognizer setCancelsTouchesInView:NO];
    
    [[self view] addGestureRecognizer:tapRecognizer];
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

- (NSFetchedResultsController*)fetchedResultsController
{
    if (!fetchedResultsController) {
        NSFetchRequest *fetchRequest = [[self fetchRequestCreator] fetchRequestForEntity:[NSEntityDescription entityForName:@"User"
                                                                                                     inManagedObjectContext:[self context]]];
        
        [fetchRequest setSortDescriptors:[self sortDescriptors]];
        
        fetchedResultsController = [[self fetchedResultsControllerFactory] createWithFetchRequest:fetchRequest forManagedObjectContext:[self context]
                                                                                         delegate:self];
    }
    
    return fetchedResultsController;
}

- (UITableView *)tableView
{
    return [self table];
}

#pragma mark -
#pragma mark UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView != [self failedToUpdateProfileAlertView]) 
    {
        return;
    }
    
    [self updateUserProfileCompleted];
}

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAUserProfileViewController ()

- (void)configurePhoneNumberCell:(UITableViewCell *)cell
{
    NSString *phoneNumber;
    YARegistrationInfo *registrationInfo;
    
    [cell setHidden:[self userPhoneNumberIsHidden]];
    
    registrationInfo = [[self registrationRepository] existingRegistrationInfo];
    phoneNumber = [registrationInfo phoneNumber];
    
    [[self userMobileNumberTypeLabel] setText:kMobileNumberLabelText];
    [[self userMobileNumberLabel] setText:phoneNumber];
}

- (void)configureUserNameAndImageCell:(UITableViewCell *)cell
{
    BOOL editMode = [[self tableView] isEditing];
 
    if (editMode)
    {
        [[self userPhotoEditButton] setImage:[self profileImageForUser] forState:UIControlStateNormal];
        
        [self updateCurrentUserFirstAndLastNameTextFields];
        
        [[cell contentView] addSubview:[self userPhotoNameEditView]];
    }
    else
    {
        [[self userPhotoReadonlyImageView] setImage:[self profileImageForUser]];
        // todo: use name formatter here
        [[self userNameReadonlyLabel] setText:[NSString stringWithFormat:@"%@ %@", [self currentUserFirstName], [self currentUserLastName]]];
        [[cell contentView] addSubview:[self userPhotoNameReadonlyView]];
    }
    
    [[self userPhotoNameEditView] setHidden:!editMode];
    [[self userPhotoNameReadonlyView] setHidden:editMode];
}

- (UIImage *)profileImageForUser
{
    NSData *profileImageData;
    UIImage *profileImage;
    YAUser *currentUser;
    
    currentUser = [self currentUser];
    profileImageData = [[currentUser image] imageData];
    
    if (profileImageData) 
    {
        profileImage = [UIImage imageWithData:profileImageData];
    }
    else
    {
        profileImage = [UIImage imageNamed:kIconDefaultUserProfileImage];
    }
    
    return profileImage;
}

- (YAUser *)currentUser
{
    return (YAUser *)[[[self fetchedResultsController] fetchedObjects] objectAtIndex:0];
}

- (NSString *)currentUserFirstName
{
    BOOL editMode = [[self tableView] isEditing];
    NSString *firstNameTextFieldText = [[self userFirstNameEditTextField] text];
    
    if (editMode && [firstNameTextFieldText length] > 0)
    {
        return [[self userFirstNameEditTextField] text];
    }
    
    NSString *currentUserFirstName = [textFormatter_ formatTextForDisplay:[[self currentUser] firstName]];
    
    if (!currentUserFirstName) 
    {
        currentUserFirstName = @"";
    }
    
    return currentUserFirstName;
}

- (NSString *)currentUserLastName
{
    BOOL editMode = [[self tableView] isEditing];
    NSString *lastNameTextFieldText = [[self userLastNameEditTextField] text];
    
    if (editMode && [lastNameTextFieldText length] > 0) 
    {
        return [[self userLastNameEditTextField] text];
    }
    
    NSString *currentUserLastName = [textFormatter_ formatTextForDisplay:[[self currentUser] lastName]];
    
    if (!currentUserLastName) 
    {
        currentUserLastName = @"";
    }
    
    return currentUserLastName;
}

- (void)updateCurrentUserFirstAndLastNameTextFields
{
    [[self userFirstNameEditTextField] setText:[self currentUserFirstName]];
    [[self userLastNameEditTextField] setText:[self currentUserLastName]];
    [self enableDoneButtonIfFirstAndLastNameAreAvailable];
    [self setAppropriateFontForTextFields];
}

- (void)setRightBarButtonItemAsEditProfileButton
{
    [[self editProfileButton] setTitle:kEditButtonText];
    [[self navigationItem] setRightBarButtonItem:[self editProfileButton]];
}

- (void)setRightBarButtonItemAsDoneEditingProfileButton
{
    [[self doneEditingProfileButton] setTitle:kDoneButtonText];
    [[self navigationItem] setRightBarButtonItem:[self doneEditingProfileButton]];
}

- (void)cancelButtonSelected:(id)sender
{
    [[self userFirstNameEditTextField] setText:[[self currentUser] firstName]];
    [[self userLastNameEditTextField] setText:[[self currentUser] lastName]];
    
    [self enterReadonlyMode];
}

- (void)displayProfileUpdateError
{
    if (![self failedToUpdateProfileAlertView]) 
    {
        [self setFailedToUpdateProfileAlertView:[[self uiAlertViewFactory] createWithTitle:kErrorTitle 
                                                                                   message:kProfileInfoUpdateErrorMessage 
                                                                                  delegate:self
                                                                         cancelButtonTitle:kOkButtonText 
                                                                         otherButtonTitles:nil]];
    }
    [[self failedToUpdateProfileAlertView] show];
}

- (void)hideKeyboard
{
    [[self userFirstNameEditTextField] resignFirstResponder];
    [[self userLastNameEditTextField] resignFirstResponder];
}

- (void)updateUserProfile
{
    // TODO: Skip if nothing changed?
  
    [self setEditControlsEnabled:NO];
    
    NSError *error = nil;
    UIImage *userProfileImage = [[self userPhotoEditButton] imageForState:UIControlStateNormal];
    
    [[self userProfileRepository] updateUserProfileWithFirstName:[[self userFirstNameEditTextField] text]
                                                        lastName:[[self userLastNameEditTextField] text]
                                                           image:userProfileImage
                                                  viewForOverlay:[self view]
                                                         forUser:[self currentUser]
                                                           error:&error];

    [self setProfileIsUpdating:YES];
}

- (void)updateUserProfileCompleted
{    
    [self setEditControlsEnabled:YES];
    
    [self setProfileIsUpdating:NO];
    
    [self enterReadonlyMode];
}

- (void)setEditControlsEnabled:(BOOL)enabled
{
    [[self cancelButton] setEnabled:enabled];
    [[[self navigationItem] rightBarButtonItem] setEnabled:enabled];
    [[self userFirstNameEditTextField] setEnabled:enabled];
    [[self userLastNameEditTextField] setEnabled:enabled];
    [[self userPhotoEditButton] setEnabled:enabled];
}

- (void)treatViewWithBorder:(UIView*)view
{
    [[view layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[view layer] setBorderWidth:1.0f];
}

@end
