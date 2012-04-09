//
//  YAConversationMessageListTableViewDataSource.h
//  altoids
//
//  Created by Jon Herron on 2/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "ConversationMessageListTableViewDataSource.h"
#import "ConversationMessageListTableViewDataSourceDelegate.h"
#import "ContactRepositorySubscriber.h"
#import "MessageFailToSendDelegate.h"

@class YAConversation;

@protocol ConversationHandler;
@protocol ConversationRepository;
@protocol ManagedObjectContextFactory;
@protocol MessagePredicateCreator;
@protocol ParticipantHandler;
@protocol ConversationViewCellFactory;
@protocol RelativeDateFormatter;
@protocol Threader;
@protocol ContactRepository;
@protocol MessageDeleter;

@interface YAConversationMessageListTableViewDataSource : NSObject <ConversationMessageListTableViewDataSource, ContactRepositorySubscriber, MessageFailToSendDelegate>

- (id)initWithConversation:(YAConversation *)conversation delegate:(id<ConversationMessageListTableViewDataSourceDelegate>)delegate;

@property (strong, nonatomic) id<ConversationHandler> conversationHandler;
@property (strong, nonatomic) id<ConversationRepository> conversationRepository;
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) id<MessagePredicateCreator> messagePredicateCreator;
@property (strong, nonatomic) id<ParticipantHandler> participantHandler;
@property (strong, nonatomic) id<ConversationViewCellFactory> conversationViewCellFactory;
@property (strong, nonatomic) id<RelativeDateFormatter> relativeDateFormatter;
@property (strong, nonatomic) id<Threader> mainThreader;
@property (strong, nonatomic) id<ContactRepository> contactRepository;
@property (strong, nonatomic) id<MessageDeleter> messageDeleter;

@property (strong, nonatomic) NSArray *messageSortDescriptors;
@property (strong, nonatomic) NSNotificationCenter *notificationCenter;
@property (strong, nonatomic) NSPredicate *conversationClassPredicate;
@property (strong, nonatomic) NSPredicate *participantClassPredicate;

@end
