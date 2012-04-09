//
//  YAAddressMetaDataRepository.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "AddressMetaDataRepository.h"
#import "AddressMetaDataEntityDescriptionCreator.h"
#import "AddressMetaDataFetchRequestRepository.h"
#import "AddressMetaDataHandler.h"

@protocol MutableDictionaryCreator;

@interface YAAddressMetaDataRepository : NSObject <AddressMetaDataRepository>

@property (strong, nonatomic) id<AddressMetaDataHandler> addressMetaDataHandler;
@property (strong, nonatomic) id<AddressMetaDataEntityDescriptionCreator> entityDescriptionCreator;
@property (strong, nonatomic) id<AddressMetaDataFetchRequestRepository> fetchRequestRepository;
@property (strong, nonatomic) id<MutableDictionaryCreator> mutableDictionaryCreator;

@end
