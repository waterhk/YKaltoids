//
//  YAContactEndpointLocator.h
//  altoids
//
//  Created by Derrick Whittle on 3/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactEndpointLocator.h"
@protocol PhoneNumberNormalizer;

@interface YAContactEndpointLocator : NSObject <ContactEndpointLocator>

@property (nonatomic, strong) id<PhoneNumberNormalizer> phoneNumberNormalizer;

@end
