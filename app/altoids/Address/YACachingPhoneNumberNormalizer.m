//
//  YACachingPhoneNumberNormalizer.m
//  altoids
//
//  Created by Derrick Whittle on 2/22/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YACachingPhoneNumberNormalizer.h"
#import "PhoneNumberNormalizer.h"

@implementation YACachingPhoneNumberNormalizer

@synthesize nonCachingPhoneNumberNormalizer = nonCachingPhoneNumberNormalizer_,
            ye164FormatCache = ye164FormatCache_,
            comparisonFormatCache = comparisonFormatCache_,
            memoryWarningNotificationCenter = memoryWarningNotificationCenter_;


- (NSString*) ye164FormatForPhoneNumber:(NSString*)phoneNumber
{
    NSString* ye164FormattedPhoneNumber = [ye164FormatCache_ objectForKey:phoneNumber];
    if(ye164FormattedPhoneNumber)
    {
        return ye164FormattedPhoneNumber;
    }
    
    ye164FormattedPhoneNumber = [nonCachingPhoneNumberNormalizer_ ye164FormatForPhoneNumber:phoneNumber];
    [ye164FormatCache_ setObject:ye164FormattedPhoneNumber forKey:phoneNumber];
    return ye164FormattedPhoneNumber;
}

- (NSString*) comparisonFormatForPhoneNumber:(NSString*)phoneNumber
{
    NSString* comparisonFormattedNumber = [comparisonFormatCache_ objectForKey:phoneNumber];
    if(comparisonFormattedNumber)
    {
        return comparisonFormattedNumber;
    }
    
    comparisonFormattedNumber = [nonCachingPhoneNumberNormalizer_ comparisonFormatForPhoneNumber:phoneNumber];
    [comparisonFormatCache_ setObject:comparisonFormattedNumber forKey:phoneNumber];
    return comparisonFormattedNumber;
}

- (void) didReceiveMemoryWarningFromNotificationCenter:(NSNotificationCenter*)notificationCenter
{
    [ye164FormatCache_ removeAllObjects];
    [comparisonFormatCache_ removeAllObjects];
}

- (void) setMemoryWarningNotificationCenter:(NSNotificationCenter*)memoryWarningNotificationCenter
{
    memoryWarningNotificationCenter_ = memoryWarningNotificationCenter;
    [memoryWarningNotificationCenter addObserver:self selector:@selector(didReceiveMemoryWarningFromNotificationCenter:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

 - (void) dealloc
{
    [memoryWarningNotificationCenter_ removeObserver:self];
}

@end
