//
//  AppDelegateTests.m
//  altoids
//
//  Created by Jon Herron on 3/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "YSMAccountInfo.h"
#import "YARegistrationInfo.h"
#import "TabBarControllerAccessor.h"


@interface AppDelegateTests : SenTestCase

- (void)verifyMocks;

@end

@implementation AppDelegateTests

id windowMock;
id windowBackgroundColorMock;
id userDefaultsMock;
id tabBarControllerAccessorMock;
id tabBarControllerMock;
id loginViewControllerMock;
id userProfileViewControllerCreatorMock;
id userProfileViewControllerMock;
id authInfoProviderMock;
id sessionManagerMock;
id registrationStepCoordinatorFactoryMock;
id registrationStepCoordinatorMock;
id registrationRepositoryMock;
id crumbServiceFactoryMock;
id crumbServiceMock;
id configurationHandlerMock;
id appConfigurationMock;
id appReinitializerMock;
id uiAlertViewFactoryMock;
id alertViewMock;
id registrationErrorCreatorMock;
id navigationControllerContainerMock;
id errorMock;

AppDelegate *appDelegate;
YSMAccountInfo *accountInfo;

- (void)setUp
{
    windowMock = [OCMockObject mockForClass:[UIWindow class]];
    windowBackgroundColorMock = [OCMockObject mockForClass:[UIColor class]];
    userDefaultsMock = [OCMockObject mockForClass:[NSUserDefaults class]];
    
    tabBarControllerAccessorMock = [OCMockObject mockForProtocol:@protocol(TabBarControllerAccessor)];
    tabBarControllerMock = [OCMockObject mockForClass:[UITabBarController class]];
    
    loginViewControllerMock = [OCMockObject mockForProtocol:@protocol(LoginViewController)];
    userProfileViewControllerCreatorMock = [OCMockObject mockForProtocol:@protocol(UserProfileViewControllerCreator)];
    userProfileViewControllerMock = [OCMockObject mockForProtocol:@protocol(UserProfileViewController)];
    authInfoProviderMock = [OCMockObject mockForProtocol:@protocol(AuthInfoProvider)];
    sessionManagerMock = [OCMockObject mockForProtocol:@protocol(SessionManager)];
    registrationStepCoordinatorFactoryMock = [OCMockObject mockForProtocol:@protocol(RegistrationStepCoordinatorFactory)];
    registrationStepCoordinatorMock = [OCMockObject mockForProtocol:@protocol(RegistrationStepCoordinator)];
    registrationRepositoryMock = [OCMockObject mockForProtocol:@protocol(RegistrationRepository)];
    crumbServiceFactoryMock = [OCMockObject mockForProtocol:@protocol(CrumbServiceFactory)];
    crumbServiceMock = [OCMockObject mockForProtocol:@protocol(CrumbService)];
    configurationHandlerMock = [OCMockObject mockForProtocol:@protocol(ConfigurationHandler)];
    appConfigurationMock = [OCMockObject mockForProtocol:@protocol(AppConfiguration)];
    appReinitializerMock = [OCMockObject mockForProtocol:@protocol(AppReinitializer)];
    uiAlertViewFactoryMock = [OCMockObject mockForProtocol:@protocol(UIAlertViewFactory)];
    alertViewMock = [OCMockObject mockForClass:[UIAlertView class]];
    registrationErrorCreatorMock = [OCMockObject mockForProtocol:@protocol(RegistrationErrorCreator)];
    navigationControllerContainerMock = [OCMockObject mockForProtocol:@protocol(ViewControllerContainer)];
    errorMock = [OCMockObject mockForClass:[NSError class]];
    
    appDelegate = [[AppDelegate alloc] init];
    accountInfo = [[YSMAccountInfo alloc] init];
    
    [[windowMock expect] setBackgroundColor:windowBackgroundColorMock];
    [[sessionManagerMock expect] setDelegate:appDelegate];
    [[[registrationStepCoordinatorFactoryMock expect] andReturn:registrationStepCoordinatorMock] registrationStepCoordinatorWithDelegate:appDelegate];
    [[[sessionManagerMock expect] andReturn:accountInfo] getAccountInfo];
    [[authInfoProviderMock expect] updateAuthenticationInfo:accountInfo];
    
    [appDelegate injectWithWindow:windowMock windowBackgroundColor:windowBackgroundColorMock userDefaults:userDefaultsMock tabBarController:tabBarControllerAccessorMock loginViewController:loginViewControllerMock userProfileViewControllerCreator:userProfileViewControllerCreatorMock authInfoProvider:authInfoProviderMock sessionManager:sessionManagerMock registrationStepCoordinatorFactory:registrationStepCoordinatorFactoryMock registrationRepository:registrationRepositoryMock crumbServiceFactory:crumbServiceFactoryMock configurationHandler:configurationHandlerMock appConfiguration:appConfigurationMock appReinitializer:appReinitializerMock uiAlertViewFactory:uiAlertViewFactoryMock registrationErrorCreator:registrationErrorCreatorMock navigationControllerContainer:navigationControllerContainerMock];
}

- (void)testOnSuccessfulLoginAuthenticationInfoIsUpdatedAndCrumbsAreRequested
{
    [[[sessionManagerMock expect] andReturn:accountInfo] getAccountInfo];
    [[authInfoProviderMock expect] updateAuthenticationInfo:accountInfo];
    
    [[[crumbServiceFactoryMock expect] andReturn:crumbServiceMock] createWithDelegate:appDelegate];
    [[[sessionManagerMock expect] andReturn:accountInfo] getAccountInfo];
    
    [[crumbServiceMock expect] requestProfileCrumbWithAccountInfo:accountInfo];
    [[crumbServiceMock expect] requestCrumbWithAccountInfo:accountInfo];
    
    [appDelegate sessionManagerDidSucceed:sessionManagerMock];
    
    [self verifyMocks];
}

- (void)testIfLoginFailsErrorDialogIsDisplayedToTheUser
{
    NSString *errorMsg = @"Msg";
    
    [[[errorMock expect] andReturn:errorMsg] localizedDescription];
    
    [[[uiAlertViewFactoryMock expect] andReturn:alertViewMock] createWithTitle:nil message:errorMsg delegate:nil cancelButtonTitle:kCancelButtonText otherButtonTitles:nil];
    [[alertViewMock expect] show];
    
    [appDelegate sessionManagerDidFail:sessionManagerMock withError:errorMock];
    
    [self verifyMocks];
}

- (void)testIfCrumbsCannotBeRetrievedErrorDialogIsDisplayedToTheUser
{
    [[tabBarControllerAccessorMock expect] presentTabs];
    
    NSString *errorMsg = @"Msg";
    
    [[[errorMock expect] andReturn:errorMsg] localizedDescription];
    
    [[[uiAlertViewFactoryMock expect] andReturn:alertViewMock] createWithTitle:nil message:errorMsg delegate:nil cancelButtonTitle:kCancelButtonText otherButtonTitles:nil];
    [[alertViewMock expect] show];
    
    [appDelegate crumbService:crumbServiceMock didFailWithError:errorMock];
    
    [self verifyMocks];
}

- (void)testOnceCrumbsHaveBeenRetrievedRegistrationWillBeginIfUserHasNotAlreadyRegistered
{
    BOOL registrationRequired = YES;
    NSString *crumb = @"crumb";
    NSString *guid = @"guid";
    
    [[authInfoProviderMock expect] updateApplicationCrumb:crumb];
    [[authInfoProviderMock expect] updateUserGuid:guid];
    
    [[[registrationRepositoryMock expect] andReturnValue:OCMOCK_VALUE(registrationRequired)] registrationRequired];
    [[registrationStepCoordinatorMock expect] performRegistrationFromCurrentViewController:loginViewControllerMock];
    
    [appDelegate crumbService:crumbServiceMock didReceiveCrumb:crumb guid:guid];
    
    [self verifyMocks];
}

- (void)testOnceCrumbsHaveBeenRetrievedAppWillBeShownIfUserHasAlreadyRegistered
{
    BOOL registrationRequired = NO;
    NSString *crumb = @"crumb";
    NSString *guid = @"guid";
    
    [[authInfoProviderMock expect] updateApplicationCrumb:crumb];
    [[authInfoProviderMock expect] updateUserGuid:guid];
    
    [[[registrationRepositoryMock expect] andReturnValue:OCMOCK_VALUE(registrationRequired)] registrationRequired];
    
    [[tabBarControllerAccessorMock expect] presentTabs];
    
    [appDelegate crumbService:crumbServiceMock didReceiveCrumb:crumb guid:guid];
    
    [self verifyMocks];
}

- (void)testOnceProfileCrumbHasBeenRetrievedItWillBeSetOnAuthInfoProvider
{
    NSString *profileCrumb = @"profile_crumb";
    
    [[authInfoProviderMock expect] updateProfileCrumb:profileCrumb];
    
    [appDelegate crumbService:crumbServiceMock didReceiveProfileCrumb:profileCrumb];
    
    [self verifyMocks];
}

- (void)testIfProfileCrumbCannotBeRetrievedAnErrorDialogIsDisplayed
{
    NSString *errorMsg = @"Msg";
    
    [[[errorMock expect] andReturn:errorMsg] localizedDescription];
    
    [[[uiAlertViewFactoryMock expect] andReturn:alertViewMock] createWithTitle:nil message:errorMsg delegate:nil cancelButtonTitle:kCancelButtonText otherButtonTitles:nil];
    [[alertViewMock expect] show];
    
    [appDelegate crumbService:crumbServiceMock didFailProfileCrumbWithError:errorMock];
    
    [self verifyMocks];
}

- (void)testWhenRegistrationCompletesRegistrationInfoIsUpdatedAndUserProfileScreenIsPresentedAsModalViewController
{
    NSString *phoneNumber = @"phonenum";
    NSString *token = @"token";
    NSDate *date = [NSDate date];
    id regInfoMock = [OCMockObject mockForClass:[YARegistrationInfo class]];
    
    [[[registrationRepositoryMock expect] andReturn:regInfoMock] createRegistrationInfo];
    [[registrationRepositoryMock expect] setPhoneNumber:phoneNumber registrationInfo:regInfoMock];
    [[registrationRepositoryMock expect] setExpirationDate:date registrationInfo:regInfoMock];
    [[registrationRepositoryMock expect] setToken:token registrationInfo:regInfoMock];
    
    [[registrationRepositoryMock expect] saveRegistration:regInfoMock error:[OCMArg setTo:nil]];
    
    id userProfileViewControllerAccessorMock = [OCMockObject mockForProtocol:@protocol(UserProfileViewController)];
    [[[userProfileViewControllerCreatorMock expect] andReturn:userProfileViewControllerAccessorMock] userProfileViewControllerForFTUFlow];
    [[userProfileViewControllerAccessorMock expect] setDelegate:appDelegate];
    
    id userProfileViewControllerMock = [OCMockObject mockForClass:[UIViewController class]];
    [[[userProfileViewControllerAccessorMock expect] andReturn:userProfileViewControllerMock] viewController];
    
    id navControllerMock = [OCMockObject mockForClass:[UINavigationController class]];
    [[[navigationControllerContainerMock expect] andReturn:navControllerMock] createContainerForRootViewController:userProfileViewControllerMock];
    
    id vcMock = [OCMockObject mockForClass:[UIViewController class]];
    [[[loginViewControllerMock expect] andReturn:vcMock] viewController];
    
    [[vcMock expect] presentModalViewController:OCMOCK_ANY animated:NO];
    
    [appDelegate registrationDidCompleteWithPhoneNumber:phoneNumber bindToken:token expirationDate:date];
    
    [self verifyMocks];
}

- (void)testIfRegistrationFailsAnErrorMessageIsDisplayedToTheUser
{
    NSString *localizedDescription = @"errMsg";
    
    [[[registrationErrorCreatorMock expect] andReturn:errorMock] errorWithCode:YARegistrationErrorCodeGeneralError];
    
    [[[errorMock expect] andReturn:localizedDescription] localizedDescription];
    
    [[[uiAlertViewFactoryMock expect] andReturn:alertViewMock] createWithTitle:nil message:localizedDescription delegate:nil cancelButtonTitle:kCancelButtonText otherButtonTitles:nil];
    [[alertViewMock expect] show];
    
    [appDelegate registrationDidFail];
    
    [self verifyMocks];
}

- (void)testAfterUserProfileHasBeenSavedDuringFTUFlowTheMainApplicationIsShown
{
    [[userDefaultsMock expect] setBool:YES forKey:kRegistrationCompleted];
    
    id vcMock = [OCMockObject mockForClass:[UIViewController class]];
    
    [[[windowMock expect] andReturn:vcMock] rootViewController];
    [[vcMock expect] dismissModalViewControllerAnimated:NO];
    [[tabBarControllerAccessorMock expect] presentTabs];
    
    [appDelegate userProfileViewController:userProfileViewControllerMock dismissUserProfileWithAnimation:NO];
    
    [self verifyMocks];
}

- (void)testWhenFirstTimeUserFlowIsStartedRegistrationIsMarkedAsIncompleteAndLoginViewControllerIsPresented
{
    [[userDefaultsMock expect] setBool:NO forKey:kRegistrationCompleted];
    
    id loginVCMock = [OCMockObject mockForClass:[UIViewController class]];
    [[[loginViewControllerMock expect] andReturn:loginVCMock] viewController];
    
    id rootVCMock = [OCMockObject mockForClass:[UIViewController class]];
    [[[windowMock expect] andReturn:rootVCMock] rootViewController];
    
    [[rootVCMock expect] presentModalViewController:loginVCMock animated:NO];
    
    [appDelegate beginFirstTimeUseFlow];
    
    [self verifyMocks];
}

- (void)testResetApplicationIfNeededWillResetApplicationIfRegistrationHasNotCompleted
{
    BOOL registrationCompleted = NO;
    BOOL resetOnLaunch = NO;
    
    [[[userDefaultsMock expect] andReturnValue:OCMOCK_VALUE(registrationCompleted)] boolForKey:kRegistrationCompleted];
    [[[appConfigurationMock expect] andReturnValue:OCMOCK_VALUE(resetOnLaunch)] resetOnLaunch];
    
    [[sessionManagerMock expect] logout];
    [[appReinitializerMock expect] reset];
    [[appConfigurationMock expect] setResetOnLaunch:NO];
    
    [appDelegate resetApplicationIfNeeded];
    
    [self verifyMocks];
}

- (void)testResetApplicationIfNeededWillResetApplicationIfResetOnLaunchIsTrue
{
    BOOL registrationCompleted = YES;
    BOOL resetOnLaunch = YES;
    
    [[[userDefaultsMock expect] andReturnValue:OCMOCK_VALUE(registrationCompleted)] boolForKey:kRegistrationCompleted];
    [[[appConfigurationMock expect] andReturnValue:OCMOCK_VALUE(resetOnLaunch)] resetOnLaunch];
    
    [[sessionManagerMock expect] logout];
    [[appReinitializerMock expect] reset];
    [[appConfigurationMock expect] setResetOnLaunch:NO];
    
    [appDelegate resetApplicationIfNeeded];
    
    [self verifyMocks];
}

- (void)testResetApplicationIfNeededWillNotResetApplicationIfRegistrationHasCompletedAndResetOnLaunchIsNO
{
    BOOL registrationCompleted = YES;
    BOOL resetOnLaunch = NO;
    
    [[[userDefaultsMock expect] andReturnValue:OCMOCK_VALUE(registrationCompleted)] boolForKey:kRegistrationCompleted];
    [[[appConfigurationMock expect] andReturnValue:OCMOCK_VALUE(resetOnLaunch)] resetOnLaunch];
    
    [appDelegate resetApplicationIfNeeded];
    
    [self verifyMocks];
}

- (void)testUpdateAuthInfoAndRetrieveCrumbsForSessionWillWellUpdateAuthInfoAndRetrieveCrumbsForSession
{
    [[[sessionManagerMock expect] andReturn:accountInfo] getAccountInfo];
    [[authInfoProviderMock expect] updateAuthenticationInfo:accountInfo];
    
    [[[crumbServiceFactoryMock expect] andReturn:crumbServiceMock] createWithDelegate:appDelegate];
    [[[sessionManagerMock expect] andReturn:accountInfo] getAccountInfo];
    
    [[crumbServiceMock expect] requestProfileCrumbWithAccountInfo:accountInfo];
    [[crumbServiceMock expect] requestCrumbWithAccountInfo:accountInfo];
    
    [appDelegate updateAuthInfoAndRetrieveCrumbsForSession];
    
    [self verifyMocks];
}

- (void)testRetrieveCrumbsForSessionWillRetrieveCrumbsForSession
{
    [[[crumbServiceFactoryMock expect] andReturn:crumbServiceMock] createWithDelegate:appDelegate];
    [[[sessionManagerMock expect] andReturn:accountInfo] getAccountInfo];
    
    [[crumbServiceMock expect] requestProfileCrumbWithAccountInfo:accountInfo];
    [[crumbServiceMock expect] requestCrumbWithAccountInfo:accountInfo];
    
    [appDelegate retrieveCrumbsForSession];
    
    [self verifyMocks];
}

- (void)testSetRootViewControllerWillSetRootViewController
{
    [[[tabBarControllerAccessorMock expect] andReturn:tabBarControllerMock] tabBarController];
    [[windowMock expect] setRootViewController:tabBarControllerMock];
    [[windowMock expect] makeKeyAndVisible];
    
    [appDelegate setRootViewController];
    
    [self verifyMocks];
}

- (void)testShowApplicationWillUpdateAuthInfoAndRetrieveCrumbsForSessionIfUserIsLoggedIn
{
    BOOL hasSession = YES;

    BOOL registrationCompleted = YES;
    BOOL resetOnLaunch = YES;
    
    [[[userDefaultsMock expect] andReturnValue:OCMOCK_VALUE(registrationCompleted)] boolForKey:kRegistrationCompleted];
    [[[appConfigurationMock expect] andReturnValue:OCMOCK_VALUE(resetOnLaunch)] resetOnLaunch];
    
    [[sessionManagerMock expect] logout];
    [[appReinitializerMock expect] reset];
    [[appConfigurationMock expect] setResetOnLaunch:NO];
    
    [[[sessionManagerMock expect] andReturnValue:OCMOCK_VALUE(hasSession)] hasSession];
    [[[sessionManagerMock expect] andReturn:accountInfo] getAccountInfo];
    [[authInfoProviderMock expect] updateAuthenticationInfo:accountInfo];
    
    [[[crumbServiceFactoryMock expect] andReturn:crumbServiceMock] createWithDelegate:appDelegate];
    [[[sessionManagerMock expect] andReturn:accountInfo] getAccountInfo];
    
    [[crumbServiceMock expect] requestProfileCrumbWithAccountInfo:accountInfo];
    [[crumbServiceMock expect] requestCrumbWithAccountInfo:accountInfo];
    
    [appDelegate showApplication];
    
    [self verifyMocks];
}

- (void)testShowApplicationWillLaunchFirstTimeUserFlowIfUserIsNotLoggedIn
{
    BOOL hasSession = NO;
    
    BOOL registrationCompleted = NO;
    BOOL resetOnLaunch = NO;
    
    [[[userDefaultsMock expect] andReturnValue:OCMOCK_VALUE(registrationCompleted)] boolForKey:kRegistrationCompleted];

    [[userDefaultsMock expect] setBool:NO forKey:kRegistrationCompleted];
    [[[appConfigurationMock expect] andReturnValue:OCMOCK_VALUE(resetOnLaunch)] resetOnLaunch];
    
    [[sessionManagerMock expect] logout];
    [[appReinitializerMock expect] reset];
    [[appConfigurationMock expect] setResetOnLaunch:NO];
    
    [[[sessionManagerMock expect] andReturnValue:OCMOCK_VALUE(hasSession)] hasSession];
    
    id loginVCMock = [OCMockObject mockForClass:[UIViewController class]];
    [[[loginViewControllerMock expect] andReturn:loginVCMock] viewController];
    
    id rootVCMock = [OCMockObject mockForClass:[UIViewController class]];
    [[[windowMock expect] andReturn:rootVCMock] rootViewController];
    
    [[rootVCMock expect] presentModalViewController:loginVCMock animated:NO];
    
    [appDelegate showApplication];
    
    [self verifyMocks];
}

- (void)verifyMocks
{
    [windowMock verify];
    [windowBackgroundColorMock verify];
    [userDefaultsMock verify];
    [tabBarControllerAccessorMock verify];
    [loginViewControllerMock verify];
    [userProfileViewControllerCreatorMock verify];
    [userProfileViewControllerMock verify];
    [authInfoProviderMock verify];
    [sessionManagerMock verify];
    [registrationStepCoordinatorFactoryMock verify];
    [registrationStepCoordinatorMock verify];
    [registrationRepositoryMock verify];
    [crumbServiceFactoryMock verify];
    [crumbServiceMock verify];
    [configurationHandlerMock verify];
    [appConfigurationMock verify];
    [appReinitializerMock verify];
    [uiAlertViewFactoryMock verify];
    [registrationErrorCreatorMock verify];
    [navigationControllerContainerMock verify];
    [errorMock verify];
}

@end
