//
//  YAConversationReplyErrorHandler.m
//  altoids
//
//  Created by Anand Biligiri on 11/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationReplyErrorHandler.h"

@interface YAConversationReplyErrorHandler ()

@property (strong, nonatomic) id<MessageHandler> messageHandler;
@property (strong, nonatomic) NSManagedObjectID *messageObjectID;

- (void)markMessageAsPendingWithError;

@end

@implementation YAConversationReplyErrorHandler

@synthesize messageHandler = messageHandler_;
@synthesize messageObjectID = messageObjectID_;

- (id)initWithMessage:(YAMessage *)message messageHandler:(id<MessageHandler>)messageHandler
managedObjectContextFactory:(id<ManagedObjectContextFactory>)managedObjectContextFactory
{
  self = [super initWithManagedObjectContextFactory:managedObjectContextFactory];
  if (self) {
      messageHandler_ = messageHandler;
      messageObjectID_ = [message objectID];
  }
  
  return self;
}

- (void)handleError:(NSError *)theError
{
    if ([[theError domain] isEqualToString:NSURLErrorDomain]) {
        switch ([theError code]) {
            case NSURLErrorNotConnectedToInternet:
                [self markMessageAsPendingWithError];
                break;
            default:
                YALogWarning(@"Error did not handled :\n%@\n", [theError localizedDescription]);
                break;
        }
        
    } else {
        switch ([theError code]) {
            case YAMMCServerErrorArgumentsNotValid:
            case YAMMCServerErrorContentNotValidType:
            case YAMMCServerErrorConversationDoesNotExist:
            case YAMMCServerErrorConversationPermissionDenied:
                [self markMessageAsPendingWithError];
                break;
            default:
                YALogWarning(@"Error did not handled :\n%@\n", [theError localizedDescription]);
                break;
        }
    }
}

- (void)markMessageAsPendingWithError  
{
    YAMessage *message = (YAMessage *)[self managedObjectWithID:[self messageObjectID]];
    [[self messageHandler] setStatusAsPendingWithErrorsForMessage:message];
    NSError *error;
    [[self managedObjectContext] save:&error];
}

@end
