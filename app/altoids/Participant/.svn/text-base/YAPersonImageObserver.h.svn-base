//
//  YAPersonImageObserver.h
//  altoids
//
//  Created by Anand Biligiri on 11/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchRequestCreator.h"
#import "FetchedResultsControllerFactory.h"
#import "PersonImageObserver.h"
#import "PersonImageObserverDelegate.h"
// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAPersonImageObserver : NSObject<PersonImageObserver>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods
- (id)initWithDelegate:(id<PersonImageObserverDelegate>)delegate managedObjectContext:(NSManagedObjectContext *)managedObjectContext
   fetchRequestCreator:(id<FetchRequestCreator>)fetchRequestCreator
       sortDescriptors:(NSArray*)sortDescriptors
fetchedResultsControllerFactory:(id<FetchedResultsControllerFactory>)fetchedResultsControllerFactory;
@end
