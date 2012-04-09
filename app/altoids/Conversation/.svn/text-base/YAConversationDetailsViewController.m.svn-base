//
//  YAConversationDetailsViewController.m
//  altoids
//
//  Created by Jon Herron on 10/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "PersonImageObserver.h"
#import "PersonImageObserverDelegate.h"
#import "YAConversationDetailsViewController.h"
#import "YAParticipant.h"
#import "YAParticipantInfo.h"
#import "ParticipantInfoCreator.h"
#import "YAAddress.h"
#import "YASMSAddressInfo.h"
#import "ParticipantImageLoaderCommandDelegate.h"
#import "ParticipantInfoViewController.h"
#import "ContactRepository.h"
#import "ContactPickerViewController.h"
#import "NavigationBarButtonItemRepository.h"

#define kNumberOfSectionsInConversationDetails 4

#define kParticipantDescriptionSection 0
#define kMuteConversationSection 1
#define kParticipantsSection 2
#define kLeaveConversationSection 3

#define kNumberOfRowsInParticipantDescriptionSection 1
#define kNumberOfRowsInMuteConversationSection 1
#define kNumberOfRowsInLeaveConversationSection 1

@interface YAConversationDetailsViewController () <PersonImageObserverDelegate>

@property (assign, nonatomic) NSUInteger conversationParticipantsCount;
@property (assign, nonatomic) NSUInteger conversationParticipantsWithoutUserCount;
@property (strong, nonatomic) NSArray *conversationParticipants;
@property (strong, nonatomic) NSArray *conversationParticipantsWithoutUser;
@property (strong, nonatomic) YAConversation *conversation;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) id<PersonImageObserver> personImageObserver;

- (void)addObserverForManagedObjectContextDidSave;
- (void)configureParticipantDescriptionCell:(UITableViewCell *)theCell;
- (void)configureMuteConversationCell:(UITableViewCell *)theCell;
- (void)configureParticipantsCell:(UITableViewCell *)theCell atRow:(NSUInteger)theRow;
- (void)configureLeaveConversationCell:(UITableViewCell *)theCell;
- (void)displayParticipantInfoForParticipantAtIndex:(NSUInteger)theParticipantIndex;
- (NSString *)keyForParticipantInfo:(YAParticipantInfo *)theParticipantInfo;
- (void)leaveConversationRowSelected;
- (void)loadConversationParticipants;
- (void)managedObjectContextDidSave:(NSNotification *)theNotification;
- (void)participantSectionRowSelected:(NSUInteger)theRow;
- (void)presentMultiParticipantPicker;
- (void)reloadConversation;
- (void)removeObserverForManagedObjectContextDidSave;
- (void)saveConversation;

@end

@implementation YAConversationDetailsViewController

@synthesize conversationParticipantsCount = conversationParticipantsCount_;
@synthesize conversationParticipantsWithoutUserCount = conversationParticipantsWithoutUserCount_;
@synthesize conversationParticipants = conversationParticipants_;
@synthesize conversationParticipantsWithoutUser = conversationParticipantsWithoutUser_;
@synthesize conversation = conversation_;
@synthesize managedObjectContext = managedObjectContext_;
@synthesize participantDescriptionBuilder = participantDescriptionBuilder_;
@synthesize mutableArrayCreator = mutableArrayCreator_;
@synthesize participantNameFormatter = participantNameFormatter_;
@synthesize participantHandler = participantHandler_;
@synthesize participantInfoViewControllerInstanceFactory = participantInfoViewControllerInstanceFactory_;
@synthesize conversationRepository = conversationRepository_;
@synthesize conversationFetchRequestCreator = conversationFetchRequestCreator_;
@synthesize conversationHandler = conversationHandler_;
@synthesize sortDescriptors = sortDescriptors_;
@synthesize participantRepository = participantRepository_;
@synthesize participantInfoCreator = participantInfoCreator_;
@synthesize imageScaler = imageScaler_;
@synthesize conversationLocator = conversationLocator_;
@synthesize personImageObserver = personImageObserver_;
@synthesize navigationBarButtonItemRepository = navigationBarButtonItemRepository_;
@synthesize muteConversationSwitch = muteConversationSwitch_;
@synthesize contactRepository = contactRepository_;
@synthesize contactPickerViewControllerInstanceFactory = contactPickerViewControllerInstanceFactory_;

#pragma mark -

- (id)initWithNibName:(NSString *)theNibName 
               bundle:(NSBundle *)theBundle 
         conversation:(YAConversation *)theConversation
 managedObjectContext:(NSManagedObjectContext*)theManagedObjectContext
{
    self = [super initWithNibName:theNibName bundle:theBundle];
    [self setConversation:theConversation];
    [self setManagedObjectContext:theManagedObjectContext];

    [self setTitle:kConversationDetailsTitle];

    return self;
}

- (void) dealloc
{
    [contactRepository_ removeSubscriber:self];
    [self removeObserverForManagedObjectContextDidSave];
    [[self personImageObserver] clearDelegate:self];
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
    
    [self reloadConversation];
    [self addObserverForManagedObjectContextDidSave];
    [contactRepository_ addSubscriber:self];
    
    [[self navigationItem] setBackBarButtonItem:[[self navigationBarButtonItemRepository] backButtonItemItemWithTitle:kBackButtonText target:nil action:nil]];
}

- (void)viewDidUnload {
    [self setMuteConversationSwitch:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kNumberOfSectionsInConversationDetails;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowsInSection;
    
    switch (section) 
    {
        case kParticipantDescriptionSection:
            rowsInSection = kNumberOfRowsInParticipantDescriptionSection;
            break;
        case kMuteConversationSection:
            rowsInSection = kNumberOfRowsInMuteConversationSection;
            break;
        case kParticipantsSection:
            rowsInSection = [self conversationParticipantsWithoutUserCount] + 1; // + 1 for Add Participant...
            break;
        case kLeaveConversationSection:
            rowsInSection = kNumberOfRowsInLeaveConversationSection;
            break;
        default:
            rowsInSection = 0;
            break;
    }
    
    return rowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSString *cellIdentifier = @"Cell";
    
    if (section == kLeaveConversationSection) 
    {
        cellIdentifier = @"LeaveConversationCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:14]];
    
    switch (section) 
    {
        case kParticipantDescriptionSection:
            [self configureParticipantDescriptionCell:cell];
            break;
        case kMuteConversationSection:
            [self configureMuteConversationCell:cell];
            break;
        case kParticipantsSection:
            [self configureParticipantsCell:cell atRow:[indexPath row]];
            break;
        case kLeaveConversationSection:
            [self configureLeaveConversationCell:cell];
            break;
        default:
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == kMuteConversationSection) 
    {
        return kConversationDetailsMuteConversationSectionFooterText;
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == kParticipantsSection) 
    {
        return kConversationDetailsParticipantsSectionHeaderText;
    }
    
    return nil;
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    
    if (section == kParticipantDescriptionSection || section == kMuteConversationSection) 
    {
        return nil;
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch ([indexPath section]) 
    {
        case kParticipantsSection:
            [self participantSectionRowSelected:[indexPath row]];
            break;
        case kLeaveConversationSection:
            [self leaveConversationRowSelected];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark ViewControllerAccessor methods

- (UIViewController *)viewController
{
    return self;
}

#pragma mark -
#pragma mark PersonImageObserverDelegate methods

- (void)didChangeImageForParticipants:(NSSet *)participants {
    YAParticipant *participant = [participants anyObject];
    
    [[[self tableView] visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [[self tableView] indexPathForCell:obj];
        /* update only in participants section*/
        if ([indexPath section] != kParticipantsSection)
            return ;
        
        /* ignore the row that is used to add participants */
        if ([indexPath row] == [self conversationParticipantsWithoutUserCount])
            return;
        
        YAParticipant *currentParticipant = [[self conversationParticipantsWithoutUser] objectAtIndex:[indexPath row]];
        if ([[[self participantHandler] photoURLForParticipant:participant] isEqualToString:[[self participantHandler] photoURLForParticipant:currentParticipant]]) {
            UIImage *participantImage = [[self participantRepository] imageForParticipant:participant];
            
            if (participantImage) {
                [[obj imageView] setImage:participantImage];
                [obj setNeedsLayout];
            }
            
            /* done, only one entry per participant in this view */
            *stop = YES;
        }
    }];
}
// Public methods
#pragma mark -
#pragma mark Public methods

- (void)setPersonImageObserverCreator:(id<PersonImageObserverCreator>)personImageObserverCreator
{
    [self setPersonImageObserver:[personImageObserverCreator createWithDelegate:self managedObjectContext:[self managedObjectContext]]];
}

- (IBAction)muteConversationSwitchValueChanged:(id)sender 
{
    [[self conversationHandler] setIsMuted:[muteConversationSwitch_ isOn] forConversation:[self conversation]];
    
    [self saveConversation];
}

#pragma mark -
#pragma mark Private methods

- (void)addObserverForManagedObjectContextDidSave
{
    [[self managedObjectContext] setStalenessInterval:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(managedObjectContextDidSave:) 
                                                 name:NSManagedObjectContextDidSaveNotification 
                                               object:nil];
}

- (void)configureParticipantDescriptionCell:(UITableViewCell *)theCell
{
    CGSize participantDescriptionConstrainedSize;
    NSString *participantsDescription;
    UIFont *textLabelFont;
    
    participantDescriptionConstrainedSize = [theCell frame].size;
    textLabelFont = [[theCell textLabel] font];
     
    participantsDescription = [[self participantDescriptionBuilder] descriptionForParticipants:[self conversationParticipants] sizeWithFont:textLabelFont constraintedToSize:participantDescriptionConstrainedSize];
    
    [[theCell textLabel] setText:participantsDescription];
    
    [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)configureMuteConversationCell:(UITableViewCell *)theCell
{
    [muteConversationSwitch_ setOn:[[self conversationHandler] conversationIsMuted:[self conversation]]];
    
    [[theCell textLabel] setText:kConversationDetailsMuteConversationText];
    
    [theCell setAccessoryView:muteConversationSwitch_];
    
    [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)configureParticipantsCell:(UITableViewCell *)theCell atRow:(NSUInteger)theRow
{
    [theCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if (theRow == [self conversationParticipantsWithoutUserCount]) 
    {
        [[theCell imageView] setImage:nil];
        [[theCell textLabel] setText:kConversationDetailsAddParticipantText];
        
        return;
    }
    
    YAParticipant *participant = [[self conversationParticipantsWithoutUser] objectAtIndex:theRow];
    NSString *participantName = [[self participantNameFormatter] formatDisplayNameForParticipant:participant];
    
    [[theCell textLabel] setText:participantName];
    
    UIImage *participantImage = [[self participantRepository] imageForParticipant:participant];
    
    if (participantImage) {
        [[theCell imageView] setImage:participantImage];
    } else {
        [[theCell imageView] setImage:[UIImage imageNamed:kIconDefaultParticipantImage]];
        
        if (![[self tableView] isDragging] && ![[self tableView] isDecelerating])
            [[self participantRepository] retrieveImageForParticipant:participant];
    }
}

- (void)configureLeaveConversationCell:(UITableViewCell *)theCell
{
    [[theCell textLabel] setText:kConversationDetailsLeaveConversationText];
    [[theCell textLabel] setTextAlignment:UITextAlignmentCenter];
    [[theCell textLabel] setTextColor:[UIColor whiteColor]];
    
    [theCell setBackgroundColor:RGB(160, 30, 30)];
}

- (void)displayParticipantInfoForParticipantAtIndex:(NSUInteger)theParticipantIndex
{
    id<ViewControllerAccessor> participantInfoViewControllerAccessor;
    YAParticipant *participant;
    
    participant = [[self conversationParticipantsWithoutUser] objectAtIndex:theParticipantIndex];
    
    if (!participant) 
    {        
        return;
    }
    
    participantInfoViewControllerAccessor = [[self participantInfoViewControllerInstanceFactory] createParticipantInfoViewControllerWithParticipant:participant managedObjectContext:[participant managedObjectContext]];
    
    [[self navigationController] pushViewController:[participantInfoViewControllerAccessor viewController] animated:YES];
}

- (NSString *)keyForParticipantInfo:(YAParticipantInfo *)theParticipantInfo
{
    NSString *firstName = [theParticipantInfo firstName];
    NSString *lastName = [theParticipantInfo lastName];
    NSString *phoneNumber = [[theParticipantInfo addressInfo] handle];
    
    return [NSString stringWithFormat:@"%@&%@&%@", firstName, lastName, phoneNumber];
}

- (void)leaveConversationRowSelected
{
    return;
}

- (void)loadConversationParticipants
{
    NSArray *conversationParticipants;
    NSMutableArray *participants;
    NSMutableArray *participantsWithoutUser;
    NSUInteger particpantsCount;
    
    conversationParticipants = [[[self conversation] participants] allObjects];
    conversationParticipants = [conversationParticipants sortedArrayUsingDescriptors:[self sortDescriptors]];
    
    particpantsCount = [conversationParticipants count];
    
    participants = [[self mutableArrayCreator] mutableArrayWithCapacity:particpantsCount];
    participantsWithoutUser = [[self mutableArrayCreator] mutableArrayWithCapacity:particpantsCount];
    
    [conversationParticipants enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        YAParticipant *participant = obj;
        BOOL participantIsUser = [[self participantHandler] participantIsUser:participant];
        
        [participants addObject:participant];
        
        if (!participantIsUser) 
        {
            [participantsWithoutUser addObject:participant];
        }
    }];
    
    [self setConversationParticipants:participants];
    [self setConversationParticipantsCount:particpantsCount];
    
    [self setConversationParticipantsWithoutUser:participantsWithoutUser];
    [self setConversationParticipantsWithoutUserCount:[participantsWithoutUser count]];
}

- (void)managedObjectContextDidSave:(NSNotification *)theNotification
{
    if (![NSThread isMainThread]) 
    {
        [self performSelectorOnMainThread:@selector(managedObjectContextDidSave:) withObject:theNotification waitUntilDone:NO];
        return;
    }
    
    [[self managedObjectContext] mergeChangesFromContextDidSaveNotification:theNotification];
    
    [self reloadConversation];
    [[self tableView] reloadData];
}

- (void)participantSectionRowSelected:(NSUInteger)theRow
{
    if (theRow == [self conversationParticipantsWithoutUserCount]) 
    {
        [self presentMultiParticipantPicker];
    }
    else
    {
        [self displayParticipantInfoForParticipantAtIndex:theRow];
    }
}

- (void)presentMultiParticipantPicker
{
    NSMutableSet* participantInfos = [NSMutableSet setWithCapacity:[conversationParticipantsWithoutUser_ count]];
    for(YAParticipant* participant in conversationParticipantsWithoutUser_)
    {
        [participantInfos addObject:[participantInfoCreator_ participantInfoWithParticipant:participant]];
    }

    id<ContactPickerViewController> contactPickerViewController = [contactPickerViewControllerInstanceFactory_ createContactPickerViewControllerWithDelegate:self participantInfos:participantInfos modal:NO];
    [[self navigationController] pushViewController:[contactPickerViewController viewController] animated:YES];
}

- (void)reloadConversation
{
    [self loadConversationParticipants];
}

- (void)removeObserverForManagedObjectContextDidSave
{
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:NSManagedObjectContextDidSaveNotification 
                                                  object:nil];
}

- (void)saveConversation
{
    NSError *error;
    
    [[self conversationHandler] save:[self conversation] inManagedObjectContext:[self managedObjectContext] error:&error];
    
    if (error) 
    {
        YALogError(@"Failed to save conversation");
    }
}

- (void)contactRepositoryDidLoadContacts:(id<ContactRepository>)contactRepository
{
    [[self tableView] reloadData];
}

#pragma mark -
#pragma mark ContactPickerViewControllerDelegate methods

- (void) contactPicker:(id<ContactPickerViewController>)contactPicker didPickContactEndpoints:(NSSet*)contactEndpoints
{
    [[self navigationController] popToViewController:self animated:YES];

    // TODO support multiple selections from Contact Picker (current migration effort is replacing code that only added the first selection of the legacy MultiParticipantPicker)
    YAContactEndpoint* contactEndpoint = [contactEndpoints anyObject];
    if(!contactEndpoint)
    {
        return;
    }

    YAParticipantInfo* participantInfo = [participantInfoCreator_ participantInfoWithContactEndpoint:contactEndpoint];

    NSError *error;
    [[self conversationRepository] addParticipant:participantInfo toConversation:[self conversation] withViewForOverlay:[self view] error:&error];
}

- (void) contactPickerDidCancel:(id<ContactPickerViewController>)contactPicker
{
    [[self navigationController] popToViewController:self animated:YES];
}


@end
