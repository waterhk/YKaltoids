//
//  AddressHandleFormatter.h
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAAddress.h"

@protocol AddressHandleFormatter <NSObject>

- (NSString *)formatAddressHandleForDisplay:(YAAddress *)theAddress;
- (NSString *)formatAddressHandleForServerRequest:(YAAddress *)theAddress;

@end
