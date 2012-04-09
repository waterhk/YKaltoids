//
//  AddressTypeDetector.h
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YAAddress, YAAddressInfo;

@protocol AddressTypeDetector <NSObject>

- (BOOL)isEmailAddress:(YAAddress *)theAddress;
- (BOOL)isEmailAddressInfo:(YAAddressInfo *)addressInfo;
- (BOOL)isEmailMMCAddressType:(NSString *)mmcAddressType;

- (BOOL)isMMCAddress:(YAAddress *)theAddress;
- (BOOL)isMMCAddressInfo:(YAAddressInfo *)addressInfo;
- (BOOL)isMMCMMCAddressType:(NSString *)mmcAddressType;

- (BOOL)isSMSAddress:(YAAddress *)theAddress;
- (BOOL)isSMSAddressInfo:(YAAddressInfo *)addressInfo;
- (BOOL)isSMSMMCAddressType:(NSString *)mmcAddressType;

- (BOOL)isMMCAddressWithEmailAddressHandle:(YAAddress *)theAddress;
- (BOOL)isMMCAddressInfoWithEmailAddressHandle:(YAAddressInfo *)addressInfo;

- (BOOL)isMMCAddressWithSMSAddressHandle:(YAAddress *)theAddress;
- (BOOL)isMMCAddressInfoWithSMSAddressHandle:(YAAddressInfo *)addressInfo;

@end
