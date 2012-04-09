//
//  YASettingsListViewController.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "YASettingsListViewController.h"
#import "UserProfileRepository.h"
#import "YAPersonImage.h"
#import "NavigationBarButtonItemRepository.h"

#define kProfileSectionIndex 0
#define kProfileCellIndex 0

#define kOptionsSectionIndex 1
#define kNotificationSoundsCellIndex 0
#define kReportProblemCellIndex 1
#define kAboutCellIndex 2
#define kDeactivateCellIndex 3

#undef kYALogComponent
#define kYALogComponent lcl_cSettings

@interface YASettingsListViewController ()

- (BOOL)isProfileTableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NSString *const kSettingsListTabBarImage = @"icn-tabbar-settings.png";

@implementation YASettingsListViewController

@synthesize userProfileViewControllerCreator = userProfileViewControllerCreator_;
@synthesize aboutViewController = aboutViewController_;
@synthesize userProfileRepository = userProfileRepository_;
@synthesize cellOptionsHeaderTitles = cellOptionsHeaderTitles_;
@synthesize switchNotificationSoundState = switchNotificationSoundState_;
@synthesize notificationSoundsViewController = notificationSoundsViewController_;
@synthesize deactivateViewController = deactivateViewController_;
@synthesize textFormatter = textFormatter_;
@synthesize reportProblemViewController = reportProblemViewController_;
@synthesize imageScaler = imageScaler_;
@synthesize navigationBarButtonItemRepository = navigationBarButtonItemRepository_;

#pragma mark -

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setTitle:kSettingsListTitle];
        [[self tabBarItem] setImage:[UIImage imageNamed:kSettingsListTabBarImage]];
        
        [self setSwitchNotificationSoundState:NO];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[[self navigationController] navigationBar] setTintColor:kNavigationBarTintColor];
    
    [[self navigationItem] setBackBarButtonItem: [[self navigationBarButtonItemRepository] backButtonItemItemWithTitle:kBackButtonText target:nil action:nil]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    YALogTrace(@"In %@", [self title]);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    YALogTrace(@"Left %@", [self title]);
}

#pragma mark -
#pragma mark Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == kOptionsSectionIndex) 
    {
        return kSettingsOptionsHeaderTitle;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberRows = 1;

    if(section == kProfileSectionIndex)
        numberRows = 1;
    else if (section == kOptionsSectionIndex)
        numberRows = 4;
    
    return numberRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    // Configure the cell...
    if([self isProfileTableViewCellForRowAtIndexPath:indexPath])
    {        
        YAUser* currentUser = [self currentUser];
        [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@", 
                                   [textFormatter_ formatTextForDisplay:[currentUser firstName]], 
                                   [textFormatter_ formatTextForDisplay:[currentUser lastName]]]];
        
        UIImage* profileImage = [self profileImageForUser];
        if(profileImage)
        {
            UIImage* profileImageScaled = [[self imageScaler] scaleImage:profileImage toSize:CGSizeMake(kSettingsProfileImageWidth, kSettingsProfileImageHeight)];
            [[[cell imageView] layer] setMasksToBounds:YES];
            [[cell imageView] setImage:profileImageScaled];
        }
    }
    else if ([indexPath section] == kOptionsSectionIndex)
    {
        if([indexPath row] == kNotificationSoundsCellIndex)
        {
            UISwitch *soundSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
            [soundSwitch setOn:[self switchNotificationSoundState]]; 
            [soundSwitch addTarget:self action:@selector(notificationSoundSelector:) forControlEvents:UIControlEventValueChanged];
            
            [cell setAccessoryView:soundSwitch];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [[cell textLabel] setText:[[self cellOptionsHeaderTitles] objectAtIndex:[indexPath row]]];
    }
    else 
    {
        [[cell textLabel] setText:kSettingsAccountHeaderCellOneTitle];
    }
    
    return cell;
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
    NSError *userProfileError = nil;
    YAUser *currentUser = [[self userProfileRepository] fetchCurrentUserProfileWithError:&userProfileError];
    NSAssert(currentUser != nil, @"current user not found");
        
    return currentUser;
}

#pragma mark -
#pragma mark Delegate methods

- (UIViewController*)viewController
{
    return self;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<ViewControllerAccessor> viewControllerAccessor;
    
    if([self isProfileTableViewCellForRowAtIndexPath:indexPath])
    {
        viewControllerAccessor = [[self userProfileViewControllerCreator] userProfileViewControllerForProfileEdit];
    }
    else if([indexPath section] == kOptionsSectionIndex)
    {
        if ([indexPath row] == kAboutCellIndex) 
        {
            viewControllerAccessor = [self aboutViewController];
        } 
        else if ([indexPath row] == kReportProblemCellIndex) 
        {
            viewControllerAccessor = [self reportProblemViewController];
        }  
        else if ([indexPath row] == kDeactivateCellIndex)
        {
            viewControllerAccessor = [self deactivateViewController];    
        }        
    }
    else 
    {
        viewControllerAccessor = nil; // UpgradeViewController
    }
    
    if (viewControllerAccessor) {
        [[self navigationController] pushViewController:[viewControllerAccessor viewController] animated:YES];
    }
}

#pragma mark -
#pragma mark Private methods

- (BOOL)isProfileTableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([indexPath section] == kProfileSectionIndex && [indexPath row] == kProfileCellIndex);
}

- (IBAction)notificationSoundSelector:(id)sender
{
    UISwitch* soundSwitch = (UISwitch*)sender;
    [self setSwitchNotificationSoundState:[soundSwitch isOn]];
}

@end
