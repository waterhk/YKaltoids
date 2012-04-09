//
//  YAConversationMessageListViewController.m
//  altoids
//
//  Created by Jon Herron on 10/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationMessageListViewController.h"
#import "ConversationMessageListTableViewDataSource.h"
#import "YAManagedObjectContextFactory.h"
#import "YAParticipant.h"
#import "YAMessage.h"
#import "MessageStatus.h"
#import "ConversationViewCell.h"
#import "ConversationViewCellsHeightConfiguration.h"
#import "PullToRefreshView.h"
#import "Threader.h"

CGFloat const kUnreadMessageTimerInterval = 0.8;
//TODO: use the height of messageListView in YAConversationNewMessageListVC
CGFloat const kHeightOfVisibleAreaInConversationMessageList = 369;

@interface YAConversationMessageListViewController ()
{
    UIEdgeInsets base;
}

@property (strong, nonatomic) YAConversation *conversation;

@property (strong, nonatomic) id<ConversationMessageListTableViewDataSource> conversationMessageListTableViewDataSource;
@property (nonatomic, strong) id<CommandTransaction> pullToRefreshCommandTransaction;

- (void)retrieveImageForVisibleIndexPath:(NSIndexPath *)indexPath;
- (void)retrieveImageForVisbileMessage:(YAMessage *)message;
- (void)startUnreadMessageProcessorTimer;
- (void)markUnreadMessagesAsRead:(NSTimer *)aTimer;
- (void)updateImageForVisibleMessageSenders;
- (id<CommandTransaction>)updateConversation;

@end

@implementation YAConversationMessageListViewController

@synthesize conversationRepository = conversationRepository_;
@synthesize participantRepository = participantRepository_;
@synthesize imageScaler = imageScaler_;
@synthesize conversation = conversation_;
@synthesize participantHandler = participantHandler_;
@synthesize messageHandler = messageHandler_;
@synthesize conversationMessageListTableViewDataSource = conversationMessageListTableViewDataSource_;
@synthesize conversationMessageListTableViewDataSourceInstanceFactory = conversationMessageListTableViewDataSourceInstanceFactory_;
@synthesize conversationViewCellsHeightConfiguration = conversationViewCellsHeightConfiguration_;
@synthesize pullUpRefreshViewInstanceFactory = pullUpRefreshViewInstanceFactory_;
@synthesize pullToRefreshView = pullToRefreshView_;
@synthesize pullToRefreshCommandTransaction = pullToRefreshCommandTransaction_;
@synthesize mainThreader = mainThreader_;

- (id)initWithConversation:(YAConversation *)conversation
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) 
    {
        conversation_ = conversation;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setConversationMessageListTableViewDataSource:[[self conversationMessageListTableViewDataSourceInstanceFactory] createConversationMessageListTableViewDataSourceWithConversation:[self conversation] delegate:self]];
    
    [[self conversationMessageListTableViewDataSource] load];
    
    [[self tableView] setDataSource:[self conversationMessageListTableViewDataSource]];
    
    [[self tableView] reloadData];
    
    [self scrollToMostAppropriateMessage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateConversation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self conversationMessageListTableViewDataSource] unload];
    
    [[self tableView] setDataSource:nil];
    
    [self setConversationMessageListTableViewDataSource:nil];
}

- (void)loadView
{
    [super loadView];
    //Fill cells bottom up
    base = UIEdgeInsetsMake(kHeightOfVisibleAreaInConversationMessageList, 0, 0, 0);
    [[self tableView] setContentInset:base];
    
    //load the pull up refresh
    id<PullToRefreshView> pullToRefreshView = [[self pullUpRefreshViewInstanceFactory] createPullUpRefreshViewWithFrame:[[self tableView] frame]];
    [pullToRefreshView setLastUpdateDateToCurrentDate];
    [[self tableView] setTableFooterView:[pullToRefreshView viewValue]];
    [self setPullToRefreshView:[pullToRefreshView viewValue]];
}

- (void)scrollToMostAppropriateMessage
{
    NSIndexPath *indexPathForMessage;
    UITableViewScrollPosition scrollPosition;
    YAMessage *message;
 
    [[self tableView] setContentInset:base];
    message = [[self conversationMessageListTableViewDataSource] oldestUnreadMessage];
    scrollPosition = UITableViewScrollPositionTop;
    
    if (!message) 
    {
        message = [[self conversationMessageListTableViewDataSource] lastMessage];
        scrollPosition = UITableViewScrollPositionBottom;
    }
    
    indexPathForMessage = [[self conversationMessageListTableViewDataSource] indexPathForMessage:message];
    
    if (indexPathForMessage) 
    {
        [[self tableView] reloadData];
        [[self tableView] scrollToRowAtIndexPath:indexPathForMessage atScrollPosition:scrollPosition animated:NO];
    }
}

- (UIViewController*)viewController
{
    return self;
}

- (void)messagesDidUpdate
{
    [[self tableView] reloadData];
    //Fill cells bottom up
    base = UIEdgeInsetsMake([self calcTopInset], 0, 0, 0);
    [[self tableView] setContentInset: base];
    
    [self scrollToMostAppropriateMessage];
    [self startUnreadMessageProcessorTimer];
}

- (void)participantsDidUpdate
{   
    [self updateImageForVisibleMessageSenders];
}

- (void)contactsDidUpdate
{
    [[self tableView] reloadData];
}

- (id<CommandTransaction>)updateConversation;
{
    return [[self conversationMessageListTableViewDataSource] fetchMessagesForConversationWithTransactionDelegate:self];
}

- (CGFloat) calcFooterYPositionRelativeToBottomEdgeOfVisibleArea
{
    UITableView* tableView = [self tableView];
    return - ([tableView convertRect:[[tableView tableFooterView] frame] toView:[tableView superview]].origin.y - kHeightOfVisibleAreaInConversationMessageList);
}

- (CGFloat) calcTopInset
{
    CGFloat topInset = kHeightOfVisibleAreaInConversationMessageList - [self calcContentAreaHeight];
    if (topInset < 0)
    {
        topInset = 0;
    }
    return  topInset;
}

- (CGFloat) calcContentAreaHeight
{
    return [[[self tableView] tableFooterView] frame].origin.y;
}

#pragma mark -
#pragma mark Refresh Footer methods

- (void)refreshRestore
{
    [[self pullToRefreshView] setLastUpdateDateToCurrentDate];
    [self scrollToMostAppropriateMessage];
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

- (void)refreshWillStart 
{
    [[self pullToRefreshView] setState:PullToRefreshViewStateLoading];
    
    pullToRefreshCommandTransaction_ = [self updateConversation];
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


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YAMessage *message = [[self conversationMessageListTableViewDataSource] messageAtIndexPath:indexPath];    
    return [[self conversationViewCellsHeightConfiguration] heightOfCellForMessage:message];
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSArray *indexPathsForSelectedRows = [[self tableView] indexPathsForVisibleRows];
    YAMessage *message = nil;
    
    for (NSIndexPath *indexPath in indexPathsForSelectedRows) 
    {
        if (!(message = [[self conversationMessageListTableViewDataSource] messageAtIndexPath:indexPath])) 
        {
            continue;
        }
        
        if ([[message status] intValue] == YAMessageStatusGapPlaceholder) 
        {
            [[self conversationRepository] loadMessagesForConversation:[self conversation] afterMessage:message];
        }
        
        [self retrieveImageForVisbileMessage:message];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView 
{
    if ([[self searchDisplayController] searchResultsTableView] == scrollView) return;

    CGFloat msgHeight = [[self pullToRefreshView] heightOfMessageArea];
    CGFloat offset = [self calcFooterYPositionRelativeToBottomEdgeOfVisibleArea];
    switch ([pullToRefreshView_ state]) 
    {
        case PullToRefreshViewStateError:
        case PullToRefreshViewStateNormal:
            if (scrollView.isDragging && (offset > msgHeight))
            {
                [[self pullToRefreshView] setState:PullToRefreshViewStatePulling];
            }
            break;
        case PullToRefreshViewStatePulling:
            if (scrollView.isDragging && (offset < msgHeight) && (scrollView.contentOffset.y > 0))
            {
                [[self pullToRefreshView] setState:PullToRefreshViewStateNormal];
            }
            break;
        default:
            break;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate 
{
    if([[self searchDisplayController] searchResultsTableView] == scrollView) return;
    
    if ([pullToRefreshView_ state] == PullToRefreshViewStatePulling) 
    {
        [self refreshWillStart];
    }
}

#pragma mark -

- (void)replyWithText:(NSString *)messageText
{
    NSError *error = nil;
    
    [[self conversationRepository] replyToConversation:[self conversation] messageBody:messageText error:&error];
    
    if (error) {
        YALogError(@"Message could not be sent %@",[error localizedDescription]);
    }
}

- (void)updateImageForVisibleMessageSenders
{   
    [[self tableView] reloadData];
    
    [[[self tableView] visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id<ConversationViewCell> cell = obj;
        NSIndexPath *indexPath = [[self tableView] indexPathForCell:(UITableViewCell*)cell];
        YAMessage *message = [[self conversationMessageListTableViewDataSource] messageAtIndexPath:indexPath];
        
        if ([[self messageHandler] messageHasSystemMessageStatus:message] ||
            [[self messageHandler] messageHasGapPlaceholderStatus:message])
        {
            return;
        }

        // TODO the line below does nothing (and Xcode warned to that effect);
        // this should get resolved with http://bug.corp.yahoo.com/show_bug.cgi?id=5427885
        // addressing Ma's comment on CR http://codereview.corp.yahoo.com/r/92690/

        
        YAParticipant *messageSender = [[self messageHandler] senderForMessage:message];
        UIImage *image = [[self participantRepository] imageForParticipant:messageSender];
                
                if (image) 
                    {
                            [self setParticipantImage:image forCell: cell];
                    }
    }];
}

#pragma mark -
#pragma mark YAConversationListViewController ()

- (void)retrieveImageForVisibleIndexPath:(NSIndexPath *)indexPath
{
    YAMessage *message = [[self conversationMessageListTableViewDataSource] messageAtIndexPath:indexPath];
    
    if (!message) 
    {
        return;
    }
    
    [self retrieveImageForVisbileMessage:message];    
}

- (void)retrieveImageForVisbileMessage:(YAMessage *)message
{
    if ([[self messageHandler] messageHasSystemMessageStatus:message] ||
        [[self messageHandler] messageHasGapPlaceholderStatus:message])
        return;
    
    if (![[self participantRepository] imageForParticipant:[message sender]])
        [[self participantRepository] retrieveImageForParticipant:[message sender]];
}
 
- (void)startUnreadMessageProcessorTimer
{
    [NSTimer scheduledTimerWithTimeInterval:kUnreadMessageTimerInterval 
                                     target:self 
                                   selector:@selector(markUnreadMessagesAsRead:) 
                                   userInfo:nil 
                                    repeats:NO];
}

- (void)markUnreadMessagesAsRead:(NSTimer *)aTimer
{
    NSArray *unreadMessages = [[self conversationMessageListTableViewDataSource] unreadMessages];
    
    if ([unreadMessages count] > 0) {
        [[self conversationRepository] markUnreadMessagesAsRead:unreadMessages forConversation:[self conversation]];
        [[self tableView] reloadData];
    }
}

- (void)setParticipantImage:(UIImage *)theParticipantImage forCell:(id<ConversationViewCell>)theCell
{
        theParticipantImage = [[self imageScaler] scaleImage:theParticipantImage toSize:CGSizeMake(kParticipantImageWidth, kParticipantImageHeight)];
        [theCell setAvatar:theParticipantImage];
}

@end
