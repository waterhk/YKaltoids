//
//  YAEntityDescriptionCreator.m
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAEntityDescriptionCreator.h"

#define kAddressMetaDataEntityName @"AddressMetaData"

@implementation YAEntityDescriptionCreator

- (id)createEntityForName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:managedObjectContext];
}

- (NSEntityDescription *)entityForName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [NSEntityDescription entityForName:name inManagedObjectContext:managedObjectContext];
}

- (NSEntityDescription *)addressMetaDataEntityDescriptionInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [self entityForName:kAddressMetaDataEntityName inManagedObjectContext:managedObjectContext];
}

- (YAAddressMetaData *)createAddressMetaDataEntityInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [self createEntityForName:kAddressMetaDataEntityName inManagedObjectContext:managedObjectContext];
}

@end
