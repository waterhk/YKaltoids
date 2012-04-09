//
//  MyClass.m
//  altoids
//
//  Created by Jon Herron on 9/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationDeleter.h"
#import "YAConversation.h"

// Private class extension
@interface YAConversationDeleter ()

// @property definitions

// methods

@end

@implementation YAConversationDeleter

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize conversationHandler = conversationHandler_;
@synthesize conversationFetchRequestCreator = conversationFetchRequestCreator_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark ConversationDeleter delegate methods

- (BOOL)deleteAllConversationsInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext error:(NSError **)anError
{
    NSParameterAssert(theManagedObjectContext);
    NSParameterAssert(anError);
    
    NSArray *conversations = nil;
    NSFetchRequest *fetchRequest = nil;
    
    fetchRequest = [[self conversationFetchRequestCreator] fetchRequestForAllConversationsInManagedObjectContext:theManagedObjectContext];
    
    if (!(conversations = [theManagedObjectContext executeFetchRequest:fetchRequest error:anError])) 
    {        
        return NO;
    }
    
    if (![conversations count]) 
    {
        return YES;
    }
    
    for (YAConversation *conversation in conversations) 
    {
        [[self conversationHandler] deleteConversation:conversation inManagedObjectContext:theManagedObjectContext];
    }
    
    if (![theManagedObjectContext save:anError])
    {        
        return NO;
    }
    
    return YES;
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark MyClass ()

@end
