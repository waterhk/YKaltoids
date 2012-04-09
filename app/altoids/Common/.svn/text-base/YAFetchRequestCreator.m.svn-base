//
//  MyClass.m
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "YAFetchRequestCreator.h"

// Private class extension
@interface YAFetchRequestCreator ()

// @property definitions

// methods

- (void)setDefaultFetchLimitAndBatchSizeForFetchRequest:(NSFetchRequest *)theFetchRequest;

@end

@implementation YAFetchRequestCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

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

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark FetchRequestCreator delegate methods

- (NSFetchRequest *)fetchRequestForEntity:(NSEntityDescription *)theEntity
{ 
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setEntity:theEntity];
    [self setDefaultFetchLimitAndBatchSizeForFetchRequest:fetchRequest];
    
    return fetchRequest;
}

- (NSFetchRequest *)fetchRequestForEntity:(NSEntityDescription *)theEntity withSortDescriptors:(NSArray *)theSortDescriptors
{
    NSFetchRequest *fetchRequest = [self fetchRequestForEntity:theEntity];
    
    [fetchRequest setSortDescriptors:theSortDescriptors];
    [self setDefaultFetchLimitAndBatchSizeForFetchRequest:fetchRequest];
    
    return fetchRequest;
}

- (NSFetchRequest *)fetchRequestForEntity:(NSEntityDescription *)theEntity withPredicate:(NSPredicate *)thePredicate
{
    NSFetchRequest *fetchRequest = [self fetchRequestForEntity:theEntity];
   
    [fetchRequest setPredicate:thePredicate];
    [self setDefaultFetchLimitAndBatchSizeForFetchRequest:fetchRequest];
    
    return fetchRequest;
}

- (NSFetchRequest *)fetchRequestForEntity:(NSEntityDescription *)theEntity withPredicate:(NSPredicate *)thePredicate sortDescriptors:(NSArray *)theSortDescriptors
{
    NSFetchRequest *fetchRequest = [self fetchRequestForEntity:theEntity withPredicate:thePredicate];
    
    [fetchRequest setSortDescriptors:theSortDescriptors];
    [self setDefaultFetchLimitAndBatchSizeForFetchRequest:fetchRequest];
    
    return fetchRequest;
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

- (void)setDefaultFetchLimitAndBatchSizeForFetchRequest:(NSFetchRequest *)theFetchRequest
{
    [theFetchRequest setFetchLimit:0];
    [theFetchRequest setFetchBatchSize:0];
}

@end
