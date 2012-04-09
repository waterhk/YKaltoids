//
//  AddressMetaDataRepository.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAAddressMetaData.h"

@protocol AddressMetaDataRepository <NSObject>

- (YAAddressMetaData *)addressMetaDataForHandle:(NSString *)handle inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (NSDictionary *)addressMetaDatasByHandleForHandles:(NSArray *)handles inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (BOOL)saveAddressMetaDatas:(NSArray *)addressMetaDatas inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)error;

@end
