//
//  MessageCreator.h
//  altoids
//
//  Created by Xianzhe Ma on 4/2/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YAMessage, YAConversation, YAParticipant;

@protocol MessageCreator <NSObject>

- (YAMessage *)createMessageForReplyingToConversation:(YAConversation *)aConversation withMessageBody:(NSString *)aMessageBodyString sender:(YAParticipant *)aSender;
- (YAMessage *)createMessageForNewConversation:(YAConversation *)aConversation withMessageBody:(NSString *)aMessageBody;

@end
