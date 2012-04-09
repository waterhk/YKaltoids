//
//  ConversationListCellFactory.h
//  altoids
//
//  Created by Xianzhe Ma on 2/24/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YAConversation;

@protocol ConversationListCellFactory <NSObject>

- (UITableViewCell *)createConversationListCellWithConversation:(YAConversation *)aConversation;
- (NSString *)cellReuseIdentifierWithConversation:(YAConversation *)aConversation;
- (CGFloat)cellHeightForConversation:(YAConversation *)aConversation;


@end
