//
//  YAConversationNewMessageListViewController.h
//  altoids
//
//  Created by Jon Herron on 10/25/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAMessageComposeView.h"
#import "YAConversationMessageListMessagesView.h"
#import "YABaseViewController.h"
#import "MessageListViewController.h"
#import "ParticipantDescriptionBuilder.h"
#import "MutableArrayCreator.h"
#import "YAConversation.h"
#import "AppFactory.h"
#import "ContactRepositorySubscriber.h"

@protocol NavigationBarButtonItemRepository, ContactRepository;

@interface YAConversationNewMessageListViewController : YABaseViewController <ContactRepositorySubscriber>

@property (strong, nonatomic) IBOutlet YAMessageComposeView *messageReplyView;
@property (strong, nonatomic) IBOutlet YAConversationMessageListMessagesView *messagesListView;

- (id)initWithMessageListViewController:(id<MessageListViewController>)messageListViewController
                                nibName:(NSString *)nibNameOrNil
                                 bundle:(NSBundle *)nibBundleOrNil
          participantDescriptionBuilder:(id<ParticipantDescriptionBuilder>)theParticipantDescriptionBuilder 
                    mutableArrayCreator:(id<MutableArrayCreator>)theMutableArrayCreator 
conversationDetailsViewControllerInstanceFactory:(id<ConversationDetailsViewControllerInstanceFactory>)theConversationDetailsViewControllerInstanceFactory
      navigationBarButtonItemRepository:(id<NavigationBarButtonItemRepository>)navigationBarButtonItemRepository
                      contactRepository:(id<ContactRepository>)contactRepository
                           conversation:(YAConversation *)theConversation;
@end
