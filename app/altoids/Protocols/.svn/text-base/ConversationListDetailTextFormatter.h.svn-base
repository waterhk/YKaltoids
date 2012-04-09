//
//  ConversationListDetailTextFormatter.h
//  altoids
//
//  Created by Jon Herron on 11/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAConversation.h"

@protocol FormattedUILabel;

@protocol ConversationListDetailTextFormatter <NSObject>

- (NSString *)senderDisplayNameForConversation:(YAConversation *)theConversation;
- (NSString *)detailTextForConversation:(YAConversation *)theConversation;
- (void)formatDetailLabel:(UILabel<FormattedUILabel> *)aDetailLabel forConversation:(YAConversation *)aConversation;

@end
