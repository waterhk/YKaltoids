//
//  ConversationViewCellFactory.h
//  altoids
//
//  Created by Xianzhe Ma on 2/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YAMessage;
@protocol ConversationViewCell;
@protocol MessageFailToSendDelegate;

@protocol ConversationViewCellFactory <NSObject>

- (id<ConversationViewCell>)createCellForMessage:(YAMessage *)aMessage withDelegate:(id<MessageFailToSendDelegate>)aDelegate;
- (NSString *)cellReuseIdentifierForMessage:(YAMessage *)aMessage;

@end
