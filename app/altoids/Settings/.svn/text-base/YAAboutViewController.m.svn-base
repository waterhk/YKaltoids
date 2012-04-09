//
//  YAAboutViewController.m
//  altoids
//
//  Created by Stephane Karoubi on 3/16/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAAboutViewController.h"

@interface YAAboutViewController ()

@end


@implementation YAAboutViewController
#define kVersionCellIndex 0
#define kLegalCellIndex 1

@synthesize cellTitles = cellTitles_;
@synthesize legalViewController = legalViewController_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:kAboutTitle];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIViewController *)viewController
{
    return self;   
}

#pragma mark Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if([indexPath row] == kVersionCellIndex) {
        UILabel* versionNumber = [[UILabel alloc] initWithFrame:CGRectZero];
        [versionNumber setBackgroundColor:[UIColor clearColor]];

//        altoids-Info.plist has the version
//        <key>CFBundleVersion</key>
//        <string>1.0</string>
        NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        [versionNumber setText:appVersion];
        [versionNumber setTextColor:RGB(128, 128, 128)];
        
//        If omitted, the label won't be visible
        [versionNumber sizeToFit];
        
        [cell setAccessoryView:versionNumber];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
//        Disabling events causes a grey text color, to indicate 'greyed-out' functionality
//        [cell setUserInteractionEnabled:NO];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    [[cell textLabel] setText:[[self cellTitles] objectAtIndex:[indexPath row]]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<ViewControllerAccessor> viewControllerAccessor = nil;
    
    if ([indexPath row] == kLegalCellIndex) 
    {
        viewControllerAccessor = [self legalViewController];
    }
    
//    The [Version] cell is tappable, can't disable it without causing a greyed-out text
    if (viewControllerAccessor) {
        [[self navigationController] pushViewController:[viewControllerAccessor viewController] animated:YES];
    }
}
@end
