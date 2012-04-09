//
//  YALoginViewController.m
//  altoids
//
//  Created by Stephane Karoubi on 8/23/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "YALoginViewController.h"
#import "Strings.h"
#import "Constants.h"

@interface YALoginViewController()
{
@private
    UIEdgeInsets defaultInset_;
}
- (void)setupCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)setupButton:(UIButton *)theButton withImage:(NSString*)theImage forState:(UIControlState)aState;
- (void)setTapRecognizer;
- (UIView*) createShadowLineWithFrame:(CGRect)theFrame shadowColor:(UIColor*)theColor;
@end

@implementation YALoginViewController

@synthesize sessionManager = sessionManager_;
@synthesize activityIndicatorView = activityIndicatorView_;
@synthesize authenticationErrorCreator = authenticationErrorCreator_;
@synthesize networkActivityIndicatorStatusBarSpawner = networkActivityIndicatorStatusBarSpawner_;
@synthesize textFieldFormatter = textFieldFormatter_;
@synthesize loginFormatter = loginFormatter_;

@synthesize userNameField = userNameField_;
@synthesize passwordField = passwordField_;
@synthesize loginButton = loginButton_;
@synthesize signUpButton = signUpButton_;
@synthesize disclaimerLabel = disclaimerLabel_;
@synthesize versionLabel = versionLabel_;
@synthesize copyrightLabel = copyrightLabel_;
@synthesize userNameLabel = userNameLabel_;
@synthesize passwordLabel = passwordLabel_;
@synthesize userNameCellRepresentation = userNameCellRepresentation_;
@synthesize passwordCellRepresentation = passwordCellRepresentation_;
@synthesize logoImageView = logoImageView_;

@synthesize shadowOpacityUED = shadowOpacityUED_;
@synthesize shadowRadiusUED = shadowRadiusUED_;
@synthesize topShadowLine = topShadowLine_;
@synthesize bottomShadowLine = bottomShadowLine_;
@synthesize leftShadowLine = leftShadowLine_;
@synthesize rightShadowLine = rightShadowLine_;
@synthesize userNameCellSeparatorLine = userNameCellSeparatorLine_;
@synthesize passwordCellSeparatorLine = passwordCellSeparatorLine_;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITableView* tableView = [self tableView];
    [tableView setScrollEnabled:NO];
    
    defaultInset_ = [tableView contentInset];
    [self setTapRecognizer];
    
    //Set the background
    UIImageView* imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kLoginScreenBackgroundImage]];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [tableView setBackgroundColor:[UIColor blackColor]];
    [tableView setBackgroundView:imgView];
    
    //add the logo
    [logoImageView_ setImage:[UIImage imageNamed:kHubLogo]];
    
    //Configure buttons
    [self setupButton:loginButton_ withImage:kLoginButtonNormal forState:UIControlStateNormal];
    [self setupButton:loginButton_ withImage:kLoginButtonPressed forState:UIControlStateSelected];
    [self setupButton:loginButton_ withImage:kLoginButtonPressed forState:UIControlStateHighlighted];
    [self setupButton:signUpButton_ withImage:kSignUpButton forState:UIControlStateNormal];
    [self setupButton:signUpButton_ withImage:kSignUpButtonPressed forState:UIControlStateSelected];
    [self setupButton:signUpButton_ withImage:kSignUpButtonPressed forState:UIControlStateHighlighted];
    
    //Establish legal information
    [disclaimerLabel_ setText:kDisclaimerText];
    [versionLabel_ setText:kVersionText];
    [copyrightLabel_ setText:kCopyrightText];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    [[self tableView] reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    userNameField_ = nil;
    passwordField_ = nil;
    loginButton_ = nil;
    signUpButton_ = nil;
    disclaimerLabel_ = nil;
    versionLabel_ = nil;
    copyrightLabel_ = nil;
    userNameLabel_ = nil;
    passwordLabel_ = nil;
    userNameCellRepresentation_ = nil;
    passwordCellRepresentation_ = nil;
    logoImageView_ = nil;
    
    shadowOpacityUED_ = nil;
    shadowRadiusUED_ = nil;
    topShadowLine_ = nil;
    bottomShadowLine_ = nil;
    leftShadowLine_ = nil;
    rightShadowLine_ = nil;
    userNameCellSeparatorLine_ = nil;
    passwordCellSeparatorLine_ = nil;
}

#pragma mark -
#pragma mark ViewControllerAccessor

- (UIViewController *)viewController
{
    return self;
}

#pragma mark -
#pragma mark LoginViewDelegate protocol methods

- (void)loginDidBegin
{
    [networkActivityIndicatorStatusBarSpawner_ networkActivityDidBegin];
    [activityIndicatorView_ startAnimating];
}

- (void)loginDidEnd
{
    [networkActivityIndicatorStatusBarSpawner_ networkActivityDidEnd];
    [activityIndicatorView_ stopAnimating];
}

#pragma mark -
#pragma table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section==0) ? 2 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    [self setupCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark -
#pragma mark TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == userNameField_)
    {
        [passwordField_ becomeFirstResponder];
    }
    else
    {
        [self loginButtonPressed];
    }    
    return YES;
}

#pragma mark -
#pragma mark UIKeyboardDidShowNotification method

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [[self tableView] scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (void)keyboardDidHide:(NSNotification *)aNotification
{
   
    if (!(userNameField_.isFirstResponder || passwordField_.isFirstResponder)){
    
    [UIView animateWithDuration:0.3 animations:^
    {
        [[self tableView] setContentInset:defaultInset_];
    }];
    }
}

#pragma mark -
#pragma mark keyboard response to tap
- (void)hideKeyboard
{
    [userNameField_ resignFirstResponder];
    [passwordField_ resignFirstResponder];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)loginButtonPressed
{
    NSString* usrName = [userNameField_ text];
    NSString* pwd = [passwordField_ text];
    
    if ([usrName length] == 0 ||
        [pwd length] == 0) 
    {
        NSError *error = [[self authenticationErrorCreator] errorWithCode:YSMAuthenticationErrorCodeEmptyUsernameOrPassword];
        UIAlertView *nilArgsAlert = [[UIAlertView alloc] initWithTitle:nil 
                                                               message:[error localizedDescription] 
                                                              delegate:nil 
                                                     cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel Button") 
                                                     otherButtonTitles:nil];
        [nilArgsAlert show];
        return;
    }
    [[self sessionManager] loginWithDelegate:self username:[loginFormatter_ formatUserName:usrName] andPassword:pwd];
}

- (IBAction)signInButtonPressed
{
    //TODO: Add New to Yahoo! actions
}

- (IBAction)textFieldEditingChanged
{
    [textFieldFormatter_ boldUserInputInTextField:userNameField_ evenWhenTextLengthIsGreaterThanOne:NO];
    [textFieldFormatter_ boldUserInputInTextField:passwordField_ evenWhenTextLengthIsGreaterThanOne:NO];
}

- (IBAction)textFieldDidEndEditing
{
    [textFieldFormatter_ boldUserInputInTextField:userNameField_ evenWhenTextLengthIsGreaterThanOne:YES];
    [textFieldFormatter_ boldUserInputInTextField:passwordField_ evenWhenTextLengthIsGreaterThanOne:YES];
}

#pragma mark -
#pragma mark Private methods

- (void)setupCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    CGRect cellFrame = [[cell contentView] frame];
    CGRect fieldFrame = [userNameField_ frame];
    CGRect passwordFrame = [passwordField_ frame];
    CGFloat trueCellWidth = cellFrame.size.width - 20;
   
    //Align the text field to where UED sets it in IB
    fieldFrame.size.width = trueCellWidth - fieldFrame.origin.x;
    passwordFrame.size.width = trueCellWidth - fieldFrame.origin.x;
    
    //Add a shadow box
    UIView* shadowBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, trueCellWidth, (cellFrame.size.height * 2))];
    
    [shadowBox addSubview:[self createShadowLineWithFrame:[topShadowLine_ frame] shadowColor:[topShadowLine_ backgroundColor]]];
    [shadowBox addSubview:[self createShadowLineWithFrame:[bottomShadowLine_ frame] shadowColor:[bottomShadowLine_ backgroundColor]]];
    [shadowBox addSubview:[self createShadowLineWithFrame:[leftShadowLine_ frame] shadowColor:[leftShadowLine_ backgroundColor]]];
    [shadowBox addSubview:[self createShadowLineWithFrame:[rightShadowLine_ frame] shadowColor:[rightShadowLine_ backgroundColor]]];

    //Switch on groupings
    switch ([indexPath section])
    {
        case 0:
            if (row == 0)
            {
                //Add inner shadow
                [[cell contentView] addSubview:shadowBox];
                
                //Set the cell background
                UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kUsernameCellBackgroundImage]];
                [img setContentMode:UIViewContentModeScaleAspectFill];
                [[cell contentView] addSubview:img];
                
                //Add username field
                [userNameLabel_ setText:kUsernameLabelText];
                [userNameField_ setPlaceholder:kUsernameGhostText];
                [userNameField_ setFrame:fieldFrame];
                [[cell contentView] addSubview:userNameLabel_];
                [[cell contentView] addSubview:userNameField_];
                [cell setBackgroundColor:[userNameCellRepresentation_ backgroundColor]];
                
                //Add an extra cell separation line
                [[cell contentView] addSubview:userNameCellSeparatorLine_];
            }
            else if (row == 1)
            {
                //Set the cell background
                UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kPasswordCellBackgroundImage]];
                [img setContentMode:UIViewContentModeScaleAspectFill];
                [[cell contentView] addSubview:img];
                
                //Add an extra cell separation line
                [[cell contentView] addSubview:passwordCellSeparatorLine_];
                
                //Add password field
                [passwordLabel_ setText:kPasswordLabelText];
                [passwordField_ setPlaceholder:kPasswordGhostText];
                [passwordField_ setFrame:fieldFrame];
                [[cell contentView] addSubview:passwordLabel_];
                [[cell contentView] addSubview:passwordField_];
                [cell setBackgroundColor:[passwordCellRepresentation_ backgroundColor]];
            }
            break;
        case 1:
            if (row == 0)
            {
                //Sign in button
                [loginButton_ setTitle:kLoginButtonText forState:UIControlStateNormal];
                [[cell contentView] addSubview:loginButton_];
                [cell setAccessoryView:activityIndicatorView_];
                [cell setBackgroundColor:[UIColor clearColor]];
            }
            break;
        case 2:
            if (row == 0)
            {
                //New to Yahoo! button
                [signUpButton_ setTitle:kYahooButtonText forState:UIControlStateNormal];
                [[cell contentView] addSubview:signUpButton_];
                [cell setBackgroundColor:[UIColor clearColor]];
            }
            break;
        default:
            break;
    }
}

- (void)setupButton:(UIButton *)theButton withImage:(NSString*)theImage forState:(UIControlState)aState
{
    UIImage* buttonImage = [UIImage imageNamed:theImage];
    
    CGSize imageSize = [buttonImage size];   
    NSInteger leftCapWidth = floorf(imageSize.width / 2);
    
    // use backgroundImage rather than image to get the image to stretch to fit the button
    [theButton setBackgroundImage:[buttonImage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:0] forState:aState];
}

- (void)setTapRecognizer
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    [tapRecognizer setCancelsTouchesInView:NO];
    
    [[self view] addGestureRecognizer:tapRecognizer];
}

- (UIView*) createShadowLineWithFrame:(CGRect)theFrame shadowColor:(UIColor*)theColor
{
    CGColorRef color = [theColor CGColor];
    float opacity = [[shadowOpacityUED_ text] floatValue];
    float radius = [[shadowRadiusUED_ text] floatValue];
    UIView* boxLine = [[UIView alloc] initWithFrame:theFrame];
    [boxLine setBackgroundColor:[UIColor clearColor]];
    [boxLine setAutoresizingMask:0x3f];
    CGRect pathFrame = [boxLine frame];
    pathFrame.origin = CGPointZero;
    
    CALayer* shadowLayer = [boxLine layer];
    [shadowLayer setShadowColor:color];
    [shadowLayer setShadowOpacity:opacity];
    [shadowLayer setShadowRadius:radius];
    CGPathRef path = [[UIBezierPath bezierPathWithRect:pathFrame] CGPath];
    [shadowLayer setShadowPath:path];
    
    return boxLine;
}

@end
