//
//  YAParticipantPickerViewController.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantPickerViewController.h"
#import "AppFactory.h"
#import "YAParticipantInfo.h"
#import "YAAddressInfo.h"
#import "ContactRepository.h"
#import "YAContact.h"
#import "YAContactEndpoint.h"
#import "YAContactPhoneNumberAddress.h"
#import "ContactLocator.h"
#import "ParticipantInfoCreator.h"
#import "TableViewCellCreator.h"
#import "ContactAddressFormatter.h"

@interface YAParticipantPickerViewController ()

@property (strong, nonatomic, readwrite) NSArray *queryResults;         // [YAContactEndpoint*]
@property (strong, nonatomic, readwrite) NSString *currentQueryString;

- (void)findParticipantsForCurrentQueryString;

@end

@implementation YAParticipantPickerViewController

@synthesize queryResults = queryResults_;
@synthesize currentQueryString = currentQueryString_;

@synthesize contactRepository = contactRepository_,
            tableViewCellCreator = tableViewCellCreator_,
            contactAddressFormatter = contactAddressFormatter_,
            contactLocator = contactLocator_,
            participantInfoCreator = participantInfoCreator_;
@synthesize pickerDelegate;

- (id)initWithDelegate:(id<ParticipantPickerDelegate>)delegate
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        [self setPickerDelegate:delegate];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[[self navigationController] navigationBar] setTintColor:kNavigationBarTintColor];
    
    [[self contactRepository] addSubscriber:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [[self contactRepository] removeSubscriber:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self queryResults] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableViewCellCreator_ createForTableView:tableView withStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];

    // Configure the cell...
    YAContactEndpoint* contactEndpoint = [queryResults_ objectAtIndex:[indexPath row]];

    [[cell textLabel] setText:[[contactEndpoint contact] compositeName]];
    [[cell detailTextLabel] setText:[contactAddressFormatter_ formattedAddressAndLabel:[contactEndpoint address]]];

    return cell;
}

#pragma mark -
#pragma mark Delegate methods

#pragma mark - ViewControllerAccessor delegate method

- (UIViewController*)viewController
{
    return self;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self pickerDelegate] && [[self pickerDelegate] respondsToSelector:@selector(participantPicker:didPickParticipantWithInfo:)])
    {
        YAContactEndpoint* contactEndpoint = [queryResults_ objectAtIndex:[indexPath row]];
        YAParticipantInfo* participantInfo = [participantInfoCreator_ participantInfoWithContactEndpoint:contactEndpoint];

        [[self pickerDelegate] participantPicker:self didPickParticipantWithInfo:participantInfo];
    }
}

#pragma mark -

- (void)findParticipantsForQueryString:(NSString*)queryString
{
    [self setCurrentQueryString:queryString];
    [self findParticipantsForCurrentQueryString];
}

- (void)findParticipantsForCurrentQueryString
{
    [self setQueryResults:[contactLocator_ contactEndpointsBeginningWithString:[self currentQueryString]]];
    [[self tableView] reloadData];
}

#pragma mark -
#pragma mark ContactRepositorySubscriber protocol methods

- (void)contactRepositoryDidLoadContacts:(id<ContactRepository>)contactRepository {
    [self findParticipantsForCurrentQueryString];
}

@end
