//
//  YAConversationLocator.m
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationLocator.h"

@implementation YAConversationLocator

@synthesize conversationFetchRequestCreator = conversationFetchRequestCreator_;

- (YAConversation *)conversationWithID:(NSString *)theConversationID inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    NSArray *conversations = nil;
    NSError *error = nil;
    NSFetchRequest *fetchRequest = nil;
    
    if (!(fetchRequest = [[self conversationFetchRequestCreator] fetchRequestForConversationWithID:theConversationID inManagedObjectContext:theManagedObjectContext])) 
    {
        YALogError(@"Nil fetch request for converationWithID:inManagedObjectContext:");
        
        return nil;
    }
    
    if (!(conversations = [theManagedObjectContext executeFetchRequest:fetchRequest error:&error])) 
    {
        YALogError(@"Error retrieving conversation by ID: %@", [error localizedDescription]);
        
        return nil;
    }
    
    if ([conversations count] > 1) 
    {
        YALogError(@"Did not expect to find more than one conversation with ID: %@", theConversationID);
    }
    
    return [conversations objectAtIndex:0];
}

- (NSArray *)conversationsWithIDs:(NSArray *)theConversationIDs inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    NSArray *conversations = nil;
    NSError *error = nil;
    NSFetchRequest *fetchRequest = nil;
    
    if (!(fetchRequest = [[self conversationFetchRequestCreator] fetchRequestForConversationsWithIDs:theConversationIDs inManagedObjectContext:theManagedObjectContext]))
    {
        YALogError(@"Nil fetch request returned from conversationFetchRequestCreator's fetchRequestForConversationsMatchingIDs:inManagedObjectContext:");
        
        return nil;
    }
    
    if (!(conversations = [theManagedObjectContext executeFetchRequest:fetchRequest error:&error]) || error)
    {
        YALogError(@"Error retrieving conversations by ID: %@", [error localizedDescription]);
        
        return nil;
    }
    
    return conversations;
}

@end
