//
//  ConversationListCellDataBinding.h
//  altoids
//
//  Created by Xianzhe Ma on 2/7/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kConversationListCellIdentifier;
extern NSString * const kConversationListGapCellIdentifier;

@class YAConversation;

@protocol ConversationListCell <NSObject>

- (void)bindConversation:(YAConversation *)aConversation;

@end
