//
//  ConversationViewCell.h
//  altoids
//
//  Created by Xianzhe Ma on 2/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YAMessage;
@protocol MessageFailToSendDelegate;

@protocol ConversationViewCell <NSObject>

@property (nonatomic, assign) id<MessageFailToSendDelegate> delegate;

- (void)bindMessage:(YAMessage *)aMessage;
- (void)setAvatar:(UIImage *)image;

@end
