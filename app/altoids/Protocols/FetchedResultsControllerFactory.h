//
//  FetchedResultsControllerFactory.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FetchedResultsControllerFactory <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSFetchedResultsController *)createWithFetchRequest:(NSFetchRequest *)fetchRequest forManagedObjectContext:(NSManagedObjectContext *)managedObjectContext delegate:(id<NSFetchedResultsControllerDelegate>)delegate;

- (NSFetchedResultsController *)createWithFetchRequest:(NSFetchRequest *)fetchRequest forManagedObjectContext:(NSManagedObjectContext *)managedObjectContext cacheName:(NSString *)cacheName delegate:(id<NSFetchedResultsControllerDelegate>)delegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
