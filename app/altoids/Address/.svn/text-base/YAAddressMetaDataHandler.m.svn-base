//
//  YAAddressMetaDataHandler.m
//  altoids
//
//  Created by Jon Herron on 1/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAAddressMetaDataHandler.h"

@implementation YAAddressMetaDataHandler

- (NSManagedObjectID *)managedObjectIDForAddressMetaData:(YAAddressMetaData *)addressMetaData
{
    return [addressMetaData objectID];
}

- (NSString *)handleForAddressMetaData:(YAAddressMetaData *)addressMetaData
{
    return [addressMetaData handle];
}

- (NSDate *)timestampForAddressMetaData:(YAAddressMetaData *)addressMetaData
{
    return [addressMetaData timestamp];
}

- (BOOL)handleIsHubForAddressMetaData:(YAAddressMetaData *)addressMetaData
{
    return [[addressMetaData isHub] boolValue];
}

- (BOOL)handleIsValidSMSForAddressMetaData:(YAAddressMetaData *)addressMetaData
{
    return [[addressMetaData isValidSMS] boolValue];
}

- (void)setHandle:(NSString *)handle forAddressMetaData:(YAAddressMetaData *)addressMetaData
{
    [addressMetaData setHandle:handle];
}

- (void)setTimestamp:(NSDate *)timestamp forAddressMetaData:(YAAddressMetaData *)addressMetaData
{
    [addressMetaData setTimestamp:timestamp];
}

- (void)setHandleIsHub:(BOOL)handleIsHub forAddressMetaData:(YAAddressMetaData *)addressMetaData
{
    [addressMetaData setIsHub:[NSNumber numberWithBool:handleIsHub]];
}

- (void)setHandleIsValidSMS:(BOOL)handleIsValidSMS forAddressMetaData:(YAAddressMetaData *)addressMetaData
{
    [addressMetaData setIsValidSMS:[NSNumber numberWithBool:handleIsValidSMS]];
}

@end
