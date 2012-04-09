//
//  YAAddressMetaDataRepository.m
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAAddressMetaDataRepository.h"
#import "MutableDictionaryCreator.h"

@interface YAAddressMetaDataRepository ()

- (YAAddressMetaData *)createAddressMetaDataWithHandle:(NSString *)handle inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end

@implementation YAAddressMetaDataRepository

@synthesize addressMetaDataHandler = addressMetaDataHandler_;
@synthesize entityDescriptionCreator = entityDescriptionCreator_;
@synthesize fetchRequestRepository = fetchRequestRepository_;
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;

- (YAAddressMetaData *)addressMetaDataForHandle:(NSString *)handle inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if ([handle length] == 0 || !managedObjectContext) 
    {
        return nil;
    }
    
    NSFetchRequest *addressMetaDataFetchRequest;
    
    addressMetaDataFetchRequest = [[self fetchRequestRepository] fetchRequestForAddressMetaDataWithHandle:handle inManagedObjectContext:managedObjectContext];
    
    NSArray *addressMetaDatas;
    NSError *error;
    
    addressMetaDatas = [managedObjectContext executeFetchRequest:addressMetaDataFetchRequest error:&error];
    
    if (!addressMetaDatas) 
    {
        return nil;
    }
    
    if ([addressMetaDatas count] > 0) 
    {
        return [addressMetaDatas objectAtIndex:0];
    }
    
    return [self createAddressMetaDataWithHandle:handle inManagedObjectContext:managedObjectContext];
}

- (NSDictionary *)addressMetaDatasByHandleForHandles:(NSArray *)handles inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSUInteger handlesCount = [handles count];
    
    if (handlesCount == 0 || !managedObjectContext) 
    {
        return nil;
    }
    
    NSFetchRequest *addressMetaDatasFetchRequest = [[self fetchRequestRepository] fetchRequestForAddressMetaDatasWithHandles:handles inManagedObjectContext:managedObjectContext];
    
    if (!addressMetaDatasFetchRequest) 
    {
        return nil;
    }
    
    NSError *error;
    NSArray *addressMetaDatas = [managedObjectContext executeFetchRequest:addressMetaDatasFetchRequest error:&error];
    
    if (!addressMetaDatas) 
    {
        return nil;
    }
    
    NSMutableDictionary *addressMetaDatasByHandle = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:handlesCount];
    
    for (YAAddressMetaData *addressMetaData in addressMetaDatas) 
    {
        NSString *addressMetaDataHandle = [[self addressMetaDataHandler] handleForAddressMetaData:addressMetaData];
        
        [addressMetaDatasByHandle setObject:addressMetaData forKey:addressMetaDataHandle];
    }
    
    for (NSString *handle in handles) 
    {
        if ([addressMetaDatasByHandle objectForKey:handle]) 
        {
            continue;
        }
        
        YAAddressMetaData *addressMetaData = [self createAddressMetaDataWithHandle:handle inManagedObjectContext:managedObjectContext];
        
        [addressMetaDatasByHandle setObject:addressMetaData forKey:handle];
    }
    
    return addressMetaDatasByHandle;
}

- (BOOL)saveAddressMetaDatas:(NSArray *)addressMetaDatas inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError *__autoreleasing *)error
{
    return [managedObjectContext save:error];
}

- (YAAddressMetaData *)createAddressMetaDataWithHandle:(NSString *)handle inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    YAAddressMetaData *addressMetaData = [[self entityDescriptionCreator] createAddressMetaDataEntityInManagedObjectContext:managedObjectContext];
    
    if (!addressMetaData) 
    {
        return nil;
    }
    
    [[self addressMetaDataHandler] setHandle:handle forAddressMetaData:addressMetaData];
    
    return addressMetaData;
}

@end
