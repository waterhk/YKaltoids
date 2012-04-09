//
//  YAPhoneNumberNormalizer.h
//  altoids
//
//  Created by Derrick Whittle on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhoneNumberNormalizer.h"
@protocol LocaleRepository, LibPhoneNumberUtil;

@interface YAPhoneNumberNormalizer : NSObject <PhoneNumberNormalizer>

@property (nonatomic, strong) id<LocaleRepository> localeRepository;
@property (nonatomic, strong) id<LibPhoneNumberUtil> libPhoneNumberUtil;

@end
