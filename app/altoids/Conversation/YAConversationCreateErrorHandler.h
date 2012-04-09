//
//  YAConversationCreateErrorHandler.h
//  altoids
//
//  Created by Jon Herron on 11/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationHandler.h"
#import "ManagedObjectContextFactory.h"
#import "YAMMCErrorHandler.h"

@protocol MessageHandler;

@interface YAConversationCreateErrorHandler : YAMMCErrorHandler

- (id)initWithConversationHandler:(id<ConversationHandler>)theConversationHandler 
      managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory 
             conversationObjectID:(NSManagedObjectID *)theConversationObjectID 
                   messageHandler:(id<MessageHandler>)theMessageHandler;

@end
