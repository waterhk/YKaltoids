//
//  AddressInfoCreator.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YAAddressInfo, YAAddress, YAMMCParticipant;


@protocol AddressInfoCreator <NSObject>

- (YAAddressInfo*) addressInfoWithAddress:(YAAddress*)address;
- (YAAddressInfo*) addressInfoWithMMCParticipant:(YAMMCParticipant*)mmcParticipant;

- (YAAddressInfo*) addressInfoWithRawPhoneNumber:(NSString*)rawPhoneNumber;
- (YAAddressInfo*) addressInfoWithYE164PhoneNumber:(NSString*)ye164PhoneNumber;

@end
