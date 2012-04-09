//
//  AppDelegate.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InjectableAppDelegate.h"
#import "TabBarControllerAccessor.h"
#import "LoginViewController.h"
#import "RegistrationStepCoordinator.h"
#import "RegistrationStepCoordinatorDelegate.h"
#import "SessionManager.h"
#import "YSMSessionManager.h"
#import "CrumbServiceDelegate.h"
#import "UserProfileViewDelegate.h"

@class AppFactory;

@interface AppDelegate : UIResponder <UIApplicationDelegate, InjectableAppDelegate, SessionManagerDelegate, RegistrationStepCoordinatorDelegate, CrumbServiceDelegate, UserProfileViewDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)beginFirstTimeUseFlow;
- (void)resetApplicationIfNeeded;
- (void)updateAuthInfoAndRetrieveCrumbsForSession;
- (void)retrieveCrumbsForSession;
- (void)setRootViewController;
- (void)showApplication;

@end
