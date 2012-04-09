//
//  YAConversationGapPlaceholderClearer.m
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientConversationListGapHandling
//

#import "YAConversationGapPlaceholderClearer.h"

@implementation YAConversationGapPlaceholderClearer

@synthesize conversationHandler = conversationHandler_;
@synthesize conversationPredicateCreator = conversationPredicateCreator_;
@synthesize mutableArrayCreator = mutableArrayCreator_;

- (NSArray *)clearConversationGapPlaceholdersInListOfConversations:(NSArray *)theListOfConversations inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext moreConversationsPresentOnServer:(BOOL)theMoreConversationsPresentOnServer
{
    NSMutableArray *conversations = [[self mutableArrayCreator] mutableArrayWithCapacity:[theListOfConversations count]];;
    NSPredicate *conversationGapPlaceholderPredicate = [[self conversationPredicateCreator] predicateMatchingConversationGapPlaceholders];
    
    for (YAConversation *conversation in theListOfConversations) 
    {
        if ([conversationGapPlaceholderPredicate evaluateWithObject:conversation])
        {
            [[self conversationHandler] deleteConversation:conversation inManagedObjectContext:theManagedObjectContext];
        }
        else
        {
            [conversations addObject:conversation];
        }
    }
    
    return conversations;
}

@end
