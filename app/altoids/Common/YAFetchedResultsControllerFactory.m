//
//  YAFetchedResultsControllerFactory.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAFetchedResultsControllerFactory.h"

// Private class extension
@interface YAFetchedResultsControllerFactory ()

// @property definitions

// methods

@end

@implementation YAFetchedResultsControllerFactory

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark FetchResultsControllerFactory protocol methods

- (NSFetchedResultsController *)createWithFetchRequest:(NSFetchRequest *)fetchRequest forManagedObjectContext:(NSManagedObjectContext *)managedObjectContext delegate:(id<NSFetchedResultsControllerDelegate>)delegate
{
    return [self createWithFetchRequest:fetchRequest forManagedObjectContext:managedObjectContext cacheName:nil delegate:delegate];
}


- (NSFetchedResultsController *)createWithFetchRequest:(NSFetchRequest *)fetchRequest forManagedObjectContext:(NSManagedObjectContext *)managedObjectContext cacheName:(NSString *)cacheName delegate:(id<NSFetchedResultsControllerDelegate>)delegate
{
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext 
                                                                            sectionNameKeyPath:nil cacheName:cacheName];
    [frc setDelegate:delegate];
    return frc;
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
#pragma mark YAFetchedResultsControllerFactory ()

@end
