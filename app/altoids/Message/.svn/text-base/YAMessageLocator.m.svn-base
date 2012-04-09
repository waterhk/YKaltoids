//
//  YAMessageLocator.m
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageLocator.h"

@implementation YAMessageLocator

@synthesize messageFetchRequestCreator = messageFetchRequestCreator_;

- (NSArray *)messagesMatchingIDs:(NSArray *)theMessageIDs inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    NSArray *messages = nil;
    NSError *error = nil;
    NSFetchRequest *fetchRequest = nil;
    
    if (!(fetchRequest = [[self messageFetchRequestCreator] fetchRequestForMessagesMatchingIDs:theMessageIDs inManagedObjectContext:theManagedObjectContext])) 
    {
        YALogError(@"Nil fetch request returned from messageFetchRequestCreator's fethcRequestForMessagesMatchingIDs:inManagedObjectContext:");
        
        return nil;
    }
    
    if (!(messages = [theManagedObjectContext executeFetchRequest:fetchRequest error:&error])) 
    {
        YALogError(@"Error retrieving messages by ID: %@", [error localizedDescription]);
        
        return nil;
    }
    
    return messages;
}

@end
