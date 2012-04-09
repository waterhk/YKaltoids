//
//  YAConversationListViewController.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewControllerAccessor.h"
#import "ConversationComposeDelegate.h"
#import "ConversationRepository.h"
#import "ConversationMessageListViewControllerCreator.h"
#import "ConversationFetchRequestCreator.h"
#import "FetchedResultsControllerFactory.h"
#import "ManagedObjectContextFactory.h"
#import "ContactRepositorySubscriber.h"
#import "TransactionCommandDelegate.h"

@protocol ConversationComposeViewControllerInstanceFactory;
@protocol FetchedResultsControllerFactory;
@protocol ManagedObjectContextFactory;
@protocol NavigationBarButtonItemRepository;
@protocol ConversationListCellFactory;
@protocol ContactRepository;
@protocol PullDownRefreshViewInstanceFactory;
@protocol PullToRefreshView;
@protocol Threader;

@interface YAConversationListViewController : UITableViewController <ViewControllerAccessor, ConversationComposeDelegate, NSFetchedResultsControllerDelegate, ContactRepositorySubscriber, TransactionCommandDelegate>

@property (nonatomic, strong) id<ConversationRepository> conversationRepository;
@property (nonatomic, strong) id<ConversationComposeViewControllerInstanceFactory> conversationComposeViewControllerInstanceFactory;
@property (nonatomic, strong) id<ConversationFetchRequestCreator> conversationFetchRequestCreator;
@property (nonatomic, strong) id<ConversationMessageListViewControllerCreator> conversationMessageListViewControllerCreator;
@property (nonatomic, strong) id<FetchedResultsControllerFactory> fetchedResultsControllerFactory;
@property (nonatomic, strong) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (nonatomic, strong) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;
@property (nonatomic, strong) UIView *cellSelectionStyleBackgroundView;
@property (nonatomic, strong) id<ConversationListCellFactory> conversationListCellFactory;
@property (nonatomic, strong) id<ContactRepository> contactRepository;
@property (nonatomic, strong) id<PullDownRefreshViewInstanceFactory> pullDownRefreshViewInstanceFactory;
@property (nonatomic, strong) id<Threader> mainThreader;

@property (nonatomic, strong) UIView<PullToRefreshView>* pullToRefreshView;

@end