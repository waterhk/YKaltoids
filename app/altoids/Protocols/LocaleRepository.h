//
//  LocaleRepository.h
//  altoids
//
//  Created by Derrick Whittle on 3/2/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LocaleRepository <NSObject>

@property (nonatomic, strong, readonly) NSString* iso3166RegionCode;

@end
