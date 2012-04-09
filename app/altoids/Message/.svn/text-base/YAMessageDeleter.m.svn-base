//
//  YAMessageDeleter.m
//  altoids
//
//  Created by Jon Herron on 10/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageDeleter.h"

@implementation YAMessageDeleter

@synthesize messageFetchRequestCreator = messageFetchRequestCreator_;
@synthesize messageHandler = messageHandler_;
@synthesize messageErrorCreator = messageErrorCreator_;

- (BOOL)deleteAllMessagesInConversationWithID:(NSString *)theConversationID inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext error:(NSError **)anError
{
    NSArray *messages = nil;
    NSError *error = nil;
    NSFetchRequest *fetchRequest = nil;
    
    fetchRequest = [[self messageFetchRequestCreator] fetchRequestForMessagesInConversationWithID:theConversationID inManagedObjectContext:theManagedObjectContext];
    
    messages = [theManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (![messages count]) 
    {
        *anError = [[self messageErrorCreator] errorWithCode:YAMessageErrorCodeFailedToFetchMessagesFromLocalStorage];
        
        return NO;
    }
    
    for (YAMessage *message in messages) 
    {
        [[self messageHandler] deleteMessage:message inManagedObjectContext:theManagedObjectContext];
    }
    
    if (![theManagedObjectContext save:&error]) 
    {
        *anError = [[self messageErrorCreator] errorWithCode:YAMessageErrorCodeFailedToSaveMessageLocally];
        
        return NO;
    }
    
    return YES;
}

- (BOOL)deleteMessage:(YAMessage *)aMessage inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)aError{
    [[self messageHandler] deleteMessage:aMessage inManagedObjectContext:aManagedObjectContext];
    
    NSError *error;

    if (![aManagedObjectContext save:&error]) 
    {
        *aError = [[self messageErrorCreator] errorWithCode:YAMessageErrorCodeFailedToSaveMessageLocally];
        
        return NO;
    }
    return YES;
}

@end
