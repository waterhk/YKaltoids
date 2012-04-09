//
//  TimestampLabelFormatter.h
//  altoids
//
//  Created by Xianzhe Ma on 2/28/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FormattedUILabel;
@class YAConversation;
@class YAMessage;

@protocol TimestampLabelFormatter <NSObject>

- (void)formatLabel:(id<FormattedUILabel>)aLabel withConversation:(YAConversation *)aConversation;
- (void)formatLabel:(id<FormattedUILabel>)aLabel withMessage:(YAMessage *)aMessage;

@end
