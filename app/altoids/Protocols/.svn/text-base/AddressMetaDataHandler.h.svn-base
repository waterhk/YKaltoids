//
//  AddressMetaDataHandler.h
//  altoids
//
//  Created by Jon Herron on 1/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAAddressMetaData.h"

@protocol AddressMetaDataHandler <NSObject>

- (NSManagedObjectID *)managedObjectIDForAddressMetaData:(YAAddressMetaData *)addressMetaData;

- (NSString *)handleForAddressMetaData:(YAAddressMetaData *)addressMetaData;
- (NSDate *)timestampForAddressMetaData:(YAAddressMetaData *)addressMetaData;
- (BOOL)handleIsHubForAddressMetaData:(YAAddressMetaData *)addressMetaData;
- (BOOL)handleIsValidSMSForAddressMetaData:(YAAddressMetaData *)addressMetaData;

- (void)setHandle:(NSString *)handle forAddressMetaData:(YAAddressMetaData *)addressMetaData;
- (void)setTimestamp:(NSDate *)timestamp forAddressMetaData:(YAAddressMetaData *)addressMetaData;
- (void)setHandleIsHub:(BOOL)handleIsHub forAddressMetaData:(YAAddressMetaData *)addressMetaData;
- (void)setHandleIsValidSMS:(BOOL)handleIsValidSMS forAddressMetaData:(YAAddressMetaData *)addressMetaData;

@end
