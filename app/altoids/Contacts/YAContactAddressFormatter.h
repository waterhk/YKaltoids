//
//  YAContactAddressFormatter.h
//  altoids
//
//  Created by Derrick Whittle on 2/21/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactAddressFormatter.h"
@protocol ContactAddressLabelFormatter;

@interface YAContactAddressFormatter : NSObject <ContactAddressFormatter>

@property (nonatomic, strong) id<ContactAddressLabelFormatter> contactAddressLabelFormatter;

@end
