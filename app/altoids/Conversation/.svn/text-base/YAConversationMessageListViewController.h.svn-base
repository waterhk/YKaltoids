//
//  YAConversationMessageListViewController.h
//  altoids
//
//  Created by Jon Herron on 10/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessageListViewController.h"
#import "ConversationRepository.h"
#import "MessageHandler.h"
#import "YAConversation.h"
#import "ParticipantRepository.h"
#import "ImageScaler.h"
#import "ParticipantHandler.h"
#import "MessagePredicateCreator.h"
#import "AppFactory.h"
#import "ConversationMessageListTableViewDataSourceDelegate.h"
#import "TransactionCommandDelegate.h"
@protocol PullUpRefreshViewInstanceFactory;
@protocol PullToRefreshView;
@protocol Threader;

@protocol ConversationViewCellsHeightConfiguration;

@interface YAConversationMessageListViewController : UITableViewController <MessageListViewController, ConversationMessageListTableViewDataSourceDelegate, TransactionCommandDelegate>

@property (strong, nonatomic) id<ConversationRepository> conversationRepository;
@property (strong, nonatomic) id<ParticipantRepository> participantRepository;
@property (strong, nonatomic) id<ImageScaler> imageScaler;
@property (strong, nonatomic) id<ParticipantHandler> participantHandler;
@property (strong, nonatomic) id<MessageHandler> messageHandler;
@property (strong, nonatomic) id<ConversationViewCellsHeightConfiguration> conversationViewCellsHeightConfiguration;

@property (strong, nonatomic) id<ConversationMessageListTableViewDataSourceInstanceFactory> conversationMessageListTableViewDataSourceInstanceFactory;
@property (nonatomic, strong) id<PullUpRefreshViewInstanceFactory> pullUpRefreshViewInstanceFactory;

@property (nonatomic, strong) UIView<PullToRefreshView>* pullToRefreshView;
@property (nonatomic, strong) id<Threader> mainThreader;

- (id)initWithConversation:(YAConversation *)conversation;

@end
