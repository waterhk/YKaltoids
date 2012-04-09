//
//  YALoginViewController.h
//  altoids
//
//  Created by Stephane Karoubi on 8/23/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "SessionManager.h"
#import "AuthenticationErrorCreator.h"
#import "LoginViewDelegate.h"
#import "NetworkActivityIndicatorStatusBarSpawner.h"
#import "TextFieldFormatter.h"
#import "LoginFormatter.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

@interface YALoginViewController : UITableViewController<LoginViewController,LoginViewDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) id<SessionManager> sessionManager;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) id<AuthenticationErrorCreator> authenticationErrorCreator;
@property (strong, nonatomic) id<NetworkActivityIndicatorStatusBarSpawner> networkActivityIndicatorStatusBarSpawner;
@property (strong, nonatomic) id<TextFieldFormatter> textFieldFormatter;
@property (strong, nonatomic) id<LoginFormatter> loginFormatter;

@property (strong, nonatomic) IBOutlet UITextField* userNameField;
@property (strong, nonatomic) IBOutlet UITextField* passwordField;
@property (strong, nonatomic) IBOutlet UIButton* loginButton;
@property (strong, nonatomic) IBOutlet UIButton* signUpButton;
@property (strong, nonatomic) IBOutlet UILabel* disclaimerLabel;
@property (strong, nonatomic) IBOutlet UILabel* versionLabel;
@property (strong, nonatomic) IBOutlet UILabel* copyrightLabel;
@property (strong, nonatomic) IBOutlet UILabel* userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel* passwordLabel;
@property (strong, nonatomic) IBOutlet UIView* userNameCellRepresentation;
@property (strong, nonatomic) IBOutlet UIView* passwordCellRepresentation;
@property (strong, nonatomic) IBOutlet UIImageView* logoImageView;

@property (strong, nonatomic) IBOutlet UITextField* shadowOpacityUED;
@property (strong, nonatomic) IBOutlet UITextField* shadowRadiusUED;
@property (strong, nonatomic) IBOutlet UIView* topShadowLine;
@property (strong, nonatomic) IBOutlet UIView* bottomShadowLine;
@property (strong, nonatomic) IBOutlet UIView* leftShadowLine;
@property (strong, nonatomic) IBOutlet UIView* rightShadowLine;
@property (strong, nonatomic) IBOutlet UIView* userNameCellSeparatorLine;
@property (strong, nonatomic) IBOutlet UIView* passwordCellSeparatorLine;

- (IBAction)loginButtonPressed;
- (IBAction)signInButtonPressed;
- (IBAction)textFieldEditingChanged;
- (IBAction)textFieldDidEndEditing;

@end
