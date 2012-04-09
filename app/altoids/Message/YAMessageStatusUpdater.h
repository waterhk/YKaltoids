//
//  YAMessageStatusUpdater.h
//  altoids
//
//  Created by Jon Herron on 12/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageStatusUpdater.h"
#import "ArraySplitter.h"
#import "CommandQueue.h"
#import "ConversationCommandFactory.h"
#import "MessageListToArrayOfMessageIDsConverter.h"
#import "MessageHandler.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMessageStatusUpdater : NSObject <MessageStatusUpdater>

#pragma mark @property declarations
@property (strong, nonatomic) id<ArraySplitter> arraySplitter;
@property (strong, nonatomic) id<CommandQueue> mmcCommandQueue;
@property (strong, nonatomic) id<ConversationCommandFactory> conversationCommandFactory;
@property (strong, nonatomic) id<MessageListToArrayOfMessageIDsConverter> messageListToArrayOfMessageIDsConverter;
@property (strong, nonatomic) id<MessageHandler> messageHandler;

#pragma mark  Class methods

#pragma mark Instance methods

@end
