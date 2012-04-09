//
//  YAConversationComposeViewController.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationComposeViewController.h"
#import "AppFactory.h"
#import "YATokenView.h"
#import "YATokenField.h"
#import "YASMSAddressInfo.h"
#import "ParticipantInfoCreator.h"
#import "YARegistrationInfo.h"
#import "NavigationBarButtonItemRepository.h"
#import "ParticipantPickerViewController.h"
#import "ContactPickerViewController.h"
#import "InvalidTokenSelectorViewController.h"
#import "ManagedObjectContextFactory.h"

// Private class extension
@interface YAConversationComposeViewController ()
{
    CGRect defaultComposeFrame;
}

// @property definitions


@property (strong, nonatomic, readwrite) id<InvalidTokenSelectorViewController> invalidTokenSelectorViewController;

@property (assign, nonatomic, readwrite) id<ConversationComposeDelegate> delegate;

@property (strong, nonatomic, readwrite) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic, readwrite) IBOutlet UIScrollView *containerView;
@property (strong, nonatomic, readwrite) IBOutlet YATokenView *tokenView;
@property (strong, nonatomic, readwrite) IBOutlet UIButton *multipleParticipantPickerBtn;

@property (assign, nonatomic, readwrite) UIView* pickerView;
@property (assign, nonatomic, readwrite) UIView* invalidTokenSelectorView;
@property (strong, nonatomic) YATokenField *selectedToken;
@property (assign, nonatomic, readwrite) CGFloat scrollByOffsetY;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


// methods

- (IBAction)cancel:(id)sender;

- (void)minimizeTokenViewForPicker;
- (void)restoreTokenViewAfterPickerSelection;
- (void)displayErrorForMaxParticipants:(NSUInteger)maxParticipants;
- (NSArray*)allParticipants;
- (void)insertParticipantPickerView;
- (void)removeParticipantPickerViewIfVisible;
- (void)dismissInvalidTokenSelectorViewIfVisible;

- (void)managedObjectContextDidSave:(NSNotification *)notification;

@end

@implementation YAConversationComposeViewController

@synthesize navigationControllerContainer;

@synthesize participantPicker;
@synthesize invalidTokenSelectorViewController;

@synthesize delegate;

@synthesize conversationRepository;

@synthesize navigationBar = navigationBar_;
@synthesize containerView = containerView_;
@synthesize tokenView = tokenView_;
@synthesize multipleParticipantPickerBtn = multipleParticipantPickerBtn_;
@synthesize messageComposeView = messageComposeView_;

@synthesize pickerView = pickerView_;
@synthesize invalidTokenSelectorView = invalidTokenSelectorView_;
@synthesize selectedToken = selectedToken_;
@synthesize scrollByOffsetY = scrollByOffsetY_;
@synthesize participants=participants_;
@synthesize participantNameFormatter = participantNameFormatter_;
@synthesize participantDescriptionBuilder = participantDescriptionBuilder_;
@synthesize participantInfoCreator = participantInfoCreator_;
@synthesize navigationBarButtonItemRepository = navigationBarButtonItemRepository_;
@synthesize contactPickerViewControllerInstanceFactory = contactPickerViewControllerInstanceFactory_;
@synthesize participantPickerViewControllerInstanceFactory = participantPickerViewControllerInstanceFactory_;
@synthesize invalidTokenSelectorViewControllerInstanceFactory = invalidTokenSelectorViewControllerInstanceFactory_;
@synthesize smsAddressHandleFormatValidator = smsAddressHandleFormatValidator_;

@synthesize registrationRepository = registrationRepository_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize managedObjectContext = managedObjectContext_;

- (id)initWithNibName:(NSString*)nibNameOrNil 
               bundle:(NSBundle*)nibBundleOrNil
             delegate:(id<ConversationComposeDelegate>)theDelegate
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setDelegate:theDelegate];
        scrollByOffsetY_ = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationBar] setTintColor:kNavigationBarTintColor];
    
    UINavigationItem* navigationItem = [self navigationItem];
    [navigationItem setTitle:kConversationComposeTitle];
    [navigationItem setRightBarButtonItem:[[self navigationBarButtonItemRepository] cancelButtonItemWithTarget:self action:@selector(cancel:)]];
    [[self navigationBar] pushNavigationItem:navigationItem animated:FALSE];
    
    [[self tokenView] injectWithParticipantDescriptionBuilder:participantDescriptionBuilder_ 
                                     participantNameFormatter:participantNameFormatter_ 
                              smsAddressHandleFormatValidator:smsAddressHandleFormatValidator_ 
                                       registrationRepository:registrationRepository_];
    
    defaultComposeFrame = [messageComposeView_ frame];
}

- (void)viewDidUnload
{
    [self setMessageComposeView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [self setNavigationBar:nil];
    [self setTokenView:nil];
    [self setMultipleParticipantPickerBtn:nil];
    [self setContainerView:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    managedObjectContext_ = [managedObjectContextFactory_ create];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(managedObjectContextDidSave:) 
                                                 name:NSManagedObjectContextDidSaveNotification 
                                               object:nil];
    
    [messageComposeView_ injectWithMessageComposeViewDelegate:self
                                     maximumCharactersAllowed:kMaximumCharactersForConversationMessage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // set participants (if any)
    if ([[self participants] count] > 0) {
        
        for (YAParticipantInfo *participant in [self participants]) {
            [[self tokenView] addTokenFieldWithInfo:participant];
        }
        
        // HACK: We need to properly handle setting participants on the
        // compose view controller (using the public accessor). 
        // But, we are taking a shortcut for now in order to get it working.
        // Currently the participants property is made to work only when 
        // presenting compose screen modally. participants MUST be set before 
        // the modal VC is displayed. Otherwise it wont work.
        
        // TODO: Need to sync participants properly on add/delete
        [self setParticipants:nil];
    }    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [messageComposeView_ clearDelegate:self];
    
    managedObjectContext_ = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSManagedObjectContextDidSaveNotification
                                                  object:nil];    
}

- (void)tokenView:(YATokenView*)tokenView textFieldValueDidChange:(NSString*)changedValue
{
    // display YAParticipantPickerViewController

    // We have dismissed the picker and we are getting
    // a changedValue of nil. This happens when user is deleting
    // tokens. We simply ignore this case.
    if (![self pickerView] && ![changedValue length]) {        
        return;
    }
    
    if (![self pickerView] && [changedValue length] > 0) {
        [self insertParticipantPickerView];
    }
    else if ([self pickerView] && ![changedValue length]) {
        // dismiss picker
        [self removeParticipantPickerViewIfVisible];
        return;
    }
    
    // minimize token view to display only single row
    [self minimizeTokenViewForPicker];
                    
    // call findParticipantsForQueryString w/ changedValue
    [[self participantPicker] findParticipantsForQueryString:changedValue];
}

- (void)tokenView:(YATokenView *)tokenView textFieldValueDidCommit:(NSString *)committedValue
{
    YAParticipantInfo* participantInfo = [participantInfoCreator_ participantInfoWithUserInput:committedValue];

    [[self tokenView] addTokenFieldWithInfo:participantInfo];
    [self restoreTokenViewAfterPickerSelection];
}

- (void)tokenView:(YATokenView *)tokenView didSelectInvalidToken:(YATokenField*)invalidToken withAddressHandle:(NSString *)addressHandle
{
    [self removeParticipantPickerViewIfVisible];
    [self setSelectedToken:invalidToken];
    
    if (![self invalidTokenSelectorView]) {
        UIView *invalidTokenView = [[[self invalidTokenSelectorViewController] viewController] view];
        [self setInvalidTokenSelectorView:invalidTokenView];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [containerView_ addSubview:invalidTokenSelectorView_];
        [self minimizeTokenViewForInvalidTokenMessage];
    }];
}

- (void)tokenView:(YATokenView *)tokenView didSelectValidToken:(YATokenField*)validToken withAddressHandle:(NSString *)addressHandle
{
    [self dismissInvalidTokenSelectorViewIfVisible];
    
    [self setSelectedToken:validToken];
    
    if (![self pickerView]) {
        [self insertParticipantPickerView];
    }
    
    // show participant picker view and filter for current token's participant
    // minimize token view to display only single row
    [self minimizeTokenViewForPicker];
    
    // call findParticipantsForQueryString w/ changedValue
    [[self participantPicker] findParticipantsForQueryString:addressHandle];
}

- (void)didReceiveFocus
{
    [self dismissInvalidTokenSelectorViewIfVisible];    
    [self removeParticipantPickerViewIfVisible];    
}

- (void)tokenView:(YATokenView *)tokenView didResizeToRect:(CGRect)toRect fromRect:(CGRect)fromRect
{
    [self positionParticipantPickerAndContainer];
}

- (void)tokenView:(YATokenView *)tokenView displayModeDidChange:(YATokenViewDisplayMode)displayMode
{
    if (displayMode==YATokenViewDisplayDescription) {
        [[self multipleParticipantPickerBtn] setHidden:YES];
    }
    else if(displayMode==YATokenViewDisplayTokens) {
        [[self multipleParticipantPickerBtn] setHidden:NO];
    }
}

- (void)participantPicker:(id<ParticipantPickerViewController>)participantPicker didPickParticipantWithInfo:(YAParticipantInfo *)participantInfo
{
    [[self tokenView] addTokenFieldWithInfo:participantInfo];    
    [self removeParticipantPickerViewIfVisible];
}

- (BOOL)hasParticipants
{
    return ([[[self tokenView] tokens] count] > 0);
}

- (BOOL)shouldMergeExistingParticipants
{
    return YES;
}

- (NSSet*)existingParticipantInfos
{
    NSMutableSet *participantInfos = [NSMutableSet setWithCapacity:[[tokenView_ participantInfos] count]];
    
    for (YAParticipantInfo *participantInfo in [tokenView_ participantInfos]) 
    {
        [participantInfos addObject:participantInfo];
    }
    
    return participantInfos;
}

- (id<ParticipantPickerViewController>)participantPicker
{
    if (!participantPicker) {
        participantPicker = [[self participantPickerViewControllerInstanceFactory] createParticipantPickerViewControllerWithDelegate:self];
    }
    
    return participantPicker;
}

- (id<InvalidTokenSelectorViewController>)invalidTokenSelectorViewController
{
    if (!invalidTokenSelectorViewController) {
        invalidTokenSelectorViewController = [[self invalidTokenSelectorViewControllerInstanceFactory] createInvalidTokenSelectorViewController];
    }
    
    return invalidTokenSelectorViewController;
}

- (IBAction)pickMultipleParticipants:(id)sender
{
    [[self tokenView] createLozengeFromPendingUserInput];        
    [self dismissInvalidTokenSelectorViewIfVisible];

    id<ContactPickerViewController> contactPickerViewController = [contactPickerViewControllerInstanceFactory_ createContactPickerViewControllerWithDelegate:self participantInfos:[self existingParticipantInfos] modal:YES];

    NSArray *containers = [[self navigationControllerContainer] createContainersForRootViewControllers:[NSArray arrayWithObject:[contactPickerViewController viewController]]];
    [self presentModalViewController:[containers objectAtIndex:0] animated:YES];
}

- (IBAction)cancel:(id)sender
{
    if ([self delegate]) {
        [[self delegate] conversationComposeViewController:self didFinishWithResult:YAComposeResultCancelled conversation:nil];
    }    
}

- (void)minimizeTokenViewForPicker
{
    [self minimizeTokenViewForSubView:pickerView_];
}

- (void)minimizeTokenViewForInvalidTokenMessage
{
    [self minimizeTokenViewForSubView:invalidTokenSelectorView_];
}

- (void)minimizeTokenViewForSubView:(UIView *)subView
{
    CGRect tokenViewFrame = [tokenView_ frame];
    CGFloat tokenFieldSingleLineHeightWithPadding = kTokenFieldHeight + kTokenFieldPaddingForOffsetY;
    CGFloat visibleTokenViewArea = tokenViewFrame.size.height - scrollByOffsetY_;
    
    if (visibleTokenViewArea > tokenFieldSingleLineHeightWithPadding) 
    {
        CGFloat amountToHide;
        
        if (selectedToken_) 
        {
            amountToHide = [selectedToken_ frame].origin.y;
        }
        else 
        {
            amountToHide = visibleTokenViewArea - tokenFieldSingleLineHeightWithPadding;
        }
        
        if (amountToHide < tokenFieldSingleLineHeightWithPadding) 
        {
            [self positionContainerViewWithSubView:subView];
            
            return;
        }
        
        tokenViewFrame.origin.y -= amountToHide;
        scrollByOffsetY_ += amountToHide;
        
        [UIView animateWithDuration:0.3 animations:^{
            [tokenView_ setFrame:tokenViewFrame];
            [self positionContainerViewWithSubView:subView];
        }];
    }
}

- (void)restoreTokenViewAfterPickerSelection
{
    if (scrollByOffsetY_ > 0.0) 
    {
        CGRect tokenViewFrame = [tokenView_ frame];
        
        tokenViewFrame.origin.y += scrollByOffsetY_;
        scrollByOffsetY_ = 0;
        
        [UIView animateWithDuration:0.3 animations:^{
            [tokenView_ setFrame:tokenViewFrame];
            [self positionParticipantPickerAndContainer];
        }];
    }
}

- (void)displayErrorForMaxParticipants:(NSUInteger)maxParticipants
{
    NSString *alertTitle = [NSString stringWithFormat:@"%d Contacts Maximum",maxParticipants];
    NSString *message = [NSString stringWithFormat:@"You have reached the %d contact maximum for a group conversation",maxParticipants];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(alertTitle, @"Maximum participants alert title") 
                                                    message:NSLocalizedString(message, @"Maximum participants alert message") 
                                                   delegate:nil 
                                          cancelButtonTitle:NSLocalizedString(@"Ok", @"Maximum participants alert dialog dismiss button") 
                                          otherButtonTitles:nil, nil];
    [alert show];    
}

- (NSArray*)allParticipants
{
    return [tokenView_ participantInfos]; 
}

- (void)insertParticipantPickerView
{    
    UIView *participantPickerView = [[[self participantPicker] viewController] view];
    
    [self setPickerView:participantPickerView];
    
    [containerView_ addSubview:pickerView_];
    [self setPickerView:pickerView_];
    
    [self positionParticipantPickerAndContainer];
}

- (void)positionParticipantPickerAndContainer
{
    if (!pickerView_) 
    {
        return;
    }
    
    [self positionContainerViewWithSubView:pickerView_];
}

- (void)positionInvalidTokenMessageAndContainer
{
    if (!invalidTokenSelectorView_) 
    {
        return;
    }
    
    [self positionContainerViewWithSubView:invalidTokenSelectorView_];
}

- (void)positionContainerViewWithSubView:(UIView *)subView
{
    CGRect containerViewFrame = [containerView_ frame];
    CGRect messageComposeViewFrame = [messageComposeView_ frame];
    CGRect tokenViewFrame = [tokenView_ frame];
    
    containerViewFrame.origin.y = tokenViewFrame.origin.y + tokenViewFrame.size.height;
    containerViewFrame.size.height = messageComposeViewFrame.origin.y - containerViewFrame.origin.y;
    
    [containerView_ setFrame:containerViewFrame];
    
    CGRect subViewFrame = containerViewFrame;
    
    subViewFrame.origin.y = 0;
    
    [subView setFrame:subViewFrame];
}

- (void)removeParticipantPickerViewIfVisible
{
    if ([self pickerView]) {
        // dismiss picker
        [[self pickerView] removeFromSuperview];
        [self setPickerView:nil];
        [self clearSelectedToken];
        [self restoreTokenViewAfterPickerSelection];
    }
}

- (void)dismissInvalidTokenSelectorViewIfVisible
{
    if ([self invalidTokenSelectorView]) {
        CGRect minimizeFrame = [[self invalidTokenSelectorView] frame];
        minimizeFrame.origin.y = [[self view] frame].size.height;
        
        [UIView animateWithDuration:0.3
                         animations:^(void) {
                             [[self invalidTokenSelectorView] setFrame:minimizeFrame];
                         } completion:^(BOOL finished) {
                             [[self invalidTokenSelectorView] removeFromSuperview];
                             [self setInvalidTokenSelectorView:nil];                                                        
                             [self clearSelectedToken];
                             [self restoreTokenViewAfterPickerSelection];
                         }];
    }    
}

- (void)managedObjectContextDidSave:(NSNotification *)notification
{
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(managedObjectContextDidSave:) withObject:notification waitUntilDone:NO];
        return;
    }
    
    [managedObjectContext_ mergeChangesFromContextDidSaveNotification:notification];
}

- (UIViewController*)viewController
{
    return self;
}

- (void)didBeginComposingMessage
{
    
}

- (void)didEndComposingMessage
{

}

- (void)messageComposedWithText:(NSString *)messageText
{
    if ([[self allParticipants] count] == 0) {
        return;
    }
    
    if ([messageText isEqualToString:kTextViewPlaceHolderText] || ![messageText length]) {
        return;
    }
    
    YAParticipantInfo *conversationSender = [participantInfoCreator_ participantInfoForCurrentUser];
    
    NSError *errorWhenCreateNewConversation = nil;
    YAConversation *newConversation = [[self conversationRepository] createConversationWithSender:conversationSender participants:[self allParticipants] messageBody:messageText error:&errorWhenCreateNewConversation];
    
    if (errorWhenCreateNewConversation) 
    {
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:kUnableToCreateConvoTitle
                                                                 message:kUnableToCreateConvoMessage 
                                                                delegate:nil 
                                                       cancelButtonTitle:nil 
                                                       otherButtonTitles:kOkButtonText, nil];
        
        [errorAlertView show];
        
        return;
    }
    
    if ([self delegate]) {
        [[self delegate] conversationComposeViewController:self didFinishWithResult:YAComposeResultSent conversation:newConversation];
    }
}

- (void)messageComposeViewDidResizeFromFrame:(CGRect)originalFrame toFrame:(CGRect)newFrame
{
    CGFloat heightDiff = newFrame.size.height - originalFrame.size.height;
    CGRect messageComposeFrame = [messageComposeView_ frame];
    
    messageComposeFrame.origin.y -= heightDiff;
    
    // todo: move this into message compose after I commit to sync up with devdom
    //messageComposeFrame.size.height += heightDiff;
    
    [messageComposeView_ setFrame:messageComposeFrame];
}

- (void)clearSelectedToken
{
    [selectedToken_ setSelected:NO];
    [self setSelectedToken:nil];
}


# pragma mark ContactPickerViewControllerDelegate methods

- (void) contactPicker:(id<ContactPickerViewController>)contactPicker didPickContactEndpoints:(NSSet*)contactEndpoints
{
    [[contactPicker viewController] dismissModalViewControllerAnimated:YES];

    for(YAContactEndpoint* contactEndpoint in contactEndpoints)
    {
        YAParticipantInfo* participantInfo = [participantInfoCreator_ participantInfoWithContactEndpoint:contactEndpoint];
        [[self tokenView] addTokenFieldWithInfo:participantInfo];
    }
    [[self tokenView] setDisplayMode:YATokenViewDisplayTokens];
}

- (void) contactPickerDidCancel:(id<ContactPickerViewController>)contactPicker
{
    [[contactPicker viewController] dismissModalViewControllerAnimated:YES];
}


- (BOOL)messageComposeViewCanEnableSendButton
{
    return [self hasParticipants];
}

@end
