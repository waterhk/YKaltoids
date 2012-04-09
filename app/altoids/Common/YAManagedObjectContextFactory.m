//
//  YAManagedObjectContextFactory.m
//  altoids
//
//  Created by Jon Herron on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAManagedObjectContextFactory.h"

// #define
#pragma mark #defines
#define kManagedObjectModelResourceURL @"altoids"
#define kManagedObjectModelExtension @"momd"

// Private class extension
@interface YAManagedObjectContextFactory ()

// @property definitions
@property (strong, nonatomic) NSManagedObjectContext *mainThreadManagedObjectContext;

// methods
- (NSDictionary *)persistentStoreOptions;
- (NSManagedObjectContext *)managedObjectContext;

@end

@implementation YAManagedObjectContextFactory

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize bundleContainingManagedObjectModel;
@synthesize persistentStoreType;
@synthesize persistentStoreURLGenerator;
@synthesize mainThreadManagedObjectContext;

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

- (NSManagedObjectContext *)create
{
    if ([NSThread isMainThread]) {
        return [self mainThreadManagedObjectContext];
    }
    
    return [self managedObjectContext];
}

- (NSManagedObjectContext *)createWithStalenessInterval:(NSTimeInterval)expiration
{
    NSManagedObjectContext *context = [self create];
    
    [context setStalenessInterval:expiration];
    
    return context;
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAManagedObjectContextFactory ()

- (NSDictionary *)persistentStoreOptions
{
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
}

- (NSManagedObjectContext *)mainThreadManagedObjectContext
{
    if (!mainThreadManagedObjectContext && [NSThread isMainThread]) {
        mainThreadManagedObjectContext = [self managedObjectContext];
    }
    
    return mainThreadManagedObjectContext;
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSDictionary *persistentStoreOptions = nil;
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = nil;
    NSManagedObjectModel *managedObjectModel = nil;
    NSPersistentStoreCoordinator *persistentStoreCoordinator = nil;
    NSURL *managedObjectModelResourceURL = nil;
    NSURL *persistentStoreURL = nil;
    
    managedObjectModelResourceURL = [[self bundleContainingManagedObjectModel] URLForResource:kManagedObjectModelResourceURL withExtension:kManagedObjectModelExtension];
    persistentStoreURL = [[self persistentStoreURLGenerator] persistentStoreURLForStoreType:[self persistentStoreType]];
    
    managedObjectContext = [[NSManagedObjectContext alloc] init];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:managedObjectModelResourceURL];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    persistentStoreOptions = [self persistentStoreOptions];
    
    [persistentStoreCoordinator addPersistentStoreWithType:[self persistentStoreType] configuration:nil URL:persistentStoreURL options:persistentStoreOptions error:&error];
    
    if (error)
        return nil;
    
    [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    
    return managedObjectContext;
}

@end
