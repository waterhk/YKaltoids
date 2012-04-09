//
//  YAConversationViewCellFactory.m
//  altoids
//
//  Created by Xianzhe Ma on 2/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationViewCellFactory.h"
#import "YAMessage.h"
#import "MessageHandler.h"
#import "YAConversationViewSystemMessageCell.h"
#import "YAConversationViewGapCell.h"
#import "AppFactory.h"

@implementation YAConversationViewCellFactory

@synthesize messageHandler = messageHandler_;
@synthesize conversationViewMessageCellInstanceFactory = conversationViewMessageCellInstanceFactory_;

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (id<ConversationViewCell>)createCellForMessage:(YAMessage *)aMessage withDelegate:(id<MessageFailToSendDelegate>)aDelegate{
    YAMessageStatus messageStatus = [[self messageHandler] statusForMessage:aMessage];
    
    id<ConversationViewCell> cell;
    
    if (messageStatus == YAMessageStatusSystemMessage) {
        cell = [[YAConversationViewSystemMessageCell alloc] init];
    } else if (messageStatus == YAMessageStatusGapPlaceholder) {
        cell = [[YAConversationViewGapCell alloc] init];
    } else {
        cell = [[self conversationViewMessageCellInstanceFactory] createConversationViewMessageCell];
    }
    
    [cell bindMessage:aMessage];
    
    [cell setDelegate:aDelegate];
    
    return cell;
}

- (NSString *)cellReuseIdentifierForMessage:(YAMessage *)aMessage {
    YAMessageStatus messageStatus = [[self messageHandler] statusForMessage:aMessage];
    if (messageStatus == YAMessageStatusSystemMessage) {
        return kConversationViewSystemMessageCellReuseIdentifier;
    } else if (messageStatus == YAMessageStatusGapPlaceholder) {
        return kConversationViewGapCellReuseIdentifier;
    } else {
        return kConversationViewMessageCellReuseIdentifier;
    }
}

@end
