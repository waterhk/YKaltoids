//
//  YAConversationListDetailTextFormatter.h
//  altoids
//
//  Created by Jon Herron on 11/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationListDetailTextFormatter.h"
#import "ConversationHandler.h"
#import "MessageHandler.h"
#import "ParticipantNameFormatter.h"

@protocol AttributedStringCreator;
@protocol AttributedStringBuilder;

@interface YAConversationListDetailTextFormatter : NSObject <ConversationListDetailTextFormatter>

@property (strong, nonatomic) id<ConversationHandler> conversationHandler;
@property (strong, nonatomic) id<MessageHandler> messageHandler;
@property (strong, nonatomic) id<ParticipantNameFormatter> participantNameFormatter;
@property (nonatomic, strong) id<AttributedStringCreator> attributedStringCreator;
@property (nonatomic, strong) id<AttributedStringBuilder> attributedStringBuilder;

@end
