//
//  YAAddressHandleFormatter.h
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressHandleFormatter.h"
@protocol AddressTypeDetector, AddressNormalizer;

@interface YAAddressHandleFormatter : NSObject <AddressHandleFormatter>

@property (strong, nonatomic) id<AddressTypeDetector> addressTypeDetector;
@property (strong, nonatomic) id<AddressNormalizer> addressNormalizer;

@property (strong, nonatomic) id<AddressHandleFormatter> smsAddressHandleFormatter;
@property (strong, nonatomic) id<AddressHandleFormatter> emailAddressHandleFormatter;

@end
