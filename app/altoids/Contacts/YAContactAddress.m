//
//  YAContactAddress.m
//  altoids
//
//  Created by Derrick Whittle on 2/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactAddress.h"


// do not directly instantiate YAContactAddress (this is an abstract base class);
// instead, instantiate a YAContact{PhoneNumber,Email}Address instead

@implementation YAContactAddress

@synthesize label = label_;


- (id) initWithLabel:(NSString*)label
{
    self = [super init];
    if(self)
    {
        label_ = label;
    }
    return self;
}

@end
