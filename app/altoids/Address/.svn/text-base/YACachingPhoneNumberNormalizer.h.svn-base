//
//  YACachingPhoneNumberNormalizer.h
//  altoids
//
//  Created by Derrick Whittle on 2/22/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhoneNumberNormalizer.h"
@protocol PhoneNumberNormalizer;

@interface YACachingPhoneNumberNormalizer : NSObject <PhoneNumberNormalizer>

@property (nonatomic, strong) id<PhoneNumberNormalizer> nonCachingPhoneNumberNormalizer;
@property (nonatomic, strong) NSMutableDictionary* ye164FormatCache;        // [NSString* raw => NSString* ye164Format]
@property (nonatomic, strong) NSMutableDictionary* comparisonFormatCache;   // [NSString* raw => NSString* comparisonFormat]
@property (nonatomic, strong) NSNotificationCenter* memoryWarningNotificationCenter;

- (void) didReceiveMemoryWarningFromNotificationCenter:(NSNotificationCenter*)notificationCenter;

@end
