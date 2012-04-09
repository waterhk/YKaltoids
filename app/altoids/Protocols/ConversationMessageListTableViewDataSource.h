//
//  ConversationMessageListTableViewDataSource.h
//  altoids
//
//  Created by Jon Herron on 2/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewDataSource.h"
@protocol CommandTransaction, TransactionCommandDelegate;

@class YAMessage;

@protocol ConversationMessageListTableViewDataSource <TableViewDataSource>

- (id<CommandTransaction>)fetchMessagesForConversationWithTransactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate;

- (NSIndexPath *)indexPathForMessage:(YAMessage *)message;
- (YAMessage *)messageAtIndexPath:(NSIndexPath *)indexPath;

- (YAMessage *)lastMessage;
- (YAMessage *)oldestUnreadMessage;
- (NSArray *)unreadMessages;

@end
