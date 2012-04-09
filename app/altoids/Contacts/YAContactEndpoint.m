//
//  YAContactEndpoint.m
//  altoids
//
//  Created by Derrick Whittle on 2/21/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactEndpoint.h"

@implementation YAContactEndpoint

@synthesize contact = contact_,
            address = address_;

- (id) initWithContact:(YAContact*)contact address:(YAContactAddress*)address
{
    self = [super init];
    if(self)
    {
        contact_ = contact;
        address_ = address;
    }
    return self;
}


@end
