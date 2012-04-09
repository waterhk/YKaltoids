//
//  YAParticipantInfoViewController.m
//  altoids
//
//  Created by Jon Herron on 10/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantInfoViewController.h"
#import "AppFactory.h"
#import "PersonImageObserverDelegate.h"
#import "YAAddressInfo.h"
#import "ConversationComposeViewController.h"
#import "NavigationBarButtonItemRepository.h"
#import "ConversationMessageListViewControllerCreator.h"
#import "ContactRepository.h"
#import "ParticipantInfoCreator.h"
#import "YAContactEndpoint.h"

#define kNumberOfSectionsInParticipantInfo 3
#define kNumberOfSectionsInParticipantInfoIfParticipantIsNotAContact 4

#define kParticipantNameSection 0
#define kParticipantIsNotAContactSection 1
#define kParticipantAddressesSection 1
#define kParticipantAddressesSectionIfParticipantIsNotAContact 2
#define kRemoveFromConversationSection 2
#define kRemoveFromConversationSectionIfParticipantIsNotAContact 3

#define kNumberOfRowsInParticipantNameSection 1
#define kNumberOfRowsInParticipantIsNotAContactSection 1
#define kNumberOfRowsInRemoveFromConversationSection 1

#define kParticipantImageHeight 64
#define kParticipantImageWidth 64

// Private class extension
@interface YAParticipantInfoViewController () <UIAlertViewDelegate, PersonImageObserverDelegate>

// @property definitions
@property (strong, nonatomic) YAParticipant *participant;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) id<PersonImageObserver> personImageObserver;
@property (strong, nonatomic) NSArray *participantAddresses;
@property (assign, nonatomic) NSUInteger participantAddressCount;
@property (assign, nonatomic) BOOL participantIsAContact;

// methods
- (void)configureAddParticipantAsContactCell:(UITableViewCell *)theCell;
- (void)configureParticipantAddressCell:(UITableViewCell *)theCell atRow:(NSUInteger)theRow;
- (void)configureParticipantNameCell:(UITableViewCell *)theCell;
- (void)configureRemoveFromConversationCell:(UITableViewCell *)theCell;
- (void)detectIfParticipantIsAContact;
- (void)editParticipant:(id)sender;
- (BOOL)isParticipantNameSection:(NSInteger)theSection;
- (BOOL)isParticipantIsNotAContactSection:(NSInteger)theSection;
- (BOOL)isParticipantAddressesSection:(NSInteger)theSection;
- (BOOL)isRemoveFromConversationSection:(NSInteger)theSection;
- (void)loadParticipantAddressesArray;
- (void)removeParticipantFromConversation;
- (void)createConversationFromParticipant;
- (void)loadTable;
@end

@implementation YAParticipantInfoViewController
@synthesize addParticipantAsContactButton;

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize participantNameFormatter = participantNameFormatter_;
@synthesize mutableArrayCreator = mutableArrayCreator_;
@synthesize addressHandleFormatter = addressHandleFormatter_;
@synthesize uiAlertViewDismisser = uiAlertViewDismisser_;
@synthesize uiAlertViewFactory = uiAlertViewFactory_;
@synthesize uiAlertViewSelectionDetector = uiAlertViewSelectionDetector_;
@synthesize conversationRepository = conversationRepository_;
@synthesize contactLocator = contactLocator_;
@synthesize participantRepository = participantRepository_;
@synthesize imageScaler = imageScaler_;
@synthesize participant = participant_;
@synthesize participantAddresses = participantAddresses_;
@synthesize participantAddressCount = participantAddressCount_;
@synthesize participantIsAContact = participantIsAContact_;
@synthesize participantHandler = participantHandler_;
@synthesize personImageObserver = personImageObserver_;
@synthesize conversationComposeViewControllerInstanceFactory = conversationComposeViewControllerInstanceFactory_;
@synthesize managedObjectContext = managedObjectContext_;
@synthesize navigationBarButtonItemRepository = navigationBarButtonItemRepository_;
@synthesize conversationMessageListViewControllerCreator = conversationMessageListViewControllerCreator_;
@synthesize contactRepository = contactRepository_;
@synthesize participantInfoCreator = participantInfoCreator_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithNibName:(NSString*)theNibName bundle:(NSBundle*)theBundle participant:(YAParticipant *)participant managedObjectContext:(NSManagedObjectContext*)managedObjectContext
{
    self = [super initWithNibName:theNibName bundle:theBundle];
    
    if (self) 
    {
        [self setParticipant:participant];
        [self setManagedObjectContext:managedObjectContext];

        [self setTitle:kParticipantInfoTitle];
    }
    
    return self;
}

// Dealloc
#pragma mark -
#pragma mark dealloc

- (void) dealloc
{
    [[self personImageObserver] clearDelegate:self];
    [contactRepository_ removeSubscriber:self];
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

#pragma mark -
#pragma mark Memory warning

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

    [self loadTable];

    [contactRepository_ addSubscriber:self];

    [[self navigationItem] setRightBarButtonItem:[[self navigationBarButtonItemRepository] editButtonItemWithTarget:self action:@selector(editParticipant:)]];
    [[[self navigationController] navigationBar] setTintColor:kNavigationBarTintColor];
}

- (void)viewDidUnload 
{
    [contactRepository_ removeSubscriber:self];
    [self setAddParticipantAsContactButton:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self participantIsAContact]) 
    {
        return kNumberOfSectionsInParticipantInfo;
    }
    
    return kNumberOfSectionsInParticipantInfoIfParticipantIsNotAContact;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self isParticipantNameSection:section]) 
    {
        return kNumberOfRowsInParticipantNameSection;
    }
    
    if ([self isParticipantIsNotAContactSection:section]) 
    {
        return kNumberOfRowsInParticipantIsNotAContactSection;
    }
    
    if ([self isParticipantAddressesSection:section]) 
    {
        return [self participantAddressCount];
    }
    
    if ([self isRemoveFromConversationSection:section]) 
    {
        return kNumberOfRowsInRemoveFromConversationSection;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:14]];
    
    NSInteger section = [indexPath section];
    
    if ([self isParticipantNameSection:section]) 
    {
        [self configureParticipantNameCell:cell];
    }
    else if([self isParticipantIsNotAContactSection:section])
    {
        [self configureAddParticipantAsContactCell:cell];
    }
    else if([self isParticipantAddressesSection:section])
    {
        [self configureParticipantAddressCell:cell atRow:[indexPath row]];
    }
    else if([self isRemoveFromConversationSection:section])
    {
        [self configureRemoveFromConversationCell:cell];
    }
    
    return cell;
}

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark Delegate methods

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isRemoveFromConversationSection:[indexPath section]]) 
    {
        return indexPath;
    }
    else if ([self isParticipantAddressesSection:[indexPath section]]) 
    {
        return indexPath;
    }
        
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self isRemoveFromConversationSection:[indexPath section]])                            
    {
        [self removeParticipantFromConversation];
    }
    else if ([self isParticipantAddressesSection:[indexPath section]])                            
    {
        [self createConversationFromParticipant];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self isParticipantNameSection:[indexPath section]]) 
    {
        return kDefaultTableViewCellHeight;
    }
    
    return kParticipantOrUserNameAndImageTableViewCellHeight;
}

#pragma mark -
#pragma mark ViewControllerAccessor methods

- (UIViewController *)viewController
{
    return self;
}

#pragma mark -
#pragma mark UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[self uiAlertViewSelectionDetector] clickedButtonIndex:buttonIndex isCancelButtonIndexForUIAlertView:alertView])
    {
        return;
    }
    
    [[self conversationRepository] removeParticipant:[self participant] fromConversation:[[self participant] conversation] withViewForOverlay:[[self parentViewController] view]];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark PersonImageObserverDelegate methods

- (void)didChangeImageForParticipants:(NSSet *)participants
{
    if (![[[self participantHandler] photoURLForParticipant:[self participant]] isEqualToString:[[self participantHandler] photoURLForParticipant:[participants anyObject]]])
        return;
    
    [[[self tableView] visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [[self tableView] indexPathForCell:obj];
        if ([indexPath section] == kParticipantNameSection) {
            UIImage *image = [[self participantRepository] imageForParticipant:[self participant]];
            if (image)
                [[obj imageView] setImage:image];
            
            /* only one cell has participant info, so stop */
            *stop = YES;
        }
    }];
}

// Public methods
#pragma mark -
#pragma mark Public methods

- (IBAction)addParticipantAsContact:(id)sender 
{
    if ([self participantIsAContact]) 
    {
        return;
    }
}

- (void)setPersonImageObserverCreator:(id<PersonImageObserverCreator>)personImageObserverCreator
{
    [self setPersonImageObserver:[personImageObserverCreator createWithDelegate:self managedObjectContext:[self managedObjectContext]]];
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods

#pragma mark -
#pragma mark YAParticipantInfoViewController ()

- (void)loadTable
{
    [self loadParticipantAddressesArray];
    [self detectIfParticipantIsAContact];
    [[self tableView] reloadData];
}

- (void)configureAddParticipantAsContactCell:(UITableViewCell *)theCell
{
    [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [[theCell textLabel] setText:kParticipantInfoParticipantIsNotAContact];    
    [theCell setAccessoryView:[self addParticipantAsContactButton]];
}

- (void)configureParticipantAddressCell:(UITableViewCell *)theCell atRow:(NSUInteger)theRow
{    
    if (theRow >= [[self participantAddresses] count]) 
    {
        return;
    }
    
    NSString *formattedHandle;
    YAAddress *addressForRow;
    
    addressForRow = [[self participantAddresses] objectAtIndex:theRow];
    
    if (!addressForRow) 
    {
        return;
    }
    
    formattedHandle = [addressHandleFormatter_ formatAddressHandleForDisplay:addressForRow];
    
    //todo: address type to the left of handle
    [[theCell textLabel] setText:formattedHandle];
}

- (void)configureParticipantNameCell:(UITableViewCell *)theCell
{
    NSString *participantName;
    
    participantName = [[self participantNameFormatter] formatDisplayNameForParticipant:[self participant]];
    
    [[theCell textLabel] setText:participantName];
    
    [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UIImage *image = [[self participantRepository] imageForParticipant:[self participant]];
    
    if (image) {
        [[theCell imageView] setImage:image];
    } else {
        [[theCell imageView] setImage:[UIImage imageNamed:kIconDefaultParticipantImage]];
        if (![[self tableView] isDecelerating] && ![[self tableView] isDragging])
            [[self participantRepository] retrieveImageForParticipant:[self participant]];
    }
}

- (void)configureRemoveFromConversationCell:(UITableViewCell *)theCell
{
    [[theCell textLabel] setText:KParticipantInfoRemoveFromConversation];
    [[theCell textLabel] setTextAlignment:UITextAlignmentCenter];
    [[theCell textLabel] setTextColor:[UIColor whiteColor]];
    
    [theCell setBackgroundColor:RGB(160, 30, 30)];
}

- (void)detectIfParticipantIsAContact
{
    YAContact* contact = [[contactLocator_ contactEndpointMatchingParticipant:[self participant]] contact];
    BOOL participantIsAContact = contact != nil;
    
    [self setParticipantIsAContact:participantIsAContact];
}

- (void)editParticipant:(id)sender
{
    //todo: edit participant
}

- (BOOL)isParticipantNameSection:(NSInteger)theSection
{
    return theSection == kParticipantNameSection;
}

- (BOOL)isParticipantIsNotAContactSection:(NSInteger)theSection
{
    if ([self participantIsAContact]) 
    {
        return NO;
    }
    
    return theSection == kParticipantIsNotAContactSection;
}

- (BOOL)isParticipantAddressesSection:(NSInteger)theSection
{
    if ([self participantIsAContact]) 
    {
        return theSection == kParticipantAddressesSection;
    }
    
    return theSection == kParticipantAddressesSectionIfParticipantIsNotAContact;
}

- (BOOL)isRemoveFromConversationSection:(NSInteger)theSection
{
    if ([self participantIsAContact]) 
    {
        return theSection == kRemoveFromConversationSection;
    }
    
    return theSection == kRemoveFromConversationSectionIfParticipantIsNotAContact;
}

//todo: multiple addresses for participant
- (void)loadParticipantAddressesArray
{
    NSMutableArray *participantAddressesArray;
    NSUInteger participantAddressCount = 1;
    YAAddress *address;
    
    participantAddressesArray = [[self mutableArrayCreator] mutableArrayWithCapacity:participantAddressCount];
    address = [[self participant] address];
    
    if (address) 
    {
        [participantAddressesArray addObject:[[self participant] address]];
    }
    
    [self setParticipantAddressCount:participantAddressCount];
    [self setParticipantAddresses:participantAddressesArray];
}

- (void)removeParticipantFromConversation
{
    UIAlertView *removeFromConversationConfirmation;
    
    removeFromConversationConfirmation = [[self uiAlertViewFactory] createWithTitle:kRemoveFromConversationConfirmationDialogTitle 
                                                                            message:kRemoveFromConverastionConfirmationDialogSingleParticipantText 
                                                                           delegate:self 
                                                                  cancelButtonTitle:kCancelButtonText 
                                                                  otherButtonTitles:[NSArray arrayWithObject:kContinueButtonText]];
    
    [removeFromConversationConfirmation show];
}

-(void)createConversationFromParticipant
{
    YAContactEndpoint *contactEndpoint = [contactLocator_ contactEndpointMatchingParticipant:[self participant]];
    BOOL isParticipantAContact = contactEndpoint != nil;

    YAParticipantInfo* participantInfo = isParticipantAContact ?
        [participantInfoCreator_ participantInfoWithContactEndpoint:contactEndpoint] :
        [participantInfoCreator_ participantInfoWithParticipant:[self participant]];
    
    id<ConversationComposeViewController> conversationComposeViewController = [[self conversationComposeViewControllerInstanceFactory] createConversationComposeViewControllerWithDelegate:self];
    [conversationComposeViewController setParticipants:[NSArray arrayWithObject:participantInfo]];    
    [self presentModalViewController:[conversationComposeViewController viewController] animated:YES];
}

#pragma mark -
#pragma mark ConversationComposeDelegate methods

- (void)conversationComposeViewController:(id<ViewControllerAccessor>)conversationComposeViewController didFinishWithResult:(YAComposeResult)result conversation:(YAConversation *)conversation
{
    [[conversationComposeViewController viewController] dismissModalViewControllerAnimated:YES];    

    if(result != YAComposeResultCancelled && conversation)
    {
        id<ViewControllerAccessor>  conversationMessageListViewControllerAccessor = [[self conversationMessageListViewControllerCreator] createWithConversation:conversation];
        [[self navigationController] pushViewController:[conversationMessageListViewControllerAccessor viewController] animated:YES];
    }
}

#pragma mark ContactRepositorySubscriber methods

- (void) contactRepositoryDidLoadContacts:(id<ContactRepository>)contactRepository
{
    [self loadTable];       // cause the table to redraw, because we may now better understand whether the participant is a contact
}

@end
