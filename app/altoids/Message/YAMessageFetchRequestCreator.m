//
//  YAMessageFetchRequestCreator.m
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageFetchRequestCreator.h"

// Private class extension
@interface YAMessageFetchRequestCreator ()

// @property definitions

// methods

@end

@implementation YAMessageFetchRequestCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize fetchRequestCreator = fetchRequestCreator_;
@synthesize messageEntityDescriptionCreator = messageEntityDescriptionCreator_;
@synthesize messagePredicateCreator = messagePredicateCreator_;
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
#pragma mark MessageFetchRequestCreator delegate methods

- (NSFetchRequest *)fetchRequestForAllMessagesInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    NSEntityDescription *entityDescription = [[self messageEntityDescriptionCreator] messageEntityDescriptionInManagedObjectContext:theManagedObjectContext];
    
    return [[self fetchRequestCreator] fetchRequestForEntity:entityDescription withSortDescriptors:[self sortDescriptors]];
}

- (NSFetchRequest *)fetchRequestForMessagesMatchingIDs:(NSArray *)theMessageIDs inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    NSEntityDescription *entityDescription = [[self messageEntityDescriptionCreator] messageEntityDescriptionInManagedObjectContext:theManagedObjectContext];
    NSPredicate *predicate = [[self messagePredicateCreator] predicateMatchingMessagesByID:theMessageIDs];
    
    return [[self fetchRequestCreator] fetchRequestForEntity:entityDescription withPredicate:predicate sortDescriptors:[self sortDescriptors]];
}

- (NSFetchRequest *)fetchRequestForMessagesInConversationWithID:(NSString *)theConversationID inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    NSEntityDescription *entityDescription = [[self messageEntityDescriptionCreator] messageEntityDescriptionInManagedObjectContext:theManagedObjectContext];
    NSPredicate *predicate = [[self messagePredicateCreator] predicateMatchingMessagesInConversationWithID:theConversationID];
    
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
#pragma mark YAMessageFetchRequestCreator ()

@end
