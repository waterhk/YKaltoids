//
//  YACachingPhoneNumberNormalizer.m
//  altoids
//
//  Created by Derrick Whittle on 2/23/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "YACachingPhoneNumberNormalizer.h"

@interface YACachingPhoneNumberNormalizerTests : SenTestCase
{
    YACachingPhoneNumberNormalizer* cachingPhoneNumberNormalizer;
    id nonCachingPhoneNumberNormalizer;
    id cache;
    id memoryWarningNotificationCenter;
}
@end


@implementation YACachingPhoneNumberNormalizerTests

- (void) setUp
{
    nonCachingPhoneNumberNormalizer = [OCMockObject mockForProtocol:@protocol(PhoneNumberNormalizer)];
    cache = [OCMockObject mockForClass:[NSMutableDictionary class]];
    memoryWarningNotificationCenter = [OCMockObject mockForClass:[NSNotificationCenter class]];
    
    cachingPhoneNumberNormalizer = [[YACachingPhoneNumberNormalizer alloc] init];
    [cachingPhoneNumberNormalizer setNonCachingPhoneNumberNormalizer:nonCachingPhoneNumberNormalizer];
    [cachingPhoneNumberNormalizer setYe164FormatCache:cache];
}


//
// normalizePhoneNumber
//

- (void) testYE164FormatForPhoneNumberShouldReturnCachedResultWithoutPerformingFormatting
{
    NSString* raw = @"raw";
    NSString* expectedFormatted = @"formatted";

    [[[cache expect] andReturn:expectedFormatted] objectForKey:raw];

    NSString* formatted = [cachingPhoneNumberNormalizer ye164FormatForPhoneNumber:raw];
    STAssertEqualObjects(expectedFormatted, formatted, nil);    
    [cache verify];
}

- (void) testYE164FormatForPhoneNumberShouldFormatGivenNumberAndAddToCacheAndReturnUponCacheMiss
{
    NSString* raw = @"raw";
    NSString* expectedFormatted = @"formatted";
    
    [[[cache expect] andReturn:nil] objectForKey:raw];
    [[[nonCachingPhoneNumberNormalizer expect] andReturn:expectedFormatted] ye164FormatForPhoneNumber:raw];
    [[cache expect] setObject:expectedFormatted forKey:raw];

    NSString* formatted = [cachingPhoneNumberNormalizer ye164FormatForPhoneNumber:raw];
    STAssertEqualObjects(expectedFormatted, formatted, nil);
    [cache verify];
    [nonCachingPhoneNumberNormalizer verify];
}

//
// comparisonFormatForPhoneNumber
//

- (void) testComparisonFormatForPhoneNumberShouldFormatGivenNumberWithoutConsultingCache
{
    NSString* raw = @"raw";
    NSString* expectedFormatted = @"formatted";
    
    [[[nonCachingPhoneNumberNormalizer expect] andReturn:expectedFormatted] comparisonFormatForPhoneNumber:raw];

    NSString* formatted = [cachingPhoneNumberNormalizer comparisonFormatForPhoneNumber:raw];
    STAssertEqualObjects(expectedFormatted, formatted, nil);
    [nonCachingPhoneNumberNormalizer verify];
}

//
// didReceiveMemoryWarningFromNotificationCenter
//

- (void) testDidReceiveMemoryWarningFromNotificationCenterShouldClearCache
{
    [[cache expect] removeAllObjects];
    
    [cachingPhoneNumberNormalizer didReceiveMemoryWarningFromNotificationCenter:memoryWarningNotificationCenter];
    [cache verify];
}

//
// setMemoryWarningNotificationCenter
//

- (void) testSetMemoryWarningNotificationCenterShouldAssignPropertyAndAddSelfAsObserverForMemoryWarning
{
    [[memoryWarningNotificationCenter expect] addObserver:cachingPhoneNumberNormalizer selector:@selector(didReceiveMemoryWarningFromNotificationCenter:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];

    [cachingPhoneNumberNormalizer setMemoryWarningNotificationCenter:memoryWarningNotificationCenter];
    STAssertEquals(memoryWarningNotificationCenter, [cachingPhoneNumberNormalizer memoryWarningNotificationCenter], nil);
    [memoryWarningNotificationCenter verify];
}

//
// dealloc
//

- (void) testDeallocShouldRemoveSelfAsObserverFromNotificationCenter
{
    [[memoryWarningNotificationCenter stub] addObserver:OCMOCK_ANY selector:@selector(didReceiveMemoryWarningFromNotificationCenter:) name:OCMOCK_ANY object:OCMOCK_ANY];
    [cachingPhoneNumberNormalizer setMemoryWarningNotificationCenter:memoryWarningNotificationCenter];
    
    // we should expect removeObserver:cachingPhoneNumberNormalizer,
    // but that would retain cachingPhoneNumberNormalizer, so dealloc would never get called
    [[memoryWarningNotificationCenter expect] removeObserver:OCMOCK_ANY];
    
    cachingPhoneNumberNormalizer = nil;         // release for dealloc
    [memoryWarningNotificationCenter verify];    
}

@end
