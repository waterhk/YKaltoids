//
//  FetchRequestCreator.h
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@protocol FetchRequestCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSFetchRequest *)fetchRequestForEntity:(NSEntityDescription *)theEntity;
- (NSFetchRequest *)fetchRequestForEntity:(NSEntityDescription *)theEntity withSortDescriptors:(NSArray *)theSortDescriptors;
- (NSFetchRequest *)fetchRequestForEntity:(NSEntityDescription *)theEntity withPredicate:(NSPredicate *)thePredicate;
- (NSFetchRequest *)fetchRequestForEntity:(NSEntityDescription *)theEntity withPredicate:(NSPredicate *)thePredicate sortDescriptors:(NSArray *)theSortDescriptors;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
