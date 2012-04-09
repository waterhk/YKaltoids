//
//  YARegistrationInfoAddressMetaDataUpdater.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "RegistrationInfoAddressMetaDataUpdater.h"
#import "AddressMetaDataHandler.h"
#import "AddressMetaDataRepository.h"
#import "RegistrationInfoResponseParser.h"

@interface YARegistrationInfoAddressMetaDataUpdater : NSObject <RegistrationInfoAddressMetaDataUpdater>

@property (strong, nonatomic) id<AddressMetaDataHandler> addressMetaDataHandler;
@property (strong, nonatomic) id<AddressMetaDataRepository> addressMetaDataRepository;
@property (strong, nonatomic) id<RegistrationInfoResponseParser> registrationInfoResponseParser;

@end
