//
//  YAConversationListCellFactory.h
//  altoids
//
//  Created by Xianzhe Ma on 2/24/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationListCellFactory.h"

@protocol ConversationListCellInstanceFactory;
@protocol ConversationListSystemMessageCellInstanceFactory;

extern NSString * const kConversationListSystemMessageCellReuseIdentifier;

@interface YAConversationListCellFactory : NSObject <ConversationListCellFactory>

@property (nonatomic, strong) id<ConversationListCellInstanceFactory> conversationListCellInstanceFactory;
@property (nonatomic, strong) id<ConversationListSystemMessageCellInstanceFactory> conversationListSystemMessageCellInstanceFactory;

@end
