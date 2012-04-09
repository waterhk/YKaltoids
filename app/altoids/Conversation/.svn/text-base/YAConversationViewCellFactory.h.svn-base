//
//  YAConversationViewCellFactory.h
//  altoids
//
//  Created by Xianzhe Ma on 2/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationViewCellFactory.h"

@protocol MessageHandler;
@protocol ConversationViewMessageCellInstanceFactory;
@protocol ConversationViewCell;

extern NSString * const kConversationViewMessageCellReuseIdentifier;

@interface YAConversationViewCellFactory : NSObject <ConversationViewCellFactory>

@property (nonatomic, strong) id<MessageHandler> messageHandler;
@property (nonatomic, strong) id<ConversationViewMessageCellInstanceFactory> conversationViewMessageCellInstanceFactory;

- (id)init;

@end
