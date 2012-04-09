//
//  YARegistrationInfoAddressMetaDataUpdater.m
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YARegistrationInfoAddressMetaDataUpdater.h"

@implementation YARegistrationInfoAddressMetaDataUpdater

@synthesize addressMetaDataHandler = addressMetaDataHandler_;
@synthesize addressMetaDataRepository = addressMetaDataRepository_;
@synthesize registrationInfoResponseParser = registrationInfoResponseParser_;

- (YAAddressMetaData *)updateAddressMetaDataFromNumberRegistrationInfo:(NSDictionary *)numberRegistrationInfo inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSString *handle = [[self registrationInfoResponseParser] handleForNumber:numberRegistrationInfo];
    
    if ([handle length] == 0) 
    {
        return nil;
    }
    
    YAAddressMetaData *addressMetaData = [[self addressMetaDataRepository] addressMetaDataForHandle:handle inManagedObjectContext:managedObjectContext];
    
    if (!addressMetaData) 
    {
        return nil;
    }
    
    NSDictionary *services = [[self registrationInfoResponseParser] servicesForNumber:numberRegistrationInfo];
    
    if (!services) 
    {
        return nil;
    }
    
    BOOL isHub = [[self registrationInfoResponseParser] hasHubService:services];
    BOOL isValidSMS = [[self registrationInfoResponseParser] hasSMSService:services];
    
    [[self addressMetaDataHandler] setHandleIsHub:isHub forAddressMetaData:addressMetaData];
    [[self addressMetaDataHandler] setHandleIsValidSMS:isValidSMS forAddressMetaData:addressMetaData];
    
    return addressMetaData;
}

@end
