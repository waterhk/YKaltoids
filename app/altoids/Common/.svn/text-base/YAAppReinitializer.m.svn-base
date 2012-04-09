//
//  YAAppReinitializer.m
//  altoids
//
//  Created by Anand Biligiri on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAAppReinitializer.h"
#import "YASessionLogger.h"

// Private class extension
@interface YAAppReinitializer ()

// @property definitions
// methods

@end

@implementation YAAppReinitializer
@synthesize managedObjectContextFactory = managedObjectContextFactory_;

- (NSDictionary *)persistentStoreOptions
{
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
}

- (BOOL)hardResetContext:(NSManagedObjectContext *)context store:(NSPersistentStore *)store;
{
    NSError *error = nil;
    
    NSDictionary *persistentStoreOptions = nil;
    
    NSPersistentStoreCoordinator *storeCoordinator = [context persistentStoreCoordinator];
    persistentStoreOptions = [self persistentStoreOptions];
    
    
    if (![storeCoordinator removePersistentStore:store error:NULL])
            {
            YALogError(@"Unable to remove persistent store %@", error);
            }
    
    [[NSFileManager defaultManager] removeItemAtURL:[store URL] error:&error];
    
    if (error) 
            {
            YALogError(@"error removing persistent store %@ ", error);
            }
        
    if (![storeCoordinator addPersistentStoreWithType:[store type]
                                        configuration:nil
                                                  URL:[store URL]
                                              options:persistentStoreOptions
                                                error:&error])
            {
                YALogError(@"Unable to add persistent store %@", error);
                return NO;
            }
    
    else 
        {
            YALogError(@"Persistent Store Deleted and Recreated Successfully");
            return YES;
        }
}


- (void)reset
{
    NSManagedObjectContext *managedObjectContext = [managedObjectContextFactory_ create];
    
    NSPersistentStoreCoordinator *persistentCoordianator = [managedObjectContext persistentStoreCoordinator];
    
    NSArray *stores = [persistentCoordianator persistentStores];
    
    for (NSPersistentStore *store in stores)
    {
    
        if ([self hardResetContext:managedObjectContext store:store])
        {
        YALogError(@"Reset Succcessful !");
        }
      
    }

}


@end
