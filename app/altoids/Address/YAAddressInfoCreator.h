//
//  YAAddressInfoCreator.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressInfoCreator.h"
@protocol AddressHandler, AddressTypeDetector, PhoneNumberNormalizer;


@interface YAAddressInfoCreator : NSObject<AddressInfoCreator>

@property (nonatomic, strong) id<AddressHandler> addressHandler;
@property (nonatomic, strong) id<AddressTypeDetector> addressTypeDetector;
@property (nonatomic, strong) id<PhoneNumberNormalizer> phoneNumberNormalizer;

@end
