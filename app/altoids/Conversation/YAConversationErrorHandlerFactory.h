//
//  YAConversationErrorHandlerFactory.h
//  altoids
//
//  Created by Jon Herron on 11/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationErrorHandlerFactory.h"
#import "ConversationHandler.h"
#import "MessageHandler.h"
#import "MessageLocator.h"
#import "ManagedObjectContextFactory.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationErrorHandlerFactory : NSObject <ConversationErrorHandlerFactory>

#pragma mark @property declarations
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) id<ConversationHandler> conversationHandler;
@property (strong, nonatomic) id<MessageHandler> messageHandler;
@property (strong, nonatomic) id<MessageLocator> messageLocator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
