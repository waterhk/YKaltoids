//
//  YAPersonImageObserver.m
//  altoids
//
//  Created by Anand Biligiri on 11/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAPersonImageObserver.h"
#import "YAPersonImage.h"

// Private class extension
@interface YAPersonImageObserver () <NSFetchedResultsControllerDelegate>

// @property definitions
@property (assign, nonatomic) id<PersonImageObserverDelegate> delegate;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

// methods

@end

@implementation YAPersonImageObserver

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize delegate = delegate_;
@synthesize fetchedResultsController = fetchedResultsController_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithDelegate:(id<PersonImageObserverDelegate>)delegate managedObjectContext:(NSManagedObjectContext *)managedObjectContext
   fetchRequestCreator:(id<FetchRequestCreator>)fetchRequestCreator
       sortDescriptors:(NSArray*)sortDescriptors
fetchedResultsControllerFactory:(id<FetchedResultsControllerFactory>)fetchedResultsControllerFactory
{
  self = [super init];
  if (self) {
      NSFetchRequest *fetchRequest = [fetchRequestCreator fetchRequestForEntity:[NSEntityDescription entityForName:@"PersonImage"
                                                                                            inManagedObjectContext:managedObjectContext]
                                                            withSortDescriptors:sortDescriptors];
      
      NSFetchedResultsController *fetchedResultsController = [fetchedResultsControllerFactory createWithFetchRequest:fetchRequest
                                                                                             forManagedObjectContext:managedObjectContext
                                                                                                            delegate:self];
      NSError *error;
      [fetchedResultsController performFetch:&error];
      fetchedResultsController_ = fetchedResultsController;
      delegate_ = delegate;
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate methods
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
    forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    YAPersonImage *personImage = anObject;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
        case NSFetchedResultsChangeUpdate:
            if ([personImage imageData])
                [[self delegate] didChangeImageForParticipants:[personImage persons]];
            break;
            
        default:
            break;
    }
}

#pragma mark Delegater methods
-(void)clearDelegate:(id)delegate
{
    if([self delegate] == delegate)
    {
        [self setDelegate:nil];
    }
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
#pragma mark YAPersonImageObserver ()

@end
