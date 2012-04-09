//
//  YAConversationMessageListViewControllerCreator.m
//  altoids
//
//  Created by Jon Herron on 10/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationMessageListViewControllerCreator.h"
#import "YAConversationNewMessageListViewController.h"

@implementation YAConversationMessageListViewControllerCreator

@synthesize nibName = nibName_;
@synthesize nibBundle = nibBundle_;
@synthesize participantDescriptionBuilder = participantDescriptionBuilder_;
@synthesize conversationDetailsViewControllerInstanceFactory = conversationDetailsViewControllerInstanceFactory_;
@synthesize navigationBarButtonItemRepository = navigationBarButtonItemRepository_;
@synthesize contactRepository = contactRepository_;
@synthesize mutableArrayCreator = mutableArrayCreator_;

@synthesize conversationMessageListViewControllerInstanceFactory = conversationMessageListViewControllerInstanceFactory_;

- (id<ViewControllerAccessor>)createWithConversation:(YAConversation *)theConversation
{
    id<MessageListViewController> messageListViewController = [[self conversationMessageListViewControllerInstanceFactory] createConversationMessageListViewControllerWithConversation:theConversation];

    
    return [[YAConversationNewMessageListViewController alloc] initWithMessageListViewController:messageListViewController
                                                                                         nibName:[self nibName] 
                                                                                          bundle:[self nibBundle] 
                                                                   participantDescriptionBuilder:[self participantDescriptionBuilder] 
                                                                             mutableArrayCreator:[self mutableArrayCreator] 
                                                conversationDetailsViewControllerInstanceFactory:[self conversationDetailsViewControllerInstanceFactory] 
                                                               navigationBarButtonItemRepository:[self navigationBarButtonItemRepository]
                                                                               contactRepository:[self contactRepository]
                                                                                    conversation:theConversation];
}

@end
