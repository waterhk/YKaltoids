//
//  YAAddressMetaDataUpdater.h
//  altoids
//
//  Created by Jon Herron on 2/14/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "AddressMetaDataUpdater.h"

@protocol AddressMetaDataHandler;
@protocol AddressMetaDataRepository;
@protocol AddressTypeDetector;
@protocol ParticipantAggregator;

@interface YAAddressMetaDataUpdater : NSObject <AddressMetaDataUpdater>

@property (strong, nonatomic) id<AddressMetaDataHandler> addressMetaDataHandler;
@property (strong, nonatomic) id<AddressMetaDataRepository> addressMetaDataRepository;
@property (strong, nonatomic) id<AddressTypeDetector> addressTypeDetector;
@property (strong, nonatomic) id<ParticipantAggregator> participantAggregator;

@end
