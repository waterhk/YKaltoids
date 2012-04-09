//
//  YAConversationMessageListTableViewDataSource.m
//  altoids
//
//  Created by Jon Herron on 2/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationMessageListTableViewDataSource.h"
#import "ConversationHandler.h"
#import "ConversationRepository.h"
#import "MessagePredicateCreator.h"
#import "MessageStatus.h"
#import "ParticipantHandler.h"
#import "YAMessage.h"
#import "YAParticipant.h"
#import "ConversationViewCellFactory.h"
#import "Threader.h"
#import "ContactRepository.h"
#import "MessageDeleter.h"

@interface YAConversationMessageListTableViewDataSource ()

@property (strong, nonatomic) NSArray *sortedConversationMessages;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectID *conversationObjectID;
@property (strong, nonatomic) YAConversation *conversation;
@property (strong, nonatomic) id<ConversationMessageListTableViewDataSourceDelegate> delegate;

- (void)managedObjectContextDidSave:(NSNotification *)notification;
- (BOOL)monitoredConversationIsEqualToConversation:(YAConversation *)conversation;
- (NSUInteger)numberOfMessagesInConversation;
- (void)sortConversationMessages;

@end

@implementation YAConversationMessageListTableViewDataSource

@synthesize conversation = conversation_;
@synthesize conversationClassPredicate = conversationClassPredicate_;
@synthesize conversationHandler = conversationHandler_;
@synthesize conversationObjectID = conversationObjectID_;
@synthesize conversationRepository = conversationRepository_;
@synthesize delegate = delegate_;
@synthesize managedObjectContext = managedObjectContext_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize messagePredicateCreator = messagePredicateCreator_;
@synthesize messageSortDescriptors = messageSortDescriptors_;
@synthesize notificationCenter = notificationCenter_;
@synthesize participantClassPredicate = participantClassPredicate_;
@synthesize participantHandler = participantHandler_;
@synthesize sortedConversationMessages = sortedConversationMessages_;
@synthesize conversationViewCellFactory = conversationViewCellFactory_;
@synthesize relativeDateFormatter = relativeDateFormatter_;
@synthesize mainThreader = mainThreader_;
@synthesize contactRepository = contactRepository_;
@synthesize messageDeleter = messageDeleter_;

- (id)initWithConversation:(YAConversation *)conversation delegate:(id<ConversationMessageListTableViewDataSourceDelegate>)delegate
{
    self = [super init];
    
    if (self) 
    {
        conversationObjectID_ = [conversation objectID];
        delegate_ = delegate;
    }
    
    return self;
}

- (void)dealloc
{
    [self setDelegate:nil];
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YAMessage *message = [self messageAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[self conversationViewCellFactory] cellReuseIdentifierForMessage:message]];
    if (!cell) {
        cell = (UITableViewCell *)[[self conversationViewCellFactory] createCellForMessage:message withDelegate:self];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section != 0)
    {
        return 0;
    }
    
    return [self numberOfMessagesInConversation];
}

#pragma mark -

- (id<CommandTransaction>)fetchMessagesForConversationWithTransactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate
{
    NSString *conversationID = [[self conversationHandler] conversationIDForConversation:[self conversation]];
    
    id<CommandTransaction> conversationViewCommand;
    if (conversationID) 
    {
        conversationViewCommand = [[self conversationRepository] loadMostRecentMessagesForConversation:[self conversation] transactionDelegate:transactionDelegate];
    }
    return conversationViewCommand;
}

- (NSIndexPath *)indexPathForMessage:(YAMessage *)message
{
    [self sortConversationMessages];
    
    NSArray *sortedConversationMessages = [self sortedConversationMessages];
    
    if ([sortedConversationMessages count] != [self numberOfMessagesInConversation])
    {
        return nil;
    }
    
    NSUInteger row = 0;
    
    for (YAMessage *msg in sortedConversationMessages) 
    {
        if (message == msg) 
        {
            return [NSIndexPath indexPathForRow:row inSection:0];
        }
        
        ++row;
    }
    
    return nil;
}

- (YAMessage *)messageAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self sortedConversationMessages] objectAtIndex:[indexPath row]];
}

- (void)load
{
    NSManagedObjectContext *context = [[self managedObjectContextFactory] createWithStalenessInterval:0];
    YAConversation *conversation = (YAConversation *)[context objectWithID:[self conversationObjectID]];
    
    [self setManagedObjectContext:context];
    [self setConversation:conversation];
    
    [self setManagedObjectContext:[[self conversation] managedObjectContext]];
    
    [self sortConversationMessages];
    
    [[self notificationCenter] addObserver:self selector:@selector(managedObjectContextDidSave:) name:NSManagedObjectContextDidSaveNotification object:nil];
    [contactRepository_ addSubscriber:self];
}

- (void)unload
{
    [contactRepository_ removeSubscriber:self];
    [[self notificationCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:nil];
    
    [self setConversation:nil];
    [self setManagedObjectContext:nil];
}

- (void)didReceiveMemoryWarning
{
}

- (void)managedObjectContextDidSave:(NSNotification *)notification
{    
    [[self managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
    
    BOOL messagesUpdated = NO;
    BOOL participantUpdated = NO;
    
    for (NSSet *changedObjects in [[notification userInfo] allValues]) 
    {
        if (!changedObjects)
        {
            continue;
        }
        
        if (!messagesUpdated) 
        {
            NSSet *updatedConversations = [changedObjects filteredSetUsingPredicate:[self conversationClassPredicate]];
            
            for (YAConversation *changedConversation in updatedConversations) 
            {
                messagesUpdated = [self monitoredConversationIsEqualToConversation:changedConversation];
                
                if (messagesUpdated) 
                {
                    [self sortConversationMessages];
                    
                    break;
                }
            }
        }
        
        if (!participantUpdated) 
        {
            NSSet *updatedParticipants = [changedObjects filteredSetUsingPredicate:[self participantClassPredicate]];
            
            for (YAParticipant *updatedParticipant in updatedParticipants) 
            {
                YAConversation *conversationForParticipant = [[self participantHandler] conversationForParticipant:updatedParticipant];
                
                participantUpdated = [self monitoredConversationIsEqualToConversation:conversationForParticipant];
                
                if (participantUpdated) 
                {
                    break;
                }
            }
        }
        
        if (messagesUpdated && participantUpdated) 
        {
            break;
        }
    }
    
    if (messagesUpdated) 
    {
        [mainThreader_ asyncPerformSelector:@selector(messagesDidUpdate) onTarget:delegate_];
    }
    
    if (participantUpdated) 
    {
        [mainThreader_ asyncPerformSelector:@selector(participantsDidUpdate) onTarget:delegate_];
    }
}

- (YAMessage *)lastMessage
{
    return [[self sortedConversationMessages] lastObject];
}

- (YAMessage *)oldestUnreadMessage
{
    NSArray *unreadMessages = [self unreadMessages];
    
    if ([unreadMessages count] == 0) 
    {
        return nil;
    }
    
    return [unreadMessages objectAtIndex:0];
}

- (NSArray *)unreadMessages
{
    return [[self sortedConversationMessages] filteredArrayUsingPredicate:[[self messagePredicateCreator] predicateMatchingUnreadMessages]];
}

- (void)sortConversationMessages
{
    NSSet *messages = [[self conversationHandler] messagesForConversation:[self conversation]];
    NSArray *sortedMessages = [messages sortedArrayUsingDescriptors:[self messageSortDescriptors]];
    
    [self setSortedConversationMessages:sortedMessages];
}

- (BOOL)monitoredConversationIsEqualToConversation:(YAConversation *)conversation
{
    return [[[conversation objectID] URIRepresentation] isEqual:[[self conversationObjectID] URIRepresentation]];
}

- (NSUInteger)numberOfMessagesInConversation
{
    return [[[self conversationHandler] messagesForConversation:[self conversation]] count];
}

- (void)contactRepositoryDidLoadContacts:(id<ContactRepository>)contactRepository
{
    [delegate_ contactsDidUpdate];
}

#pragma mark -
#pragma mark MessageFailToSendDelegate

- (void)didRequestToDeleteMessage:(YAMessage *)aMessage {
    NSError *error;
    BOOL deleteSucceeded = [[self messageDeleter] deleteMessage:aMessage inManagedObjectContext:[self managedObjectContext] error:&error];
    if (!deleteSucceeded || error) {
        YALogError(@"Failed to delete message: %@\n with Error: %@\n", aMessage, [error localizedDescription]);
    }
}

- (void)didRequestToResendMessage:(YAMessage *)aMessage {
    [[self conversationRepository] resendMessage:aMessage forConversation:[self conversation]];
    return;
}

@end
