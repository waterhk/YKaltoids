//
//  YAConversationCreateErrorHandler.m
//  altoids
//
//  Created by Jon Herron on 11/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationCreateErrorHandler.h"
#import "YAConversation.h"
#import "YAMessage.h"
#import "MessageStatus.h"
#import "MessageHandler.h"

@interface YAConversationCreateErrorHandler ()

@property (strong, nonatomic) id<ConversationHandler> conversationHandler;
@property (strong, nonatomic) NSManagedObjectID *conversationObjectID;
@property (strong, nonatomic) id<MessageHandler> messageHandler;

@end

@implementation YAConversationCreateErrorHandler

@synthesize conversationHandler = conversationHandler_;
@synthesize conversationObjectID = conversationObjectID_;
@synthesize messageHandler = messageHandler_;

- (id)initWithConversationHandler:(id<ConversationHandler>)theConversationHandler 
      managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory 
             conversationObjectID:(NSManagedObjectID *)theConversationObjectID 
                   messageHandler:(id<MessageHandler>)theMessageHandler
{
  self = [super initWithManagedObjectContextFactory:theManagedObjectContextFactory];
    
  if (self) 
  {
      conversationHandler_ = theConversationHandler;
      conversationObjectID_ = theConversationObjectID;
      messageHandler_ = theMessageHandler;
  }
  
  return self;
}

- (void)handleError:(NSError *)theError
{
    if (!theError) 
    {
        return;
    }
    
    YAConversation *conversation = (YAConversation *)[self managedObjectWithID:[self conversationObjectID]];
    
    if (!conversation) 
    {
        return;
    }
    
    [[self conversationHandler] setStatusAsPendingWithErrorsForConversation:conversation];
    YAMessage *lastMessage = (YAMessage *)[[[[self conversationHandler] messagesForConversation:conversation] allObjects] lastObject];
    [[self messageHandler] setStatusAsPendingWithErrorsForMessage:lastMessage];
    
    NSError *error = nil;
    [[self conversationHandler] save:conversation inManagedObjectContext:[self managedObjectContext] error:&error];
}

@end
