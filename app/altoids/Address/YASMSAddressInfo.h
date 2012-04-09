//
//  YASMSAddress.h
//  altoids
//
//  Created by Jon Herron on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAAddressInfo.h"

@interface YASMSAddressInfo : YAAddressInfo

// NOTE Use AddressInfoCreator to create YASMSAddressInfo objects to ensure proper normalization handling (see Address Normalization.md).
- (id) initWithYE164PhoneNumber:(NSString*)ye164PhoneNumber;

@end
