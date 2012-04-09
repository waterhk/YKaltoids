//
//  YASettingsListViewController.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewControllerAccessor.h"
#import "UserProfileViewControllerCreator.h"
#import "ReportProblemViewController.h"
#import "UserProfileRepository.h"
#import "TextFormatter.h"
#import "ImageScaler.h"

@protocol NavigationBarButtonItemRepository;

@interface YASettingsListViewController : UITableViewController<ViewControllerAccessor>

@property (strong, nonatomic) id<UserProfileViewControllerCreator> userProfileViewControllerCreator;
@property (strong, nonatomic) id<ViewControllerAccessor> aboutViewController;
@property (strong, nonatomic) id<ViewControllerAccessor> notificationSoundsViewController;
@property (strong, nonatomic) id<ViewControllerAccessor> deactivateViewController;
@property (strong, nonatomic) id<UserProfileRepository> userProfileRepository;
@property (strong, nonatomic) id<ViewControllerAccessor> reportProblemViewController;
@property (strong, nonatomic) NSArray* cellOptionsHeaderTitles;
@property (assign, nonatomic) BOOL switchNotificationSoundState;
@property (strong, nonatomic) id<TextFormatter> textFormatter;
@property (strong, nonatomic) id<ImageScaler> imageScaler;
@property (nonatomic, strong) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;

- (YAUser *)currentUser;

@end
