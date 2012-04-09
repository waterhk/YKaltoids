//
//  YAConversationNewMessageListViewController.m
//  altoids
//
//  Created by Jon Herron on 10/25/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationNewMessageListViewController.h"
#import "ConversationDetailsViewController.h"
#import "AppFactory.h"
#import "NavigationBarButtonItemRepository.h"
#import "ContactRepository.h"

#define kSoftKeyboardOffset 216

@interface YAConversationNewMessageListViewController () <MessageComposeViewDelegate>

@property (nonatomic, strong) id<MessageListViewController> messageListViewController;
@property (nonatomic, strong) id<ParticipantDescriptionBuilder> participantDescriptionBuilder;
@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;
@property (strong, nonatomic) id<ConversationDetailsViewControllerInstanceFactory> conversationDetailsViewControllerInstanceFactory;
@property (strong, nonatomic) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;
@property (strong, nonatomic) id<ContactRepository> contactRepository;
@property (strong, nonatomic) YAConversation *conversation;

@property (nonatomic, strong) UILabel *navigationBarTitleLabel;

- (void)launchConversationDetails:(id)sender;
- (void)setParticipantDescriptionAsTitle;
- (void)configureTableViewFrameForMessageList;

@end

@implementation YAConversationNewMessageListViewController
@synthesize messageReplyView = messageReplyView_;
@synthesize messagesListView = messagesListView_;
@synthesize messageListViewController = messageListViewController_;
@synthesize participantDescriptionBuilder = participantDescriptionBuilder_;
@synthesize mutableArrayCreator = mutableArrayCreator_;
@synthesize conversationDetailsViewControllerInstanceFactory = conversationDetailsViewControllerInstanceFactory_;
@synthesize navigationBarButtonItemRepository = navigationBarButtonItemRepository_;
@synthesize conversation =conversation_;
@synthesize contactRepository = contactRepository_;
@synthesize navigationBarTitleLabel = navigationBarTitleLabel_;

- (id)initWithMessageListViewController:(id<MessageListViewController>)messageListViewController
                                nibName:(NSString *)nibNameOrNil
                                 bundle:(NSBundle *)nibBundleOrNil
          participantDescriptionBuilder:(id<ParticipantDescriptionBuilder>)theParticipantDescriptionBuilder 
                    mutableArrayCreator:(id<MutableArrayCreator>)theMutableArrayCreator 
conversationDetailsViewControllerInstanceFactory:(id<ConversationDetailsViewControllerInstanceFactory>)theConversationDetailsViewControllerInstanceFactory
      navigationBarButtonItemRepository:(id<NavigationBarButtonItemRepository>)navigationBarButtonItemRepository
                      contactRepository:(id<ContactRepository>)contactRepository
                           conversation:(YAConversation *)theConversation
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        messageListViewController_ = messageListViewController;
        participantDescriptionBuilder_ = theParticipantDescriptionBuilder;
        mutableArrayCreator_ = theMutableArrayCreator;
        conversationDetailsViewControllerInstanceFactory_ = theConversationDetailsViewControllerInstanceFactory;
        navigationBarButtonItemRepository_ = navigationBarButtonItemRepository;
        contactRepository_ = contactRepository;
        conversation_ = theConversation;
        
        [self setHidesBottomBarWhenPushed:YES];
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
    
    [[self navigationItem] setRightBarButtonItem:[[self navigationBarButtonItemRepository] settingsButtonItemWithTarget:self action:@selector(launchConversationDetails:)]];
    
    navigationBarTitleLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 180, 20)];
    [navigationBarTitleLabel_ setBackgroundColor:[UIColor clearColor]];
    [navigationBarTitleLabel_ setTextAlignment:UITextAlignmentCenter];
    [navigationBarTitleLabel_ setTextColor:[UIColor whiteColor]];
    [navigationBarTitleLabel_ setFont:[UIFont boldSystemFontOfSize:kConversationViewTitleFontSize]];
    [navigationBarTitleLabel_ setShadowColor:[UIColor blackColor]];
    [[self navigationItem] setTitleView:navigationBarTitleLabel_];
    
    [[self navigationItem] setBackBarButtonItem:[[self navigationBarButtonItemRepository] backButtonItemItemWithTitle:kBackButtonText target:nil action:nil]];

    
    UIView *messageListVCView = [[[self messageListViewController] viewController] view];
    [[self messagesListView] addSubview:messageListVCView];    
    
    if ([[self conversation] hasUser]) {
        [[self messageReplyView] injectWithMessageComposeViewDelegate:self 
                                                                  maximumCharactersAllowed:kMaximumCharactersForConversationMessage];
    } else {
        CGFloat replyViewHeight = [[self messageReplyView] frame].size.height;
        NSLog(@"reply view height:%1.1f",replyViewHeight);
        [[self messageReplyView] removeFromSuperview];
        CGRect f = [[self view] bounds];
        f.size.height += replyViewHeight;
        [[self messagesListView] setFrame:f];
        
        NSLog(@"%1.1f,%1.1f",f.size.width,f.size.height);
    }
    
    [self configureTableViewFrameForMessageList];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [[[self messageListViewController] viewController] viewDidUnload];

    [self setMessagesListView:nil];
    [self setMessageReplyView:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[[self messageListViewController] viewController] viewWillAppear:YES];
    
    [self setParticipantDescriptionAsTitle];
    
    [contactRepository_ addSubscriber:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[[self messageListViewController] viewController] viewDidAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
 
    [[[self messageListViewController] viewController] viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [contactRepository_ removeSubscriber:self];
    [[[self messageListViewController] viewController] viewDidDisappear:animated];
}

- (void)launchConversationDetails:(id)sender
{
    id<ConversationDetailsViewController> conversationDetailsViewControllerAccessor = [[self conversationDetailsViewControllerInstanceFactory] createConversationDetailsViewControllerWithConversation:[self conversation] managedObjectContext:[[self conversation] managedObjectContext]];
    UIViewController *conversationDetailsViewController = [conversationDetailsViewControllerAccessor viewController];
    
    [[self navigationController] pushViewController:conversationDetailsViewController animated:YES];
}

#pragma mark -
#pragma mark touch handling

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self messageReplyView] messageComposeShouldEnd];
}

- (void)didBeginComposingMessage
{
    [[self messagesListView] setUserInteractionEnabled:NO];
    
    CGRect messageListViewFrame = [[self messagesListView] frame];
    CGRect messageReplyViewFrame = [[self messageReplyView] frame];
    
    messageListViewFrame.size.height -= kSoftKeyboardOffset;
    messageReplyViewFrame.origin.y -= kSoftKeyboardOffset;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [[self messagesListView] setFrame:messageListViewFrame];
                         [self configureTableViewFrameForMessageList];
                         [[self messageReplyView] setFrame:messageReplyViewFrame];
                     } completion:^(BOOL finished) {
                         [messageListViewController_ scrollToMostAppropriateMessage];
                     }];
}

- (void)didEndComposingMessage
{
    [[self messagesListView] setUserInteractionEnabled:YES];
    
    CGRect messageListViewFrame = [[self messagesListView] frame];
    CGRect messageReplyViewFrame = [[self messageReplyView] frame];
    
    messageListViewFrame.size.height += kSoftKeyboardOffset;
    messageReplyViewFrame.origin.y += kSoftKeyboardOffset;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [[self messagesListView] setFrame:messageListViewFrame];
                         [self configureTableViewFrameForMessageList];
                         [[self messageReplyView] setFrame:messageReplyViewFrame];
                     } completion:^(BOOL finished) {
                         [messageListViewController_ scrollToMostAppropriateMessage];
                     }];
}

- (void)messageComposedWithText:(NSString *)messageText
{
    [[self messageListViewController] replyWithText:messageText];
}

#pragma mark -
#pragma mark YAConversationListViewController ()

- (void)setParticipantDescriptionAsTitle
{
    NSString *participantsDescription = [[self participantDescriptionBuilder] descriptionForParticipants:[[[self conversation] participants] allObjects] forDisplayInLabel:[self navigationBarTitleLabel]];
    [[self navigationBarTitleLabel] setText:participantsDescription];
}

- (void)configureTableViewFrameForMessageList
{
    UITableView *tableView = (UITableView *)[[[self messageListViewController] viewController] view];
    CGRect messageListViewFrame = [[self messagesListView] bounds];
    
    if ([tableView dataSource])
    {
        UIEdgeInsets tableInset = [tableView contentInset];
        tableInset.bottom = 0;
        [tableView setContentInset:tableInset];
        [tableView setFrame:messageListViewFrame];
    }
}

#pragma mark ContactRepositorySubscriber

- (void)contactRepositoryDidLoadContacts:(id<ContactRepository>)contactRepository
{
    [self setParticipantDescriptionAsTitle];
}

- (void)messageComposeViewDidResizeFromFrame:(CGRect)originalFrame toFrame:(CGRect)newFrame
{
    CGRect tableFrame = [messagesListView_ frame];
    CGRect replyFrame = [messageReplyView_ frame];
    CGFloat heightDiff = newFrame.size.height - originalFrame.size.height;
    
    replyFrame.origin.y -= heightDiff;
    tableFrame.size.height -= heightDiff;
    
    //KLUDGE: For some reason the reply frame height is not right, it should have been taken
    // care of when YAMessageComposeView adjusts it's height
    replyFrame.size.height += heightDiff;
    
    [messagesListView_ setFrame:tableFrame];
    [messageReplyView_ setFrame:replyFrame];
}

- (BOOL)messageComposeViewCanEnableSendButton
{
    return YES;
}

@end
