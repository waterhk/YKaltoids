//
//  YAFetchRequestRepository.m
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAFetchRequestRepository.h"

@interface YAFetchRequestRepository ()

- (NSFetchRequest *)fetchRequestForAddressMetaDataEntitiesMatchingPredicate:(NSPredicate *)predicate inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end

@implementation YAFetchRequestRepository

@synthesize entityDescriptionCreator = entityDescriptionCreator_;
@synthesize fetchRequestCreator = fetchRequestCreator_;
@synthesize predicateCreator = predicateCreator_;

- (NSFetchRequest *)fetchRequestForAddressMetaDataWithHandle:(NSString *)handle inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSPredicate *predicateMatchingHandle = [[self predicateCreator] predicateMatchingAddressMetaDataWithHandle:handle];
    
    return [self fetchRequestForAddressMetaDataEntitiesMatchingPredicate:predicateMatchingHandle inManagedObjectContext:managedObjectContext];
}

- (NSFetchRequest *)fetchRequestForAddressMetaDatasWithHandles:(NSArray *)handles inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSPredicate *predicateMatchingHandles = [[self predicateCreator] predicateMatchingAddressMetaDatasWithHandles:handles];
    
    return [self fetchRequestForAddressMetaDataEntitiesMatchingPredicate:predicateMatchingHandles inManagedObjectContext:managedObjectContext];
}

- (NSFetchRequest *)fetchRequestForAddressMetaDataEntitiesMatchingPredicate:(NSPredicate *)predicate inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if (!predicate) 
    {
        return nil;
    }
    
    NSEntityDescription *entityDescription = [[self entityDescriptionCreator] addressMetaDataEntityDescriptionInManagedObjectContext:managedObjectContext];
    
    if (!entityDescription) 
    {
        return nil;
    }
    
    NSFetchRequest *fetchRequest = [[self fetchRequestCreator] fetchRequestForEntity:entityDescription withPredicate:predicate];
    
    return fetchRequest;
}

@end
