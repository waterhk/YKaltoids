//
//  ConversationTitleFormatter.h
//  altoids
//
//  Created by Xianzhe Ma on 2/28/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YAConversation;
@protocol FormattedUILabel;

@protocol ConversationTitleFormatter <NSObject>

- (void)formatConversationTitleLabel:(id<FormattedUILabel>)aLabel withConversation:(YAConversation *)aConversation;

@end
