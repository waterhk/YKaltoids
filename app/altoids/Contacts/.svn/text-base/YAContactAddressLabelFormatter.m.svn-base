//
//  YAContactAddressLabelFormatter.m
//  altoids
//
//  Created by Derrick Whittle on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactAddressLabelFormatter.h"
#import "AddressBook/ABAddressBook.h"
#import "YAContactAddress.h"

@implementation YAContactAddressLabelFormatter

- (NSString*) formattedLabelForAddress:(YAContactAddress*)contactAddress
{
    CFStringRef label = (__bridge CFStringRef)[contactAddress label];    
    CFStringRef formattedLabel = ABAddressBookCopyLocalizedLabel(label);
    return (NSString*)CFBridgingRelease(formattedLabel);
}

@end
