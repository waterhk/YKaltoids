//
//  AccountInfoTests.m
//  SessionManager3
//
//  Created by Lei Cai on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <OCMock/OCMock.h>
#import "AccountInfoTests.h"

@implementation AccountInfoTests

- (void)setUp
{
    accountInfo = [[AccountInfo alloc] init];
}

- (void)tearDown
{
}

- (void)testExpireWithoutExpirationDateSet
{
    STAssertTrue([accountInfo hasExpired], @"Unexpected return value");
}

- (void)testExpireWithExpirationDateSetToDateBeforeCurrentDate
{
    accountInfo.expirationDate = [NSDate dateWithTimeIntervalSinceNow:-1000];
    STAssertTrue([accountInfo hasExpired], @"Unexpected return value");
}

- (void)testExpireWithExpirationDateSetToDateAfterCurrentDate
{
    accountInfo.expirationDate = [NSDate dateWithTimeIntervalSinceNow:1000];
    STAssertFalse([accountInfo hasExpired], @"Unexpected return value");
}


@end
