//
//  YAAddressNormalizer.h
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressNormalizer.h"
@protocol AddressTypeDetector;

@interface YAAddressNormalizer : NSObject <AddressNormalizer>

@property (strong, nonatomic) id<AddressTypeDetector> addressTypeDetector;
@property (strong, nonatomic) id<AddressNormalizer> smsAddressNormalizer;

@end
