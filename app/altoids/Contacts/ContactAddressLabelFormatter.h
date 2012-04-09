//
//  ContactAddressLabelFormatter.h
//  altoids
//
//  Created by Derrick Whittle on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YAContactAddress;

@protocol ContactAddressLabelFormatter <NSObject>

- (NSString*) formattedLabelForAddress:(YAContactAddress*)contactAddress;

@end
