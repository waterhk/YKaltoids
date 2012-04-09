//
//  YAConversationListCommandErrorHandler.m
//  altoids
//
//  Created by Jon Herron on 11/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationListCommandErrorHandler.h"

@implementation YAConversationListCommandErrorHandler

@synthesize mmcConversationErrorDetector = mmcConversationErrorDetector_;
@synthesize mmcErrorCreator = mmcErrorCreator_;
@synthesize conversationErrorCreator = conversationErrorCreator_;
@synthesize conversationLocator = conversationLocator_;
@synthesize conversationHandler = conversationHandler_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;

- (BOOL)mmcConversationHasError:(YAMMCConversation *)theMMCConversation error:(NSError **)anError
{
    NSParameterAssert(anError);
    
    if (![[self mmcConversationErrorDetector] mmcConversationHasErrors:theMMCConversation])
    {
        return NO;
    }
    
    NSError *error;
    NSError *underlyingError;
   
    underlyingError = [[self mmcErrorCreator] errorFromMMCConversationErrors:[theMMCConversation errors]];
    
    error = [[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToRetrieveConversationFromServer underlyingError:underlyingError];
    
    *anError = error;
    
    return YES;
}

- (void)handleError:(NSError *)theError forMMCConversation:(YAMMCConversation *)theMMCConversation
{
    BOOL conversationSaved;
    NSError *error;
    NSManagedObjectContext *managedObjectContext;
    NSString *conversationID;
    YAConversation *conversation;
    
    conversationID = [theMMCConversation conversationID];
    
    if (!conversationID) 
    {
        YALogError(@"Error detected in conversation which has no ID, unable to create or update conversation.");
        
        return;
    }
    
    managedObjectContext = [[self managedObjectContextFactory] create];
    
    conversation = [[self conversationLocator] conversationWithID:conversationID inManagedObjectContext:managedObjectContext];
    
    if (!conversation) 
    {
        conversation = [[self conversationHandler] createConversationEntityInManagedObjectContext:managedObjectContext];
    }
    
    [[self conversationHandler] setStatusAsReceivedWithErrorsForConversation:conversation];
    
    conversationSaved = [[self conversationHandler] save:conversation inManagedObjectContext:managedObjectContext error:&error];
    
    if (!conversationSaved) 
    {
        YALogError(@"Failed to update conversation %@ with status ReceivedWithErrors", conversationID);
    }
    else
    {
        YALogDebug(@"Updated conversation %@ with status ReceivedWithErrors", conversationID);
    }
}

@end
