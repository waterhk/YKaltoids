//
//  YAConversationFetchRequestCreator.m
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationFetchRequestCreator.h"

// Private class extension
@interface YAConversationFetchRequestCreator ()

// @property definitions

// methods

@end

@implementation YAConversationFetchRequestCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize fetchRequestCreator = fetchRequestCreator_;
@synthesize conversationEntityDescriptionCreator = conversationEntityDescriptionCreator_;
@synthesize conversationPredicateCreator = conversationPredicateCreator_;
@synthesize sortDescriptors = sortDescriptors_;

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
#pragma mark ConversationFetchRequestCreator delegate methods

- (NSFetchRequest *)fetchRequestForAllConversationsInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    NSEntityDescription *entityDescription = [[self conversationEntityDescriptionCreator] conversationEntityDescriptionInManagedObjectContext:theManagedObjectContext];
    
    return [[self fetchRequestCreator] fetchRequestForEntity:entityDescription withSortDescriptors:[self sortDescriptors]];
}

- (NSFetchRequest *)fetchRequestForConversationWithID:(NSString *)theConversationID inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    NSEntityDescription *entityDescription = [[self conversationEntityDescriptionCreator] conversationEntityDescriptionInManagedObjectContext:theManagedObjectContext];
    NSPredicate *predicate = [[self conversationPredicateCreator] predicateMatchingConversationByID:theConversationID];
    
    return [[self fetchRequestCreator] fetchRequestForEntity:entityDescription withPredicate:predicate sortDescriptors:[self sortDescriptors]];
}

- (NSFetchRequest *)fetchRequestForConversationsWithIDs:(NSArray *)theConversationIDs inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    NSEntityDescription *entityDescription = [[self conversationEntityDescriptionCreator] conversationEntityDescriptionInManagedObjectContext:theManagedObjectContext];
    NSPredicate *predicate = [[self conversationPredicateCreator] predicateMatchingConversationsByID:theConversationIDs];
    
    return [[self fetchRequestCreator] fetchRequestForEntity:entityDescription withPredicate:predicate sortDescriptors:[self sortDescriptors]];
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
#pragma mark YAConversationFetchRequestCreator ()

@end
