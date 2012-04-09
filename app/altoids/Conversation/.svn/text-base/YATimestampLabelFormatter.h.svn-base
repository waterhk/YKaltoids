//
//  YATimestampLabelFormatter.h
//  altoids
//
//  Created by Xianzhe Ma on 2/28/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimestampLabelFormatter.h"

@protocol ConversationHandler;
@protocol AttributedStringCreator;
@protocol AttributedStringBuilder;
@protocol TimestampFormatter;

@interface YATimestampLabelFormatter : NSObject <TimestampLabelFormatter>

@property (nonatomic, strong) id<ConversationHandler> conversationHandler;
@property (nonatomic, strong) id<AttributedStringCreator> attributedStringCreator;
@property (nonatomic, strong) id<AttributedStringBuilder> attributedStringBuilder;
@property (nonatomic, strong) id<TimestampFormatter> timestampFormatter;

@end
