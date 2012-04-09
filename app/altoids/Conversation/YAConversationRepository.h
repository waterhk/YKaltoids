//
//  YAConversationRepository.h
//  altoids
//
//  Created by Jon Herron on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationGapDetector.h"
#import "ConversationHandler.h"
#import "ConversationListToDictionaryTransformer.h"
#import "ConversationLocator.h"
#import "ConversationRepository.h"
#import "ManagedObjectContextFactory.h"
#import "MessageDeleter.h"
#import "MessageGapPlaceholderClearer.h"
#import "MessageGapDetector.h"
#import "MessageHandler.h"
#import "MessageRepository.h"
#import "ParticipantRepository.h"
#import "ConversationCommandFactory.h"
#import "CommandQueue.h"
#import "MutableArrayCreator.h"
#import "ConversationGapPlaceholderClearer.h"
#import "ConversationDeleter.h"
#import "UserProfileRepository.h"
#import "RegistrationFetcher.h"
#import "ParticipantHandler.h"
#import "ConversationErrorCreator.h"
#import "ParticipantErrorCreator.h"
#import "MessageStatusUpdater.h"
#import "AddressMetaDataUpdater.h"

@protocol MessageCreator;

@interface YAConversationRepository : NSObject <ConversationRepository>

@property (strong, nonatomic) id<ConversationHandler> conversationHandler;
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) id<ParticipantRepository> participantRepository;
@property (strong, nonatomic) id<MessageRepository> messageRepository;
@property (strong, nonatomic) id<UserProfileRepository> userProfileRepository;
@property (strong, nonatomic) id<RegistrationFetcher> registrationFetcher;
@property (strong, nonatomic) id<ConversationCommandFactory> conversationCommandFactory;
@property (strong, nonatomic) id<CommandQueue> mmcCommandQueue;
@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;
@property (strong, nonatomic) id<ConversationLocator> conversationLocator;
@property (strong, nonatomic) id<ConversationGapPlaceholderClearer> conversationGapPlaceholderClearer;
@property (strong, nonatomic) id<ConversationListToDictionaryTransformer> conversationListToDictionaryTransformer;
@property (strong, nonatomic) id<ConversationGapDetector> conversationGapDetector;
@property (strong, nonatomic) id<ConversationDeleter> conversationDeleter;
@property (strong, nonatomic) id<MessageGapPlaceholderClearer> messageGapPlaceholderClearer;
@property (strong, nonatomic) id<MessageGapDetector> messageGapDetector;
@property (strong, nonatomic) id<MessageDeleter> messageDeleter;
@property (strong, nonatomic) id<MessageHandler> messageHandler;
@property (strong, nonatomic) id<MessageCreator> messageCreator;
@property (strong, nonatomic) id<ParticipantHandler> participantHandler;
@property (strong, nonatomic) id<ConversationErrorCreator> conversationErrorCreator;
@property (strong, nonatomic) id<ParticipantErrorCreator> participantErrorCreator;
@property (strong, nonatomic) id<MessageStatusUpdater> messageStatusUpdater;
@property (strong, nonatomic) id<AddressMetaDataUpdater> addressMetaDataUpdater;

- (YAConversation *)createConversationGapPlaceholderToFollowConversation:(YAConversation *)aConversation 
                                                  inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;


@end
