//
//  EntityDescriptionCreator.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressMetaDataEntityDescriptionCreator.h"

@protocol EntityDescriptionCreator <AddressMetaDataEntityDescriptionCreator>

- (id)createEntityForName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (NSEntityDescription *)entityForName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
