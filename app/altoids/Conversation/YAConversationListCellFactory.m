//
//  YAConversationListCellFactory.m
//  altoids
//
//  Created by Xianzhe Ma on 2/24/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationListCellFactory.h"
#import "YAConversationListGapCell.h"
#import "YAConversationListCell.h"
#import "ConversationStatus.h"
#import "YAConversation.h"
#import "AppFactory.h"
#import "YAConversation.h"
#import "YAMessage.h"
#import "MessageStatus.h"

@implementation YAConversationListCellFactory

@synthesize conversationListCellInstanceFactory = conversationListCellInstanceFactory_;
@synthesize conversationListSystemMessageCellInstanceFactory = conversationListSystemMessageCellInstanceFactory_;

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (UITableViewCell *)createConversationListCellWithConversation:(YAConversation *)aConversation {
    YAConversationStatus conversationStatus = [[aConversation status] intValue];
    
    if (conversationStatus == YAConversationStatusGapPlaceholder) {
        return [[YAConversationListGapCell alloc] init];
    } else {
        YAMessage *mostResentMessage = [aConversation mostRecentMessage];
        if ([[mostResentMessage status] intValue] == YAMessageStatusSystemMessage) {
            return (UITableViewCell *)[[self conversationListSystemMessageCellInstanceFactory] createConversationListSystemMessageCell];
        } else {
            return (UITableViewCell *)[[self conversationListCellInstanceFactory] createConversationListCell];
        }
        return (UITableViewCell *)[[self conversationListCellInstanceFactory] createConversationListCell];
    }
}

- (NSString *)cellReuseIdentifierWithConversation:(YAConversation *)aConversation {
    YAConversationStatus conversationStatus = [[aConversation status] intValue];
        
    if (conversationStatus == YAConversationStatusGapPlaceholder) {
        return kConversationListGapCellIdentifier;
    } else {
        YAMessage *mostResentMessage = [aConversation mostRecentMessage];
        if ([[mostResentMessage status] intValue] == YAMessageStatusSystemMessage) {
            return kConversationListSystemMessageCellReuseIdentifier;
        } else {
            return kConversationListCellIdentifier;
        }
    }
}

- (CGFloat)cellHeightForConversation:(YAConversation *)aConversation
{
    static CGFloat heightForConversationListGapCell = 42.0;
    static CGFloat heightForConversationListCell = 60.0;
    static CGFloat heightForConversationListSystemCell = 60.0;
    YAConversationStatus conversationStatus = [[aConversation status] intValue];
    
    if (conversationStatus == YAConversationStatusGapPlaceholder) {
        return heightForConversationListGapCell;
    } else {
        YAMessage *mostResentMessage = [aConversation mostRecentMessage];
        if ([[mostResentMessage status] intValue] == YAMessageStatusSystemMessage) {
            return heightForConversationListSystemCell;
        } else {
            return heightForConversationListCell;
        }
    }
}

@end
