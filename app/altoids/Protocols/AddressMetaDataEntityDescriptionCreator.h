//
//  AddressMetaDataEntityDescriptionCreator.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAAddressMetaData.h"

@protocol AddressMetaDataEntityDescriptionCreator <NSObject>

- (NSEntityDescription *)addressMetaDataEntityDescriptionInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (YAAddressMetaData *)createAddressMetaDataEntityInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
