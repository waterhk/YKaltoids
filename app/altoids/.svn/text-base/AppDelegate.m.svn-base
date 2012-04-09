//
//  AppDelegate.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConfiguration.h"
#import "ConversationComposeViewController.h"
#import "YAAppFactory.h"
#import "YARegistrationInfo.h"
#import "CrumbService.h"
#import "ConfigurationHandler.h"

@interface AppDelegate()
@property (strong, nonatomic) id<AppFactory> appFactory;
@property (strong, nonatomic) id<RegistrationRepository> registrationRepository;
@property (strong, nonatomic) id<RegistrationStepCoordinator> registrationStepCoordinator;
@property (strong, nonatomic) id<CrumbServiceFactory> crumbServiceFactory;
@property (strong, nonatomic) id<UserProfileViewControllerCreator> userProfileViewControllerCreator;
@property (strong, nonatomic) id<UserProfileViewController> userProfileViewController;
@property (strong, nonatomic) id<ConfigurationHandler> configurationHandler;
@property (strong, nonatomic) id<AppConfiguration> appConfiguration;
@property (strong, nonatomic) id<AppReinitializer> appReinitializer;
@property (strong, nonatomic) id<UIAlertViewFactory> alertViewFactory;
@property (strong, nonatomic) id<RegistrationErrorCreator> registrationErrorCreator;
@property (strong, nonatomic) id<ViewControllerContainer> userProfileNavigationControllerContainer;
@property (strong, nonatomic) id<TabBarControllerAccessor> applicationTabBarController;
@property (strong, nonatomic) id<LoginViewController> loginViewController;
@property (strong, nonatomic) id<SessionManager> sessionManager;
@property (assign, nonatomic) id<AuthInfoProvider> authInfoProvider;
@property (strong, nonatomic) NSUserDefaults *userDefaults;

- (void)configureLoggingForAllComponents;

@end

@implementation AppDelegate
@synthesize window = window_;
@synthesize appFactory = appFactory_;
@synthesize applicationTabBarController = applicationTabBarController_;
@synthesize loginViewController = loginViewController_;
@synthesize userProfileViewControllerCreator = userProfileViewControllerCreator_;
@synthesize userProfileViewController = userProfileViewController_;
@synthesize sessionManager = sessionManager_;
@synthesize authInfoProvider = authInfoProvider_;
@synthesize registrationRepository = registrationRepository_;
@synthesize registrationStepCoordinator = registrationStepCoordinator_;
@synthesize crumbServiceFactory = crumbServiceFactory_;
@synthesize configurationHandler = configurationHandler_;
@synthesize appConfiguration = appConfiguration_;
@synthesize appReinitializer = appReinitializer_;
@synthesize alertViewFactory = alertViewFactory_;
@synthesize registrationErrorCreator = registrationErrorCreator_;
@synthesize userProfileNavigationControllerContainer = userProfileNavigationControllerContainer_;
@synthesize userDefaults = userDefaults_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    YALogInfo(@"Application launched with options: %@",launchOptions);
    
    [self configureLoggingForAllComponents];
    
    appFactory_ = [[YAAppFactory alloc] init];
    [appFactory_ injectDependenciesIntoAppDelegate:self];
    
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    [configurationHandler_ registerDefaults];
    
    [self setRootViewController];    //The rootViewController is set here, but the tabs are not presented.

    [self showApplication];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

#pragma mark -
#pragma mark InjectableAppDelegate methods

- (void)injectWithWindow:(UIWindow *)window 
   windowBackgroundColor:(UIColor *)windowBackgroundColor 
            userDefaults:(NSUserDefaults *)userDefaults 
        tabBarController:(id<TabBarControllerAccessor>)theTabBarController
     loginViewController:(id<LoginViewController>)aloginViewController
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
navigationControllerContainer:(id<ViewControllerContainer>)aNavigationControllerContainer
{
    window_ = window;
    [window_ setBackgroundColor:windowBackgroundColor];
    
    userDefaults_ = userDefaults;
    
    sessionManager_ = sessionManager;
    [sessionManager_ setDelegate:self];
    
    applicationTabBarController_ = theTabBarController;    
    loginViewController_ = aloginViewController;
    userProfileViewControllerCreator_ = aUserProfileViewControllerCreator;
    registrationStepCoordinator_ = [aRegistrationStepCoordinatorFactory registrationStepCoordinatorWithDelegate:self];    
    registrationRepository_ = registrationRepository;    
    crumbServiceFactory_ = crumbServiceFactory;
    configurationHandler_ = configurationHandler;
    appConfiguration_ = appConfiguration;
    appReinitializer_ = appReinitializer;
    alertViewFactory_ = theAlertViewFactory;
    registrationErrorCreator_ = aRegistrationErrorCreator;
    userProfileNavigationControllerContainer_ = aNavigationControllerContainer;
    
    authInfoProvider_ = authInfoProvider;
    [authInfoProvider_ updateAuthenticationInfo:[sessionManager_ getAccountInfo]];
}

#pragma mark -
#pragma mark SessionManagerDelegate
- (void)sessionManagerDidSucceed:(id<SessionManager>)aSessionManager
{
    [authInfoProvider_ updateAuthenticationInfo:[aSessionManager getAccountInfo]];
    
    [self retrieveCrumbsForSession];
}

- (void)sessionManagerDidFail:(id<SessionManager>)aSessionManager withError:(NSError*)error
{
    NSString *localizedDescription = [error localizedDescription];
    
    YALogError(@"%@",localizedDescription);
    UIAlertView *alert  = [[self alertViewFactory] createWithTitle:nil message:localizedDescription delegate:nil cancelButtonTitle:kCancelButtonText otherButtonTitles:nil];
    [alert show];
}

#pragma mark -
#pragma mark CrumbServiceDelegate
- (void)crumbService:(id<CrumbService>)crumbService didFailWithError:(NSError *)error
{
    [applicationTabBarController_ presentTabs];
    // We show the tabBar here so that the user will be able to use the app offline (read msgs), but will not be able to send/receive messages, or call any web service.

    NSString *localizedDescription = [error localizedDescription];
    
    YALogError(@"%@",localizedDescription);
    UIAlertView *alert  = [[self alertViewFactory] createWithTitle:nil message:localizedDescription delegate:nil cancelButtonTitle:kCancelButtonText otherButtonTitles:nil];
    [alert show];
}

- (void)crumbService:(id<CrumbService>)crumbService didReceiveCrumb:(NSString *)crumb guid:(NSString *)guid
{
    YALogDebug(@"crumb:%@\nguid:%@",crumb,guid);
    
    [[self authInfoProvider] updateApplicationCrumb:crumb];
    [[self authInfoProvider] updateUserGuid:guid];
    
    BOOL registrationRequired = [registrationRepository_ registrationRequired];

    if (registrationRequired)
    {
        [registrationStepCoordinator_ performRegistrationFromCurrentViewController:loginViewController_];
    }
    else 
    {
        [applicationTabBarController_ presentTabs];
    }
}

- (void)crumbService:(id<CrumbService>)crumbService didReceiveProfileCrumb:(NSString *)crumb
{
    YALogDebug(@"crumb:%@\n",crumb);

    [[self authInfoProvider] updateProfileCrumb:crumb];
}

- (void)crumbService:(id<CrumbService>)crumbService didFailProfileCrumbWithError:(NSError *)error
{
    NSString *localizedDescription = [error localizedDescription];
    
    YALogError(@"%@", localizedDescription);
    UIAlertView *alert  = [[self alertViewFactory] createWithTitle:nil message:localizedDescription delegate:nil cancelButtonTitle:kCancelButtonText otherButtonTitles:nil];
    [alert show];
}

#pragma mark -
#pragma mark RegistrationStepCoordinatorDelegate

- (void)registrationDidCompleteWithPhoneNumber:(NSString *)phoneNumber bindToken:(NSString *)token expirationDate:(NSDate *)expirationDate
{
    YALogDebug(@"phoneNumber:%@\nbindToken:%@\nexpirationDate:%@\n",
               phoneNumber,
               token,
               expirationDate);
    
    YARegistrationInfo *registrationInfo = [[self registrationRepository] createRegistrationInfo];
    [[self registrationRepository] setPhoneNumber:phoneNumber registrationInfo:registrationInfo];
    [[self registrationRepository] setExpirationDate:expirationDate registrationInfo:registrationInfo];
    [[self registrationRepository] setToken:token registrationInfo:registrationInfo];
        
    NSError *error = nil;
    [[self registrationRepository] saveRegistration:registrationInfo error:&error];
    
    if (error)
        YALogError(@"%@",[error localizedDescription]);
        

    UINavigationController *userProfileNavigationController = [[self userProfileNavigationControllerContainer] createContainerForRootViewController:[[self userProfileViewController] viewController]];
    
    [[[self loginViewController] viewController] presentModalViewController:userProfileNavigationController animated:NO];
}

- (void)registrationDidFail
{
    // we need to pass in a NSError into this method
    NSError *error = [[self registrationErrorCreator] errorWithCode:YARegistrationErrorCodeGeneralError];
    UIAlertView *alert  = [[self alertViewFactory] createWithTitle:nil message:[error localizedDescription] delegate:nil cancelButtonTitle:kCancelButtonText otherButtonTitles:nil];
    [alert show];
}

#pragma mark -
#pragma mark UserProfileViewDelegate methods

- (void)userProfileViewController:(id<ViewControllerAccessor>)userProfileViewController dismissUserProfileWithAnimation:(BOOL)animated
{
    [userDefaults_ setBool:YES forKey:kRegistrationCompleted];
    [[NSUserDefaults standardUserDefaults] synchronize];  // We now need to force a save as NSUserDefaults may not save immediately, and this was a bug. 
   
    [[window_ rootViewController] dismissModalViewControllerAnimated:NO];
    [applicationTabBarController_ presentTabs];
}

- (void)configureLoggingForAllComponents
{
    lcl_configure_by_component(lcl_cDefault, lcl_vError);
    
    lcl_configure_by_component(lcl_cConversation, lcl_vError);
    lcl_configure_by_component(lcl_cConversationUI, lcl_vError);
    lcl_configure_by_component(lcl_cConversationUINavigation, lcl_vError);
    lcl_configure_by_component(lcl_cConversationCommand, lcl_vError);
    lcl_configure_by_component(lcl_cConversationRepository, lcl_vInfo);
    
    lcl_configure_by_component(lcl_cMessage, lcl_vError);
    lcl_configure_by_component(lcl_cMessageUI, lcl_vError);
    lcl_configure_by_component(lcl_cMessageCommand, lcl_vError);
    lcl_configure_by_component(lcl_cMessageRepository, lcl_vError);
    
    lcl_configure_by_component(lcl_cParticipant, lcl_vError);
    lcl_configure_by_component(lcl_cParticipantUI, lcl_vError);
    lcl_configure_by_component(lcl_cParticipantCommand, lcl_vTrace);    
    lcl_configure_by_component(lcl_cParticipantRepository, lcl_vError);
    
    lcl_configure_by_component(lcl_cAddress, lcl_vError);
    lcl_configure_by_component(lcl_cAddressRepository, lcl_vError);
    
    lcl_configure_by_component(lcl_cSettings, lcl_vError);
    lcl_configure_by_component(lcl_cProfile, lcl_vError);
    lcl_configure_by_component(lcl_cProfileUI, lcl_vError);
    lcl_configure_by_component(lcl_cProfileCommand, lcl_vError);
    lcl_configure_by_component(lcl_cProfileRepository, lcl_vError);
    
    lcl_configure_by_component(lcl_cContact, lcl_vError);
    lcl_configure_by_component(lcl_cContactUI, lcl_vError);

    lcl_configure_by_component(lcl_cAuthentication, lcl_vError);
    lcl_configure_by_component(lcl_cAuthenticationUI, lcl_vError);
    lcl_configure_by_component(lcl_cAuthenticationCommand, lcl_vError);
    lcl_configure_by_component(lcl_cAuthenticationRepository, lcl_vError);
    
    lcl_configure_by_component(lcl_cRegistration, lcl_vError);
    lcl_configure_by_component(lcl_cRegistrationUI, lcl_vError);
    lcl_configure_by_component(lcl_cRegistrationCommand, lcl_vError);
    lcl_configure_by_component(lcl_cRegistrationRepository, lcl_vInfo);
    lcl_configure_by_component(lcl_cRegistrationStep, lcl_vInfo);
    
    lcl_configure_by_component(lcl_cCommand, lcl_vDebug);
    
    lcl_configure_by_component(lcl_cTransport, lcl_vError);
    lcl_configure_by_component(lcl_cTransportServer, lcl_vInfo);
    lcl_configure_by_component(lcl_cTransportInMemory, lcl_vError);    
    
    lcl_configure_by_component(lcl_cAddressBook, lcl_vError);    
    
    YALogInfo(@"Logging configured for %d components",_lcl_component_t_count); // Using zero-indexed enum value for address book to get last component
    NSString *configureLoggingDebugOutput = @"";
    
    for (int i=_lcl_component_t_first; i<_lcl_component_t_count; i++) {
        configureLoggingDebugOutput = [configureLoggingDebugOutput stringByAppendingFormat:@"%s: %-30s\t%10s: %-15s\n","component",_lcl_component_header[i],"level",_lcl_level_header[_lcl_component_level[i]]];
    }
    
    YALogDebug(@"%@",configureLoggingDebugOutput);
}

- (id<UserProfileViewController>)userProfileViewController
{
    if (!userProfileViewController_) 
    {        
        userProfileViewController_ = [[self userProfileViewControllerCreator] userProfileViewControllerForFTUFlow];
        [userProfileViewController_ setDelegate:self];
    }
    
    return userProfileViewController_;
}

- (void)beginFirstTimeUseFlow
{
    [userDefaults_ setBool:NO forKey:kRegistrationCompleted];
    
    UIViewController *viewController = [loginViewController_ viewController];
    
    [[window_ rootViewController] presentModalViewController:viewController animated:NO];
}

- (void)resetApplicationIfNeeded
{
    BOOL registrationDidComplete = [userDefaults_ boolForKey:kRegistrationCompleted];
    BOOL resetOnLaunch = [appConfiguration_ resetOnLaunch];

    if (resetOnLaunch || !registrationDidComplete) 
    {
        [[self sessionManager] logout];
        [[self appReinitializer] reset];
         userProfileViewController_ = nil;

        [[self appConfiguration] setResetOnLaunch:NO];
    }
}

- (void)updateAuthInfoAndRetrieveCrumbsForSession
{
    [authInfoProvider_ updateAuthenticationInfo:[sessionManager_ getAccountInfo]];
    
    [self retrieveCrumbsForSession];
}

- (void)retrieveCrumbsForSession
{   
    id<CrumbService> crumbService = [[self crumbServiceFactory] createWithDelegate:self];
    YSMAccountInfo *accountInfo = [sessionManager_ getAccountInfo];
    
    [crumbService requestProfileCrumbWithAccountInfo:accountInfo];
    [crumbService requestCrumbWithAccountInfo:accountInfo];
}

- (void)setRootViewController
{
    UITabBarController *tabBarController = [applicationTabBarController_ tabBarController];
    
    [window_ setRootViewController:tabBarController];
    [window_ makeKeyAndVisible];
}

- (void)showApplication
{    
    [self resetApplicationIfNeeded];

    BOOL hasSession = [sessionManager_ hasSession];

    if (hasSession) 
    {
        [self updateAuthInfoAndRetrieveCrumbsForSession];
    }
    else 
    {
        [self beginFirstTimeUseFlow];
    }
}

@end
