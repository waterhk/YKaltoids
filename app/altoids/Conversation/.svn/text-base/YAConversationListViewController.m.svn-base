//
//  YAConversationListViewController.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationListViewController.h"
#import "AppFactory.h"
#import "ConversationComposeViewController.h"
#import "YAManagedObjectContextFactory.h"
#import "YAParticipant.h"
#import "YAMessage.h"
#import "ConversationStatus.h"
#import "NavigationBarButtonItemRepository.h"
#import "ConversationListCell.h"
#import "ConversationListCellFactory.h"
#import "ContactRepository.h"
#import "PullToRefreshView.h"
#import "Threader.h"
#import "CommandTransaction.h"

#undef kYALogComponent
#define kYALogComponent lcl_cConversationUI

@interface YAConversationListViewController ()

@property (nonatomic, strong) id<ViewControllerAccessor> conversationComposeViewController;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSTimer *refreshConversationTimer;
@property (nonatomic, strong) id<CommandTransaction> pullToRefreshCommandTransaction;

- (void)compose:(id)sender;
- (void)refresh:(id)sender;
- (void)navigateToConversation:(YAConversation*)conversation;
- (id<CommandTransaction>)updateConversations;
- (void)refreshMostRecentConversations:(NSTimer *)aTimer;
- (void)managedObjectContextDidSave:(NSNotification *)notification;
- (void)rebindVisibleCellsWithConversations;

@end

NSString *const kConversationsListTabBarImage = @"icn-tabbar-conversations.png";
CGFloat const kConversationRefreshTimerDuration = 30.0;

@implementation YAConversationListViewController

@synthesize conversationRepository = conversationRepository_;
@synthesize conversationComposeViewControllerInstanceFactory = conversationComposeViewControllerInstanceFactory_;
@synthesize conversationFetchRequestCreator = conversationFetchRequestCreator_;
@synthesize conversationMessageListViewControllerCreator = conversationMessageListViewControllerCreator_;
@synthesize cellSelectionStyleBackgroundView = cellSelectionStyleBackgroundView_;
@synthesize conversationComposeViewController = conversationComposeViewController_;
@synthesize fetchedResultsControllerFactory = fetchedResultsControllerFactory_;
@synthesize fetchedResultsController = fetchedResultsController_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize managedObjectContext = managedObjectContext_;
@synthesize navigationBarButtonItemRepository = navigationBarButtonItemRepository_;
@synthesize refreshConversationTimer = refreshConversationTimer_;
@synthesize conversationListCellFactory = conversationListCellFactory_;
@synthesize contactRepository = contactRepository_;
@synthesize pullToRefreshCommandTransaction = pullToRefreshCommandTransaction_;
@synthesize pullDownRefreshViewInstanceFactory = pullDownRefreshViewInstanceFactory_;
@synthesize mainThreader = mainThreader_;

@synthesize pullToRefreshView = pullToRefreshView_;

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) 
    {
        [[self tabBarItem] setImage:[UIImage imageNamed:kConversationsListTabBarImage]];
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    YALogWarning(@"Received memory warning from system");
    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewWillAppear:(BOOL)animated 
{   
    managedObjectContext_ = [managedObjectContextFactory_ createWithStalenessInterval:0];
    
    NSFetchRequest *fetchRequest = [conversationFetchRequestCreator_ fetchRequestForAllConversationsInManagedObjectContext:managedObjectContext_];
    
    fetchedResultsController_ = [fetchedResultsControllerFactory_ createWithFetchRequest:fetchRequest forManagedObjectContext:managedObjectContext_ delegate:self];
    
    NSError *error;
    
    [fetchedResultsController_ performFetch:&error];
    
    //todo: handle error if needed
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(managedObjectContextDidSave:) 
                                                 name:NSManagedObjectContextDidSaveNotification 
                                               object:nil];

    [contactRepository_ addSubscriber:self];

    [self updateConversations];
    [super viewWillAppear:YES];
    
  
    [[self tableView] reloadData];
    
    //
    // Commenting the line below and replacing with [tableView reloadData]. 
    // I feel there is no difference between the two lines in terms of performance, except that
    // reloadData reloads the dataSource for the FetchedResultsController. We need the data source to be reloaded when the sqlLite file is deleted  
    // Calling [configureCell] without reloading the dataSource causes Core-data error.
    // 
    
    /*
     [self rebindVisibleCellsWithConversations];
     */
}

- (void)viewWillDisappear:(BOOL)animated
{
    [contactRepository_ removeSubscriber:self];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSManagedObjectContextDidSaveNotification
                                                  object:nil];
    
    [fetchedResultsController_ setDelegate:nil];
    
    managedObjectContext_ = nil;
    fetchedResultsController_ = nil;
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[[self navigationController] navigationBar] setTintColor:kNavigationBarTintColor];

    [[self navigationItem] setBackBarButtonItem:[[self navigationBarButtonItemRepository] backButtonItemItemWithTitle:kBackButtonText target:nil action:nil]];
    [[self navigationItem] setRightBarButtonItem:[[self navigationBarButtonItemRepository] composeButtonItemWithTarget:self action:@selector(compose:)]];
    [[self navigationItem] setLeftBarButtonItem:nil];
    [[self navigationItem] setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-header"]]];
    CGRect titleFrame = [[[self navigationItem] titleView] frame];
    [[[self navigationItem] titleView] setFrame:CGRectMake(titleFrame.origin.x, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height + 3.0)];
    [[[self navigationItem] titleView] setContentMode:UIViewContentModeTop];
    
    cellSelectionStyleBackgroundView_ = [[UIView alloc] init];
    [cellSelectionStyleBackgroundView_ setBackgroundColor:kConversationListCellSelectionStyleColor];
    
    //
    // Not a fan of dead code left as a comment, but this is useful for dev testing if 
    // you want to delete conversations without having to re-register each time. Just 
    // don't commit with the line below uncommented. Perhaps this could be moved to debug 
    // only settings in the future.
    //
    //[conversationRepository_ deleteAllConversations];
    
    [self setTitle:kConversationsListTitle];
}

- (void)loadView {
    [super loadView];
    id<PullToRefreshView> pullToRefreshView = [[self pullDownRefreshViewInstanceFactory] createPullDownRefreshViewWithFrame:[[self tableView] frame]];
    [pullToRefreshView setLastUpdateDateToCurrentDate];
    [[self tableView] addSubview:[pullToRefreshView viewValue]];
    [self setPullToRefreshView:[pullToRefreshView viewValue]];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{
    YAConversation *conversation = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [(id<ConversationListCell>)cell bindConversation:conversation];
}

- (UIViewController*)viewController
{
    return self;
}

#pragma mark -
#pragma mark Table View delegate/data source methods

- (void)conversationComposeViewController:(id<ViewControllerAccessor>)conversationComposeViewController didFinishWithResult:(YAComposeResult)result conversation:(YAConversation*)conversation
{
    [[[self conversationComposeViewController] viewController] dismissModalViewControllerAnimated:YES];
    
    [self setConversationComposeViewController:nil];
    
    YALogDebug_c(lcl_cConversationUINavigation,
                 @"%@ new conversation",
                 (result==YAComposeResultCancelled)?@"Cancelled":@"Sent");
    
    if(result != YAComposeResultCancelled && conversation)
    {
        [self navigateToConversation:conversation];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(id<NSFetchedResultsSectionInfo>)[[[self fetchedResultsController] sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YAConversation *conversation = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    UITableViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:[[self conversationListCellFactory] cellReuseIdentifierWithConversation:conversation]];
    
    if (!cell) {
        cell = [[self conversationListCellFactory] createConversationListCellWithConversation:conversation];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    [cell setSelectedBackgroundView:cellSelectionStyleBackgroundView_];
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YAConversation *conversation = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    YALogInfo_c(lcl_cConversationUINavigation,
                @"Selected conversation\n%@\nat index path\n\t[section:%d,row:%d]\n",
                conversation,
                [indexPath section],
                [indexPath row]);
    
    [self navigateToConversation:conversation];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YAConversation *conversation = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    return [[self conversationListCellFactory] cellHeightForConversation:conversation];
}

#pragma mark -
#pragma mark Refresh Header methods

- (void)refreshRestore
{
    //hide the refresh header view by removing the edge inset from the table view's contentView
    [UIView animateWithDuration:0.2 animations:^{
        [[self tableView] setContentInset: UIEdgeInsetsZero];
    }];
    [[self pullToRefreshView] setLastUpdateDateToCurrentDate];
}

- (void)refreshDidFinish
{
    [self refreshRestore];
    [[self pullToRefreshView] setState:PullToRefreshViewStateNormal];
}

- (void)refreshDidFinishWithError:(NSError*)aError 
{
    [self refreshRestore];
    
    PullToRefreshViewErrorCode code = PullToRefreshViewErrorCodeDefault;
    
    if ([NSURLErrorDomain isEqualToString:[aError domain]])
    {
        code = PullToRefreshViewErrorCodeNetwork;
    }
    
    [[self pullToRefreshView] setErrorStateWithCode:code];
}

- (void)refreshWillStart {
    [[self pullToRefreshView] setState:PullToRefreshViewStateLoading];
    //keep showing the refresh header view while updating, by add a edge inset to the table view's contentView, with a height the same the refresh header
    [UIView animateWithDuration:0.2 animations:^{
        [[self tableView] setContentInset: UIEdgeInsetsMake([[self pullToRefreshView] heightOfMessageArea], 0.0f, 0.0f, 0.0f)];
    }];

    pullToRefreshCommandTransaction_ = [self updateConversations];
}

#pragma mark -
#pragma mark CommandTransactionDelegate methods

- (void)commandTransactionDidSucceed:(id<CommandTransaction>)commandTransaction
{
    if(pullToRefreshCommandTransaction_ == commandTransaction)
    {
        pullToRefreshCommandTransaction_ = nil;
        [mainThreader_ asyncPerformSelector:@selector(refreshDidFinish) onTarget:self];
    }
}

- (void)commandTransaction:(id<CommandTransaction>)commandTransaction didFailWithError:(NSError*)error;
{
    if(pullToRefreshCommandTransaction_ == commandTransaction)
    {
        pullToRefreshCommandTransaction_ = nil;
        [mainThreader_ asyncPerformSelector:@selector(refreshDidFinishWithError:) onTarget:self withObject:error];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView 
{
    if ([[self searchDisplayController] searchResultsTableView] == scrollView) return;
    
    CGFloat offset;
    CGFloat msgHeight = [[self pullToRefreshView] heightOfMessageArea];
    switch ([pullToRefreshView_ state]) 
    {
        case PullToRefreshViewStateLoading:
            offset = MAX(scrollView.contentOffset.y * -1, 0);
            offset = MIN(offset, msgHeight);
            [scrollView setContentInset: UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f)];
            break;
        case PullToRefreshViewStateError:
        case PullToRefreshViewStateNormal:
            if (scrollView.isDragging && scrollView.contentOffset.y < -msgHeight)
            {
                [[self pullToRefreshView] setState:PullToRefreshViewStatePulling];
            }
            break;
        case PullToRefreshViewStatePulling:
            if (scrollView.isDragging && scrollView.contentOffset.y > -msgHeight && scrollView.contentOffset.y < 0.0f)
            {
                [[self pullToRefreshView] setState:PullToRefreshViewStateNormal];
            }
            break;
        default:
            break;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if([[self searchDisplayController] searchResultsTableView] == scrollView) return;
    
    if ([pullToRefreshView_ state] == PullToRefreshViewStatePulling) 
    {
        [self refreshWillStart];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSArray *indexPathsForSelectedRows = [[self tableView] indexPathsForVisibleRows];
    YAConversation *conversation = nil;
    
    for (NSIndexPath *indexPath in indexPathsForSelectedRows) 
    {
        if (!(conversation = [[self fetchedResultsController] objectAtIndexPath:indexPath])) 
        {
            YALogError(@"Error:\nNil conversation at index path\n\t[section:%d,row:%d]\n",
                       [indexPath section],
                       [indexPath row]);
            continue;
        }
        
        if ([[conversation status] intValue] == YAConversationStatusGapPlaceholder) 
        {
            YALogDebug(@"Fill gap at\n\t[section:%d,row:%d]\n",
                       [indexPath section],
                       [indexPath row]);
            
            [[self conversationRepository] loadConversationsAfterConversation:conversation];
        }
    }
}

#pragma mark -
#pragma mark ContactRepositorySubscriber methods

- (void)contactRepositoryDidLoadContacts:(id<ContactRepository>)contactRepository
{
    [[self tableView] reloadData];
}

#pragma mark -

- (UITableView *)tableView
{
    return (UITableView *)[self view];
}

- (void)compose:(id)sender
{    
    [self presentModalViewController:[[self conversationComposeViewController] viewController] animated:YES];
    
    YALogInfo_c(lcl_cConversationUINavigation,@"Composing new conversation");
}

-(void)refresh:(id)sender
{
    YALogInfo_c(lcl_cConversationUINavigation,@"Refreshing most recent conversations");
    [self updateConversations];
}

- (void)refreshMostRecentConversations:(NSTimer *)aTimer
{
    [self refresh:aTimer];
}

- (void)navigateToConversation:(YAConversation*)conversation
{
    YAConversationStatus conversationStatus = [[conversation status] intValue];
    if (conversationStatus == YAConversationStatusGapPlaceholder) {
        return;
    }
    
    id<ViewControllerAccessor> conversationMessageListViewControllerAccessor = [[self conversationMessageListViewControllerCreator] createWithConversation:conversation];
    [[self navigationController] pushViewController:[conversationMessageListViewControllerAccessor viewController] animated:YES];
}

- (id<CommandTransaction>)updateConversations
{
    return [[self conversationRepository] loadMostRecentConversationsWithTransactionDelegate:self];
}

- (id<ViewControllerAccessor>)conversationComposeViewController
{
    if(!conversationComposeViewController_) {
        conversationComposeViewController_ = [[self conversationComposeViewControllerInstanceFactory] createConversationComposeViewControllerWithDelegate:self];
    }
    
    return conversationComposeViewController_;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] reloadData];
}

- (void)managedObjectContextDidSave:(NSNotification *)notification
{
    if ([notification object] == managedObjectContext_) return;
    
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(managedObjectContextDidSave:) withObject:notification waitUntilDone:YES];
        return;
    }
    
    [managedObjectContext_ mergeChangesFromContextDidSaveNotification:notification];
}

- (void)rebindVisibleCellsWithConversations
{
    [[[self tableView] visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITableViewCell *eachCell = (UITableViewCell *)obj;
        [self configureCell:eachCell atIndexPath:[[self tableView] indexPathForCell:eachCell]];
    }];
}

@end
