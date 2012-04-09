//
//  YAManagedObjectContextFactory.h
//  altoids
//
//  Created by Jon Herron on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectContextFactory.h"
#import "PersistentStoreURLGenerator.h"
// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAManagedObjectContextFactory : NSObject <ManagedObjectContextFactory>

#pragma mark @property declarations
@property (copy,   nonatomic) NSString *persistentStoreType;
@property (strong, nonatomic) NSBundle *bundleContainingManagedObjectModel;
@property (strong, nonatomic) id<PersistentStoreURLGenerator> persistentStoreURLGenerator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
