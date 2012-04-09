//
//  AddressMetaDataFetchRequestRepository.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddressMetaDataFetchRequestRepository <NSObject>

- (NSFetchRequest *)fetchRequestForAddressMetaDataWithHandle:(NSString *)handle inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (NSFetchRequest *)fetchRequestForAddressMetaDatasWithHandles:(NSArray *)handles inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
