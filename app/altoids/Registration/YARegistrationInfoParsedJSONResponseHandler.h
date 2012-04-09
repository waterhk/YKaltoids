//
//  YARegistrationInfoParsedJSONResponseHandler.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "RegistrationInfoParsedJSONResponseHandler.h"
#import "AddressMetaDataHandler.h"
#import "AddressMetaDataRepository.h"
#import "ManagedObjectContextFactory.h"
#import "MutableArrayCreator.h"
#import "MutableDictionaryCreator.h"
#import "RegistrationInfoAddressMetaDataUpdater.h"
#import "RegistrationInfoCommandDelegate.h"
#import "RegistrationInfoResponseParser.h"

@interface YARegistrationInfoParsedJSONResponseHandler : NSObject <RegistrationInfoParsedJSONResponseHandler>

@property (strong, nonatomic) id<AddressMetaDataHandler> addressMetaDataHandler;
@property (strong, nonatomic) id<AddressMetaDataRepository> addressMetaDataRepository;
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;
@property (strong, nonatomic) id<MutableDictionaryCreator> mutableDictionaryCreator;
@property (strong, nonatomic) id<RegistrationInfoAddressMetaDataUpdater> registrationInfoAddressMetaDataUpdater;
@property (strong, nonatomic) id<RegistrationInfoResponseParser> registrationInfoResponseParser;

- (id)initWithDelegate:(id<RegistrationInfoCommandDelegate>)delegate;

@end
