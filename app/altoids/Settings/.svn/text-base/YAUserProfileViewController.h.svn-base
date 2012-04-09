//
//  YAUserProfileViewController.h
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YABaseViewController.h"
#import "UserProfileViewDelegate.h"
#import "UserProfileViewController.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserProfileViewController : YABaseViewController<UserProfileViewController, UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

#pragma mark @property declarations
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;
@property (nonatomic, strong) IBOutlet UIView *roundedRect;
@property (nonatomic, strong) IBOutlet UITableView *table;
@property (nonatomic, strong) IBOutlet UIButton *photoButton;
@property (nonatomic, strong) IBOutlet UIButton *submitButton;
@property (nonatomic, assign) id<UserProfileViewDelegate> delegate;

#pragma mark  Class methods

#pragma mark Instance methods
- (IBAction)backgroundTap:(id)sender;
- (IBAction)photoPressed:(id)sender;
- (IBAction)submitPressed:(id)sender;
@end
