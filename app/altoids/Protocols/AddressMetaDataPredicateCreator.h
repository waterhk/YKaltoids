//
//  AddressMetaDataPredicateCreator.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddressMetaDataPredicateCreator <NSObject>

- (NSPredicate *)predicateMatchingAddressMetaDataWithHandle:(NSString *)handle;
- (NSPredicate *)predicateMatchingAddressMetaDatasWithHandles:(NSArray *)handles;

@end
