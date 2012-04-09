//
//  YAMMCAddressInfo.h
//  altoids
//
//  Created by Jon Herron on 11/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAAddressInfo.h"

@interface YAMMCAddressInfo : YAAddressInfo

// NOTE Use AddressInfoCreator to create YAMMCAddressInfo objects to ensure proper normalization handling (see Address Normalization.md).
- (id) initWithNormalizedMMCAddress:(NSString*)normalizedMMCAddress;

@end
