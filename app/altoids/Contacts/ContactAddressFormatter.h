//
//  ContactAddressFormatter.h
//  altoids
//
//  Created by Derrick Whittle on 2/21/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YAContactAddress;

@protocol ContactAddressFormatter <NSObject>

- (NSString*) formattedAddressAndLabel:(YAContactAddress*)address;

@end
