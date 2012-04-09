//
//  InjectableAppDelegate.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConfiguration.h"
#import "AppReinitializer.h"
#import "TabBarControllerAccessor.h"
#import "LoginViewController.h"
#import "AuthInfoProvider.h"
#import "SessionManager.h"
#import "RegistrationStepCoordinatorFactory.h"
#import "RegistrationRepository.h"
#import "CrumbServiceFactory.h"
#import "UserProfileViewControllerCreator.h"
#import "UIAlertViewFactory.h"
#import "RegistrationErrorCreator.h"
#import "ViewControllerContainer.h"

@protocol ConfigurationHandler;

@protocol InjectableAppDelegate <NSObject>

- (void)injectWithWindow:(UIWindow *)window
   windowBackgroundColor:(UIColor *)windowBackgroundColor 
            userDefaults:(NSUserDefaults *)userDefaults 
        tabBarController:(id<TabBarControllerAccessor>)theTabBarController
     loginViewController:(id<LoginViewController>) aloginViewController
userProfileViewControllerCreator:(id<UserProfileViewControllerCreator>)aUserProfileViewControllerCreator
        authInfoProvider:(id<AuthInfoProvider>)authInfoProvider
          sessionManager:(id<SessionManager>)sessionManager
registrationStepCoordinatorFactory:(id<RegistrationStepCoordinatorFactory>)aRegistrationStepCoordinatorFactory
  registrationRepository:(id<RegistrationRepository>)registrationRepository
     crumbServiceFactory:(id<CrumbServiceFactory>)crumbServiceFactory
    configurationHandler:(id<ConfigurationHandler>)configurationHandler
        appConfiguration:(id<AppConfiguration>)appConfiguration
        appReinitializer:(id<AppReinitializer>)appReinitializer
      uiAlertViewFactory:(id<UIAlertViewFactory>)theAlertViewFactory
registrationErrorCreator:(id<RegistrationErrorCreator>)aRegistrationErrorCreator
navigationControllerContainer:(id<ViewControllerContainer>)aNavigationControllerContainer;

@end
