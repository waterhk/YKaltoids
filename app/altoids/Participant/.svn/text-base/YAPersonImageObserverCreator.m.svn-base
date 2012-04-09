//
//  YAPersonImageObserverCreator.m
//  altoids
//
//  Created by Anand Biligiri on 11/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAPersonImageObserverCreator.h"
#import "YAPersonImageObserver.h"

// Private class extension
@interface YAPersonImageObserverCreator ()

// @property definitions

// methods

@end

@implementation YAPersonImageObserverCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize fetchRequestCreator = fetchRequestCreator_;
@synthesize sortDescriptors = sortDescriptors_;
@synthesize fetchedResultsControllerFactory = fetchedResultsControllerFactory_;
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
#pragma mark PersonImageObserverCreator methods
- (id<PersonImageObserver>)createWithDelegate:(id<PersonImageObserverDelegate>)delegate managedObjectContext:(NSManagedObjectContext *)context
{
    return [[YAPersonImageObserver alloc] initWithDelegate:delegate managedObjectContext:context fetchRequestCreator:[self fetchRequestCreator]
                                           sortDescriptors:[self sortDescriptors]
                           fetchedResultsControllerFactory:[self fetchedResultsControllerFactory]];
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
#pragma mark YAPersonImageObserverCreator ()

@end
