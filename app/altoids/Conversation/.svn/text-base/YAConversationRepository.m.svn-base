//
//  YAConversationRepository.m
//  altoids
//
//  Created by Jon Herron on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ConversationCreateCommandDelegate.h"
#import "ConversationEditCommandDelegate.h"
#import "ConversationListCommandDelegate.h"
#import "ConversationMessageListCommandDelegate.h"
#import "ConversationReplyCommandDelegate.h"
#import "Command.h"
#import "TransactionCommand.h"
#import "TransactionCommandDelegate.h"
#import "ManagedObjectContextFactory.h"
#import "YAConversation.h"
#import "YAConversationInfo.h"
#import "YAConversationRepository.h"
#import "YAParticipantInfo.h"
#import "YASMSAddressInfo.h"
#import "YARegistrationInfo.h"
#import "YASessionLogger.h"
#import "MessageCreator.h"

#undef kYALogComponent
#define kYALogComponent lcl_cConversationRepository

@interface YAConversationRepository () <ConversationListCommandDelegate, ConversationCreateCommandDelegate, ConversationMessageListCommandDelegate, ConversationReplyCommandDelegate, ConversationEditCommandDelegate>

- (YAConversation *)createConversationFromConversationInfo:(YAConversationInfo *)aConversationInfo 
                                    inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (YAConversation *)createConversationWithSender:(YAParticipantInfo *)aSender 
                          inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (void)updateConversation:(YAConversation *)aConversation 
      fromConversationInfo:(YAConversationInfo *)aConversationInfo 
    inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (YAMessage *)messageGapPlaceHolderToFollowMessage:(YAMessage *)message 
                            messageInfosWithIdsOnly:(NSArray *)messageInfosWithIdsOnly 
                             inManagedObjectContext:(NSManagedObjectContext *)inManagedObjectContext;

- (NSSet *)messagesFromMessageInfos:(NSArray *)messageInfos 
                   existingMessages:(NSSet *)existingMessages 
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (void)appendConversationReplyCommandForConversation:(YAConversation *)aConversation withMessage:(YAMessage *)aMessage;
- (void)appendConversationCreateCommandForConversation:(YAConversation *)aConversation;

- (BOOL)setParticipants:(NSArray *)anArrayOfParticipantInfo forConversation:(YAConversation *)aConversation error:(NSError **)anError;
- (void)setMessageBody:(NSString *)aMessageBody forConversation:(YAConversation *)aConversation;

@end

@implementation YAConversationRepository

@synthesize conversationHandler = conversationHandler_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize participantRepository = participantRepository_;
@synthesize messageRepository = messageRepository_;
@synthesize userProfileRepository = userProfileRepository_;
@synthesize registrationFetcher = registrationFetcher_;
@synthesize conversationCommandFactory = conversationCommandFactory_;
@synthesize mmcCommandQueue = mmcCommandQueue_;
@synthesize mutableArrayCreator = mutableArrayCreator_;
@synthesize conversationLocator = conversationLocator_;
@synthesize conversationGapPlaceholderClearer = conversationGapPlaceholderClearer_;
@synthesize conversationListToDictionaryTransformer = conversationListToDictionaryTransformer_;
@synthesize conversationGapDetector = conversationGapDetector_;
@synthesize conversationDeleter = conversationDeleter_;
@synthesize messageGapPlaceholderClearer = messageGapPlaceholderClearer_;
@synthesize messageGapDetector = messageGapDetector_;
@synthesize messageDeleter = messageDeleter_;
@synthesize messageHandler = messageHandler_;
@synthesize messageCreator = messageCreator_;
@synthesize participantHandler = participantHandler_;
@synthesize conversationErrorCreator = conversationErrorCreator_;
@synthesize participantErrorCreator = participantErrorCreator_;
@synthesize messageStatusUpdater = messageStatusUpdater_;
@synthesize addressMetaDataUpdater = addressMetaDataUpdater_;

#pragma mark -

- (YAConversation *)createConversationWithSender:(YAParticipantInfo *)aSender 
                                    participants:(NSArray *)aParticipants 
                                     messageBody:(NSString *)aMessageBody 
                                           error:(NSError **)aError
{
    //TODO: should return a Conv. Repo. specific error back to the client through aError argument
    
    NSManagedObjectContext *managedObjectContext = [[self managedObjectContextFactory] create];
    YAConversation *newConversation = [self createConversationWithSender:aSender inManagedObjectContext:managedObjectContext];
    
    [[self conversationHandler] setStatusAsPendingForConversation:newConversation];  
    [[self conversationHandler] setTimestamp:[NSDate date] forConversation:newConversation];
    
    NSError *setParticipantError = nil;
    [self setParticipants:aParticipants forConversation:newConversation error:&setParticipantError];
    if (setParticipantError) {
        YALogError(@"Error： %@\n when setting participants: %@\nfor Conversation: %@\n", [setParticipantError localizedDescription], aParticipants, newConversation);
        return nil;
    }
    
    [self setMessageBody:aMessageBody forConversation:newConversation];

    NSError *saveConversationError = nil;
    [[self conversationHandler] save:newConversation inManagedObjectContext:[newConversation managedObjectContext] error:&saveConversationError];
    if (saveConversationError) {
        YALogError(@"Error: %@\n when saving conversation: %@\n in ManagedObjectContext.", [saveConversationError localizedDescription], newConversation);
        return nil;
    }
    
    [self appendConversationCreateCommandForConversation:newConversation];
    
    return newConversation;
}

- (BOOL)mergeParticipants:(NSArray *)anArrayOfParticipantInfo forConversation:(YAConversation *)aConversation withParticipantIDMap:(NSDictionary *)theParticipantIDMap error:(NSError **)anError
{
    NSParameterAssert(anError);
    
    NSError *error;
    NSSet *participants = [[self participantRepository] mergeParticipants:anArrayOfParticipantInfo withExistingParticipants:[[self conversationHandler] participantsForConversation:aConversation] usingParticipantIDMap:theParticipantIDMap inManagedObjectContext:[aConversation managedObjectContext] error:&error];
    
    if (!participants) 
    {
        *anError = [[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToUpdateParticipantsInConversation underlyingError:error];
        
        return NO;
    }
    
    [[self conversationHandler] setParticipants:participants forConversation:aConversation];
    
    YALogTrace(@"Merged participants for conversation\n%@\n",aConversation);
    
    return YES;
}

- (void)markUnreadMessagesAsRead:(NSArray *)unreadMessages forConversation:(YAConversation *)aConversation
{
    if ([[self conversationHandler] conversationCreatedOnServer:aConversation]) {
        [[self messageStatusUpdater] markMesssageAsRead:unreadMessages forConversation:aConversation];
    }
}

- (void)deleteAllConversations
{
    BOOL didDeleteAllConversations;
    NSError *error;
    
    // this call is currently only used for dev testing, so the error is not indirectly returned to 
    // the caller. The error returned is also the raw error returned while trying to fetch or save 
    // conversation entities.
    
    didDeleteAllConversations = [[self conversationDeleter] deleteAllConversationsInManagedObjectContext:[[self managedObjectContextFactory] create] error:&error];

    if (!didDeleteAllConversations) 
    {
        YALogError(@"Unable to delete all conversations: %@", [error localizedDescription]);
    }
    else
    {
        YALogDebug(@"Deleted all conversations from local storage");
    }
}

- (void)deleteAllMessagesInConversation:(YAConversation *)theConversation
{
    BOOL didDeleteAllMessagesInConversation;
    NSError *error;
    NSManagedObjectContext *managedObjectContext = [[self managedObjectContextFactory] create];
    NSString *conversationID = [[self conversationHandler] conversationIDForConversation:theConversation];
    
    // this call is currently only used for dev testing, so the error is not indirectly returned to
    // the caller.
    
    didDeleteAllMessagesInConversation = [[self messageRepository] deleteAllMessagesInConversationWithID:conversationID inManagedObjectContext:managedObjectContext error:&error];
    
    if (!didDeleteAllMessagesInConversation) 
    {
        YALogError(@"Unable to delete all messages in conversation (%@): %@", conversationID, [error localizedDescription]);
    }
    else
    {
        YALogDebug(@"Deleted all messages in conversation\n%@\n",theConversation);
    }
}

- (id<CommandTransaction>)loadMostRecentConversationsWithTransactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate
{
    id<TransactionCommand> conversationListCommand = [[self conversationCommandFactory] conversationListCommandForMostRecentConversationsWithDelegate:self transactionDelegate:transactionDelegate];
    
    [[self mmcCommandQueue] append:conversationListCommand];
    return [conversationListCommand transaction];
}

- (void)loadConversationsAfterConversation:(YAConversation *)theConversation
{
    id<Command> conversationListCommand = [[self conversationCommandFactory] conversationListCommandForConversationsAfterConversation:theConversation withDelegate:self];
    
    [[self mmcCommandQueue] append:conversationListCommand];
}

- (id<CommandTransaction>)loadMostRecentMessagesForConversation:(YAConversation *)theConversation transactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate
{
    id<TransactionCommand> conversationMessageListCommand = [[self conversationCommandFactory] conversationMessageListCommandForMostRecentMessagesInConversation:theConversation 
                                                                                                                                                    withDelegate:self
                                                                                                                                             transactionDelegate:transactionDelegate];
    
    [[self mmcCommandQueue] append:conversationMessageListCommand];
    return [conversationMessageListCommand transaction];
}

- (void)loadMessagesForConversation:(YAConversation *)theConversation afterMessage:(YAMessage *)theMessage
{
    id<Command> conversationMessageListCommand = [[self conversationCommandFactory] conversationMessageListCommandForMessagesAfterMessage:theMessage inConversation:theConversation withDelegate:self];
    
    [[self mmcCommandQueue] append:conversationMessageListCommand];
}

- (BOOL)replyToConversation:(YAConversation *)aConversation messageBody:(NSString *)aMessageBody error:(NSError **)aError
{
    // todo: handle these errors when doing conversation error handling
    
    NSError *userProfileError = nil;
    YAUser *currentUser = [[self userProfileRepository] fetchCurrentUserProfileWithError:&userProfileError];
    NSAssert(currentUser != nil, @"current user not found");
    
    NSArray *participants = [[aConversation participants] allObjects];
    YAParticipant *sender = nil;
    
    for (YAParticipant *participant in participants) {
        if ([[participant isUser] boolValue]) {
            sender = participant;
            break;
        }
    }

    if (!sender) {
        NSError *registrationError = nil;
        YARegistrationInfo *registrationInfo = [[self registrationFetcher] fetchRegistrationInfoInManagedObjectContext:[aConversation managedObjectContext] error:&registrationError];
        
        YALogError(@"Error:\nCould not find current user\n%@\nwith registration info\n%@\nin participants\n%@\n",
                   currentUser,
                   registrationInfo,
                   [participants componentsJoinedByString:@"\n"]);
        
        *aError = [[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToReplyToConversation 
                                       underlyingError:[[self participantErrorCreator] errorWithCode:YAParticipantErrorCodeFailedToFindUserInParticipantList]];
        
        return NO;        
    }
    
    //TODO: delete this line? since it will never be reached if sender is nil, because of the if above
    NSAssert(sender != nil, @"User \"%@ %@\" is not in the participant list",[currentUser firstName],[currentUser lastName]);
    
    YAMessage *message = [[self messageCreator] createMessageForReplyingToConversation:aConversation withMessageBody:aMessageBody sender:sender];
    
    [[self conversationHandler] addMessage:message toConversation:aConversation];
    [[self conversationHandler] setTimestamp:[message timestamp] forConversation:aConversation];
    [[self conversationHandler] setMostRecentMessage:message forConversation:aConversation];
    
    BOOL didSaveConversation = [[self conversationHandler] save:aConversation inManagedObjectContext:[aConversation managedObjectContext] error:aError];
    
    if (!didSaveConversation) 
    {
        YALogError(@"Error:\n%@\nCould not save conversation\n%@\n",
                   [*aError localizedDescription],
                   aConversation);

        return NO;
    }
    
    [self appendConversationReplyCommandForConversation:aConversation withMessage:message];
    
    YALogInfo(@"Replied to conversation\n%@\nwith message\n%@\n",
              aConversation,
              message);
    
    return YES;
}

- (void)resendMessage:(YAMessage *)aMessage forConversation:(YAConversation *)aConversation
{
    BOOL converationFailedToSaveOnServer = ![aConversation conversationID];
    if (converationFailedToSaveOnServer) {
        [self appendConversationCreateCommandForConversation:aConversation];
        YALogInfo(@"Retry to create the conversation\n%@\nwith message\n%@\n", aConversation, aMessage);
    } else {
        [self appendConversationReplyCommandForConversation:aConversation withMessage:aMessage];
        YALogInfo(@"Resend a reply to conversation\n%@\nwith message\n%@\n", aConversation, aMessage);
    }
}

- (void)appendConversationReplyCommandForConversation:(YAConversation *)aConversation withMessage:(YAMessage *)aMessage
{
    id<Command> conversationReplyCommand = [[self conversationCommandFactory] conversationReplyCommandForConversation:aConversation 
                                                                                                          withMessage:aMessage 
                                                                                                         withDelegate:self];
    [[self mmcCommandQueue] append:conversationReplyCommand];
}

- (void)removeParticipant:(YAParticipant *)theParticipant fromConversation:(YAConversation *)theConversation withViewForOverlay:(UIView *)theView
{
    id<Command> removeParticipantCommand = [[self conversationCommandFactory] conversationEditCommandForConversation:theConversation withAdditionalParticipants:nil removedParticipants:[NSArray arrayWithObject:theParticipant] withViewForOverlay:theView withDelegate:self];
    
    [[self mmcCommandQueue] append:removeParticipantCommand];
    
    YALogInfo(@"Queued command to remove participant\n%@\nfrom conversation\n%@\n",
              theParticipant,
              theConversation);
}

- (BOOL)addParticipant:(YAParticipantInfo *)theParticipant toConversation:(YAConversation *)theConversation withViewForOverlay:(UIView*)theView error:(NSError **)anError
{
    NSParameterAssert(anError);
    
    id<Command> addParticipantCommand;
    NSError *error;
    NSManagedObjectContext *managedObjectContext;
    YAParticipant *participant;
    
    managedObjectContext = [[self managedObjectContextFactory] create];
    
    participant = [[self participantRepository] createParticipantFromParticipantInfo:theParticipant inManagedObjectContext:managedObjectContext error:&error];
    
    YARegistrationInfo *registrationInfo = [[self registrationFetcher] fetchRegistrationInfoInManagedObjectContext:managedObjectContext error:&error];
    NSString *participantHandle = [participant valueForKeyPath:@"address.handle"];
    
    if ([[registrationInfo phoneNumber] isEqualToString:participantHandle]) {
        error = [[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToAddParticipantToConversation];
        
        YALogError(@"Error:\n%@\nCould not add participant %@ to conversation",
                   [error localizedDescription],
                   participant);
        
        return NO;
    }
    
    if (!participant) 
    {
        *anError = [[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToAddParticipantToConversation underlyingError:error];
        
        return NO;
    }
    
    addParticipantCommand = [[self conversationCommandFactory] conversationEditCommandForConversation:theConversation withAdditionalParticipants:[NSArray arrayWithObject:participant] removedParticipants:nil withViewForOverlay:theView withDelegate:self];
    
    [[self mmcCommandQueue] append:addParticipantCommand];

    YALogInfo(@"Queued command to add participant\n%@\nfrom conversation\n%@\n",
              theParticipant,
              theConversation);
    
    return YES;
}

#pragma mark -
#pragma mark ConversationListCommandDelegate delegate methods

- (void)conversationListRecieved:(NSArray *)aConversationsList conversationIDs:(NSArray *)anArrayOfConversationIDs moreConversationsPresentOnServer:(BOOL)aMoreConversationsPresentOnServer
{
    NSUInteger conversationsCount = [aConversationsList count];
    YALogInfo(@"Received %d conversations", conversationsCount);
    YASessionLogDebug(@"Received %d conversations", conversationsCount);
    if (conversationsCount == 0) 
    {
        return;
    }
    
    YALogDebug(@"Conversations \n%@\n",
               [aConversationsList componentsJoinedByString:@"\n"]);
    
    NSManagedObjectContext *managedObjectContext = [[self managedObjectContextFactory] create];
    
    NSUInteger possibleConversationGapPlaceholders = 1;
    NSMutableArray *conversations = [[self mutableArrayCreator] mutableArrayWithCapacity:conversationsCount + possibleConversationGapPlaceholders];
    
    NSArray *existingConversations = [[self conversationLocator] conversationsWithIDs:anArrayOfConversationIDs inManagedObjectContext:managedObjectContext];
    
    existingConversations = [[self conversationGapPlaceholderClearer] clearConversationGapPlaceholdersInListOfConversations:existingConversations inManagedObjectContext:managedObjectContext moreConversationsPresentOnServer:aMoreConversationsPresentOnServer];
    
    NSDictionary *existingConversationsByID = [[self conversationListToDictionaryTransformer] transformConversationListToDictionary:existingConversations];
    
    for (YAConversationInfo *conversationInfo in aConversationsList) 
    {
        if ([conversationInfo totalMessages] == 0)
        {
            YALogTrace(@"Skipping\n%@\n because it has zero messages",
                       conversationInfo);
            continue;
        }
        
        YAConversation *conversationEntity = [existingConversationsByID objectForKey:[conversationInfo conversationID]];
        if (conversationEntity)
        {
            YALogTrace(@"Found existing conversation to update from mmc\n\t%@", [conversationInfo conversationID]);
            
            if (![[self conversationHandler] conversationIsGapPlaceholder:conversationEntity]) 
            {
                [self updateConversation:conversationEntity fromConversationInfo:conversationInfo inManagedObjectContext:managedObjectContext];
            }
            else
            {
                YALogTrace(@"Above conversation is an existing gap, skipping the update");
            }
        }
        else
        {
            YALogTrace(@"Found new conversation to add from mmc: %@", [conversationInfo conversationID]);
            
            conversationEntity = [self createConversationFromConversationInfo:conversationInfo inManagedObjectContext:managedObjectContext];
        }
        
        [conversations addObject:conversationEntity];
    }
    
    YAConversation *conversationBeforeGap = [[self conversationGapDetector] detectConversationImmediatelyBeforePossibleGapInConversationList:conversations consideringExistingConversations:existingConversationsByID realizingMoreConversationsExistOnTheServer:aMoreConversationsPresentOnServer];
    
    if (conversationBeforeGap) 
    {
        YALogTrace(@"Conversation ID before gap is: %@", [conversationBeforeGap conversationID]);
        
        YAConversation *conversationGapPlaceholder = [self createConversationGapPlaceholderToFollowConversation:conversationBeforeGap inManagedObjectContext:managedObjectContext];
        
        [conversations addObject:conversationGapPlaceholder];
    }
    
    [[self addressMetaDataUpdater] updateAddressMetaDataForParticipantInfosInConversationInfos:aConversationsList inManagedObjectContext:managedObjectContext];
    
    NSError *error = nil;
    [[self conversationHandler] saveConversations:conversations inManagedObjectContext:managedObjectContext error:&error];
    
    if (error) 
    {
        YALogError(@"Error:\n%@\nCould not save conversations\n%@\n", 
                   [error localizedDescription],
                   [conversations componentsJoinedByString:@"\n"]);
    }
}

#pragma mark -
#pragma mark ConversationCreateCommandDelegate delegate methods

- (void)conversationCreated:(YAConversationInfo *)theConversation fromLocalConversationWithObjectID:(NSManagedObjectID *)theObjectID
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [[self managedObjectContextFactory] create];
    YAConversation *localConversation = nil;
    
    if (!(localConversation = (YAConversation *)[managedObjectContext objectWithID:theObjectID]))
    {
        YALogError(@"Unable to retrieve local conversation from context\n%@\n using objectID\n%@\n",
                   managedObjectContext,
                   theObjectID);
        
        return;
    }
    
    [self updateConversation:localConversation fromConversationInfo:theConversation inManagedObjectContext:managedObjectContext];
    
    [[self conversationHandler] save:localConversation inManagedObjectContext:managedObjectContext error:&error];
    
    if (error) 
    {
        YALogError(@"Error:\n%@\nCould not save newly created conversation\n%@\n",
                   [error localizedDescription],
                   localConversation);
    }
}

#pragma mark -
#pragma mark ConversationMessageListCommandDelegate delegate methods

- (void)messageListRecievedForConversation:(YAConversationInfo *)theConversation
{
    if (![[theConversation messageInfos] count]) {
        YALogDebug(@"Conversation has no messages\n%@\n",
                   theConversation);
        return;
    }
    
    NSString *conversationID = [theConversation conversationID];
    NSManagedObjectContext *managedObjectContext = [[self managedObjectContextFactory] create];
    YAConversation *localConversation = [[self conversationLocator] conversationWithID:conversationID inManagedObjectContext:managedObjectContext];
    
    NSSet *existingMessages = [localConversation messages];
    
    existingMessages = [[self messageGapPlaceholderClearer] messagesWithGapPlaceholderRemovedInMessages:existingMessages managedObjectContext:managedObjectContext];
    
    NSInteger messageInfoCount = [[theConversation messageInfos] count];
    NSMutableArray *infosWithCompleteMessage = [[self mutableArrayCreator] mutableArrayWithCapacity:messageInfoCount];
    NSMutableArray *infosWithMessageIdOnly = [[self mutableArrayCreator] mutableArrayWithCapacity:messageInfoCount];
    
    [[theConversation messageInfos] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        YAMessageInfo *messageInfo = obj;
        if (![messageInfo isMessageIdOnly]) {
            [infosWithCompleteMessage addObject:messageInfo];
        } else {
            [infosWithMessageIdOnly addObject:messageInfo];
        }
    }
    ];
    
    YALogInfo(@"Found %d messages\n\tand %d gaps",
               [infosWithCompleteMessage count],
               [infosWithMessageIdOnly count]);

    NSSet *newMessages = [self messagesFromMessageInfos:infosWithCompleteMessage existingMessages:existingMessages managedObjectContext:managedObjectContext];
    
    YAMessage *messageBeforeGap = [[self messageGapDetector] messageImmediatelyBeforePossibleGapWithExistingMessages:existingMessages
                                                                                                          newMessages:newMessages
                                                                                              messageInfosWithIdOnly:infosWithMessageIdOnly];
    
    if (messageBeforeGap) {        
        YAMessage *messageGapPlaceholder = [self messageGapPlaceHolderToFollowMessage:messageBeforeGap messageInfosWithIdsOnly:infosWithMessageIdOnly
                                                               inManagedObjectContext:managedObjectContext];
        [[self conversationHandler] addMessage:messageGapPlaceholder toConversation:localConversation];
        
        YALogInfo(@"Added message place holder\n%@\n",messageGapPlaceholder);
    }
    
    // Delete any temp messages that were created in order to create the gap place holder
    // The actual messages will be created and associated with the conversation in updateConversation:fromConversationInfo:inManagedObjectContext:
    // below.
    for (YAMessage *tempMessage in newMessages) {
        [[self messageHandler] deleteMessage:tempMessage inManagedObjectContext:managedObjectContext];
    }
    
    NSError *error = nil;
    
    [self updateConversation:localConversation fromConversationInfo:theConversation inManagedObjectContext:managedObjectContext];
    
    [[self conversationHandler] save:localConversation inManagedObjectContext:managedObjectContext error:&error];
    
    if (error) 
    {
        YALogError(@"Error:\n%@\nCould not save conversation\n%@\n",
                   [error localizedDescription],
                   localConversation);
    }
}

#pragma mark -
#pragma mark ConversationEditCommandDelegate methods

- (void)conversationEditProducedUpatedConversationInfo:(YAConversationInfo *)theUpdatedConversationInfo fromExistingConversation:(YAConversation *)theExistingConversation
{
    NSError *error;
    NSManagedObjectContext *managedObjectContext = [theExistingConversation managedObjectContext]; //[[self managedObjectContextFactory] create];
    
    // this hack of manual pid management is required because the server response for edit conversation does not indicate which user isYou. 
    NSSet *participants = [[self conversationHandler] participantsForConversation:theExistingConversation];
    NSString *pidForCurrentUser;
    
    for (YAParticipant *participant in participants) 
    {
        if ([[self participantHandler] participantIsUser:participant]) 
        {
            pidForCurrentUser = [[self participantHandler] participantIDForParticipant:participant];
            
            break;
        }
    }
    
    [self updateConversation:theExistingConversation fromConversationInfo:theUpdatedConversationInfo inManagedObjectContext:managedObjectContext];
    
    participants = [[self conversationHandler] participantsForConversation:theExistingConversation];
    
    for (YAParticipant *participant in participants) 
    {
        if ([[[self participantHandler] participantIDForParticipant:participant] isEqualToString:pidForCurrentUser]) 
        {
            YALogInfo(@"Resetting isUser flag after matching pidForCurrentUser\n%@\nwith participant\n%@\n",
                       pidForCurrentUser,
                       participant);
            
            [[self participantHandler] setIsUser:YES forParticipant:participant];
            
            break;
        }
    }
    
    [[self addressMetaDataUpdater] updateAddressMetaDataForParticipantInfosInConversationInfo:theUpdatedConversationInfo inManagedObjectContext:managedObjectContext];
    
    [[self conversationHandler] save:theExistingConversation inManagedObjectContext:managedObjectContext error:&error];
    
    if (error) 
    {
        YALogError(@"Error:\n%@\nCould not save updated conversation\n%@\n",
                   [error localizedDescription],
                   theExistingConversation);
    }
}

#pragma mark -
#pragma mark Private methods

- (YAConversation *)createConversationFromConversationInfo:(YAConversationInfo *)aConversationInfo inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext
{
    YAConversation *conversation = nil;
    
    conversation = [self createConversationWithSender:[aConversationInfo sender] inManagedObjectContext:aManagedObjectContext];
    
    [self updateConversation:conversation fromConversationInfo:aConversationInfo inManagedObjectContext:aManagedObjectContext];
        
    return conversation;
}

- (YAConversation *)createConversationGapPlaceholderToFollowConversation:(YAConversation *)aConversation inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext
{
    NSString *conversationID = [[self conversationHandler] conversationIDForConversation:aConversation];
    YAConversation *conversationGapPlaceholder = [[self conversationHandler] createConversationEntityInManagedObjectContext:aManagedObjectContext];
    YAMessage *mostRecentMessage = [[self conversationHandler] mostRecentMessageForConversation:aConversation];
    YAMessage *mostRecentMessageCopy = [messageHandler_ createMessageEntityInManagedObjectContext:aManagedObjectContext];
    
    [messageHandler_ setMessageID:[messageHandler_ messageIDForMessage:mostRecentMessage] forMessage:mostRecentMessageCopy];
    [messageHandler_ setTimestamp:[messageHandler_ timestampForMessage:mostRecentMessage] forMessage:mostRecentMessageCopy];
    
    [[self conversationHandler] setStatusAsGapPlaceholderForConversation:conversationGapPlaceholder];
    [[self conversationHandler] setConversationID:conversationID forConversation:conversationGapPlaceholder];
    [[self conversationHandler] setMostRecentMessage:mostRecentMessageCopy forConversation:conversationGapPlaceholder];
    
    return conversationGapPlaceholder;
}

- (YAConversation *)createConversationWithSender:(YAParticipantInfo *)aSender inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext
{
    NSError *error;
    YAConversation *conversation = [[self conversationHandler] createConversationEntityInManagedObjectContext:aManagedObjectContext];
    
    if (aSender) {
        YAParticipant *sender = [[self participantRepository] createParticipantFromParticipantInfo:aSender inManagedObjectContext:aManagedObjectContext error:&error];
        
        if (!sender) 
        {
            // todo: set as underlying error when doing conversation error handling
            
            return nil;
        }
        
        [[self conversationHandler] setParticipantAsSender:sender forConversation:conversation];
    }
    
    [[self conversationHandler] setStatusAsNewForConversation:conversation];
    [[self conversationHandler] setIsMuted:NO forConversation:conversation];
    
    return conversation;
}

- (void)updateConversation:(YAConversation *)aConversation fromConversationInfo:(YAConversationInfo *)aConversationInfo inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext
{
    NSError *error = nil;
    YAParticipant *sender = nil;

    BOOL isNewConversation = [[self conversationHandler] conversationStatusIsPending:aConversation];
    
    [[self conversationHandler] setConversationID:[aConversationInfo conversationID] forConversation:aConversation];
    [[self conversationHandler] setStatus:[aConversationInfo status] forConversation:aConversation];
    [[self conversationHandler] setTotalMessages:[aConversationInfo totalMessages] forConversation:aConversation];
    [[self conversationHandler] setUnreadMessages:[aConversationInfo unreadMessages] forConversation:aConversation];
    
    if ([aConversationInfo topic]) 
    {
        [[self conversationHandler] setTopic:[aConversationInfo topic] forConversation:aConversation];
    }
    
    if ([aConversationInfo timestamp]) 
    {
        [[self conversationHandler] setTimestamp:[aConversationInfo timestamp] forConversation:aConversation];
    }
    
    if ([aConversationInfo mostRecentMessageInfo]) 
    {
        YAMessage *currentMostRecentMessage = [aConversation mostRecentMessage];
        if (!currentMostRecentMessage || (![[currentMostRecentMessage messageID] isEqualToString:[[aConversationInfo mostRecentMessageInfo] messageID]] && [[[aConversationInfo mostRecentMessageInfo] timestamp] timeIntervalSinceDate:[currentMostRecentMessage timestamp]] > 0)) {
            
            YAMessage *newMostRecentMessage = [[self messageRepository] createMessageFromMessageInfo:[aConversationInfo mostRecentMessageInfo] 
                                                                inManagedObjectContext:aManagedObjectContext 
                                                                                 error:&error];            
            if (!newMostRecentMessage) 
            {
                // todo: set as underlying error when doing conversation error handling
                return;
            }
            
            [[self conversationHandler] setMostRecentMessage:newMostRecentMessage forConversation:aConversation];            
        }        
    }
    
    if ([[aConversationInfo participantInfos] count] > 0) 
    {
        if ([aConversationInfo participantInfosByTransientID]) 
        {
            [self mergeParticipants:[aConversationInfo participantInfos] forConversation:aConversation withParticipantIDMap:[aConversationInfo participantInfosByTransientID] error:&error];
        }
        else
        {
            [self setParticipants:[aConversationInfo participantInfos] forConversation:aConversation error:&error];
        }
        
        if (error) 
        {
            YALogError(@"Error:\n%@\nCould not set participants for conversation\n%@\n",
                       [error localizedDescription],
                       aConversation);
            
            [[self conversationHandler] setParticipants:nil forConversation:aConversation];
        }
    }
    
    if ([aConversationInfo sender]) 
    {
        sender = [[self participantRepository] createParticipantFromParticipantInfo:[aConversationInfo sender] inManagedObjectContext:aManagedObjectContext error:&error];
        
        if (!sender)
        {
            // todo: set as underlying error when doing conversation error handling
            YALogError(@"Could not create participant from participant info\n%@\n",
                       [aConversationInfo sender]);
            return;
        }
        
        [[self conversationHandler] setParticipantAsSender:sender forConversation:aConversation];
    }
    
    NSSet *existingMessages = [aConversation messages];

    if (!isNewConversation) {        
        
        if ([[aConversationInfo messageInfos] count] > 0) 
        {
            NSSet *newMessages = [self messagesFromMessageInfos:[aConversationInfo messageInfos] 
                                               existingMessages:existingMessages
                                           managedObjectContext:aManagedObjectContext];
            if ([newMessages count]) {
                [[self conversationHandler] addMessages:newMessages toConversation:aConversation];
            }
        }
    } else {
        // For conversation creation, update the message id, timestamp and participant
        // Note: Participant needs to be updated to ensure that we have the proper profile
        // URL, isYou flag, etc...
        YAMessage *firstMessageInConversation = [[existingMessages allObjects] objectAtIndex:0];
        YAMessageInfo *updatedMessageInfo = [aConversationInfo mostRecentMessageInfo];
        
        NSAssert(firstMessageInConversation, @"No message found for conversation");
        NSAssert(updatedMessageInfo, @"No message info found for conversation info");
        
        [[self messageHandler] setMessageID:[updatedMessageInfo messageID] forMessage:firstMessageInConversation];
        [[self messageHandler] setTimestamp:[updatedMessageInfo timestamp] forMessage:firstMessageInConversation];
        [[self messageHandler] setParticipantAsSender:[aConversation sender] ofMessage:firstMessageInConversation];
        [[self messageHandler] setStatusAsSavedForMessage:firstMessageInConversation];
    }
    
    YALogTrace(@"Updated conversation\n%@\nwith conversation info\n%@\n",
               aConversation,
               aConversationInfo);
}

- (NSSet *)messagesFromMessageInfos:(NSArray *)messageInfos existingMessages:(NSSet *)existingMessages
                                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSMutableSet *newMessages = [NSMutableSet setWithCapacity:[messageInfos count]];
    
    [messageInfos enumerateObjectsUsingBlock:^(id messageInfo, NSUInteger idx, BOOL *stop) {
        __block BOOL isExistingMessage = NO;
        [existingMessages enumerateObjectsUsingBlock:^(id message, BOOL *stop) {
            if ([[[self messageHandler] messageIDForMessage:message] isEqualToString:[messageInfo messageID]]) {
                isExistingMessage = YES;
                *stop = YES;
            }
        }];
        
        if (isExistingMessage == NO) {
            NSError *error;
            YAMessage *newMessage = [[self messageRepository] createMessageFromMessageInfo:messageInfo inManagedObjectContext:managedObjectContext error:&error];
            
            if (!newMessage) 
            {
                // todo: revist when handling conversation errors
                *stop = YES;
                return;
            }
            
            [newMessages addObject:newMessage];
        }
    }];
    
    YALogDebug(@"Created %d messages\n%@\nfrom message infos\n%@\n",
               [newMessages count],
               newMessages,
               messageInfos);
    
    return newMessages;
}

- (void)repliedToConversationWithMessage:(YAMessage *)message conversationReplyInfo:(YAConversationReplyInfo *)replyInfo
{
    NSManagedObjectContext *managedObjectContext = [message managedObjectContext];
    
    NSString *messageID = [replyInfo messageId];
    NSDate *timestamp = [replyInfo date];
    
    [[self messageHandler] setMessageID:messageID forMessage:message];
    [[self messageHandler] setTimestamp:timestamp forMessage:message];
    [[self messageHandler] setStatusAsSavedForMessage:message];
    
    [[self conversationHandler] setTimestamp:[message timestamp] forConversation:[message conversation]];
    
    NSError *error;
    [managedObjectContext save:&error];
    
    if (error) {
        YALogError(@"Error:\n%@\nCould not save message\n%@\n",
                   [error localizedDescription],
                   message);
        return;
    }
    
    YALogDebug(@"Updated message ID to %@\n\tand timestamp to %@\nfor message\n%@\n",
               [replyInfo messageId],
               [replyInfo date],
               message);
}

- (YAMessage *)messageGapPlaceHolderToFollowMessage:(YAMessage *)message messageInfosWithIdsOnly:(NSArray *)messageInfosWithIdsOnly
                             inManagedObjectContext:(NSManagedObjectContext *)inManagedObjectContext
{
    NSError *error;
    YAMessage *messageGapPlaceholder = [[self messageRepository] createMessageFromMessageInfo:[messageInfosWithIdsOnly objectAtIndex:0]
                                                                       inManagedObjectContext:inManagedObjectContext error:&error];
    
    
    if (!messageGapPlaceholder) 
    {
        // todo: handle when making pass at conversation repo for error handling
        
        return nil;
    }
    
    [messageGapPlaceholder setTimestamp:[message timestamp]];
    
    YALogDebug(@"Created message gap place holder\n%@\nafter message\n%@\n",
               messageGapPlaceholder,
               message);
    
    return messageGapPlaceholder;
}

- (BOOL)setParticipants:(NSArray *)anArrayOfParticipantInfo forConversation:(YAConversation *)aConversation error:(NSError **)anError
{
    NSParameterAssert(anArrayOfParticipantInfo);
    NSParameterAssert(aConversation);
    NSParameterAssert(anError);
    
    NSError *error;
    NSSet *participants = [[self participantRepository] createParticipantsFromArrayOfParticipantInfo:anArrayOfParticipantInfo inManagedObjectContext:[aConversation managedObjectContext] error:&error];
    
    if (!participants) 
    {
        *anError = [[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToAddParticipantsToConversation underlyingError:error];
        
        return NO;
    }
    
    [[self conversationHandler] setParticipants:participants forConversation:aConversation];
    
    YALogTrace(@"Set participants for conversation\n%@\n",aConversation);
    
    return YES;
}

- (void)setMessageBody:(NSString *)aMessageBody forConversation:(YAConversation *)aConversation
{
    NSParameterAssert(aMessageBody);
    NSParameterAssert(aConversation);
    
    YAMessage *message = [[self messageCreator] createMessageForNewConversation:aConversation withMessageBody:aMessageBody];
    
    [[self conversationHandler] addMessage:message toConversation:aConversation];
    [[self conversationHandler] setMostRecentMessage:message forConversation:aConversation];
}

- (void)appendConversationCreateCommandForConversation:(YAConversation *)aConversation
{
    id<Command> command = [[self conversationCommandFactory] conversationCreateCommandForConversation:aConversation withDelegate:self];
    
    [[self mmcCommandQueue] append:command];
}

@end
