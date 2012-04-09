//
//  YAUserProfileViewController.m
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileViewController.h"
#import <QuartzCore/QuartzCore.h>

// Private class extension
@interface YAUserProfileViewController ()

// @property definitions
@property (nonatomic, strong) UITextField *firstNameField;
@property (nonatomic, strong) UITextField *lastNameField;

// methods
+ (CGColorRef)roundedRectBorderColor;
+ (UIColor *)navigationItemFontColor;

- (void)configureRoundRectUI;
- (void)textFieldDidEndEditing:(id)sender;
- (UITextField *)getFirstNameField;
- (UITextField *)getLastNameField;
- (UITextField *)createTextField;

@end

CGFloat const kRoundedRectCornerRadius = 8.0;
CGFloat const kRoundedRectBorderWidth = 1.0;
NSString * const kNormalButtonImage = @"normalButton.png";
NSString * const kPressedButtonImage = @"pressedButton.png";
NSString * const kTitleImage = @"navTitle.png";
int const kNormalButtonLeftCapWidth = 12;
int const kPressedButtonLeftCapWidth = 12;
int const kNavigationBarWidth = 320;
int const kNavigationBarHeight = 44;
CGFloat const kNavigationItemFontSize = 20;
CGFloat const kTextFieldFontSize = 16;
CGFloat const kTextFieldLeftPadding = 11;
CGFloat const kTextFieldTopPadding = 12;
CGFloat const kTextFieldRightPadding = 37;
int const kCameraButtonIndex = 0;
int const kPhotoLibraryButtonIndex = 1;

@implementation YAUserProfileViewController

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize navItem;
@synthesize roundedRect;
@synthesize table;
@synthesize firstNameField;
@synthesize lastNameField;
@synthesize photoButton;
@synthesize submitButton;
@synthesize delegate;

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
    
    [self configureRoundRectUI];
}

- (void)viewDidUnload
{
    [self setNavItem:nil];
    [self setRoundedRect:nil];
    [self setTable:nil];
    [self setPhotoButton:nil];
    [self setSubmitButton:nil];
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark UITableViewDataSource delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserProfileCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UITextField *textField = [indexPath row] == 0 ? [self getFirstNameField] : [self getLastNameField];
        [[cell contentView] addSubview:textField];
    }
    
    return cell;
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
    
    // update the image to the photo button
    [photoButton setImage:image forState:UIControlStateNormal];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

// Public methods
#pragma mark -
#pragma mark Public methods
- (IBAction)backgroundTap:(id)sender
{
    [[self firstNameField] resignFirstResponder];
    [[self lastNameField] resignFirstResponder];
}

- (IBAction)photoPressed:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] 
                            initWithTitle:kChoosePhotoSourceText
                            delegate:self
                            cancelButtonTitle:kCancelText
                            destructiveButtonTitle:nil
                            otherButtonTitles:kCameraText, kPhotoLibraryText, nil];
    [sheet showInView:[self view]];
}

- (IBAction)submitPressed:(id)sender
{
    // TODO: persist updated user profile information
    if ([self delegate] && [[self delegate] conformsToProtocol:@protocol(UserProfileViewDelegate)]) {
        [[self delegate] userProfileViewController:self dismissUserProfileWithAnimation:YES];
    }
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAUserProfileViewController ()
+ (CGColorRef)roundedRectBorderColor
{
    return [[UIColor lightGrayColor] CGColor];
}

+ (UIColor *)navigationItemFontColor
{
    return [UIColor whiteColor];
}

- (void)configureRoundRectUI
{
    [[roundedRect layer] setCornerRadius:kRoundedRectCornerRadius];
    [[roundedRect layer] setMasksToBounds:YES];
    [[roundedRect layer] setBorderWidth:kRoundedRectBorderWidth];
    [[roundedRect layer] setBorderColor:[YAUserProfileViewController roundedRectBorderColor]];
}

- (void)textFieldDidEndEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (UITextField *)getFirstNameField
{
    if (firstNameField == nil) {
        firstNameField = [self createTextField];
    }
    
    return firstNameField;
}

- (UITextField *)getLastNameField
{
    if (lastNameField == nil) {
        lastNameField = [self createTextField];
    }
    
    return lastNameField;
}

- (UITextField *)createTextField
{
    UIFont *font = [UIFont boldSystemFontOfSize:kTextFieldFontSize];
    int textWidth = [table bounds].size.width - kTextFieldRightPadding;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(kTextFieldLeftPadding, kTextFieldTopPadding, textWidth, [font lineHeight])];
    [textField setFont:font];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
    [textField setEnablesReturnKeyAutomatically:YES];
    
    [textField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];

    return textField;
}

@end
