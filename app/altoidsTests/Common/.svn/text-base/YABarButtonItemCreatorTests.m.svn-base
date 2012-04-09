//
//  YABarButtonItemCreatorTests.m
//  altoids
//
//  Created by Derrick Whittle on 1/19/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>

#import "YABarButtonItemCreator.h"


@interface YABarButtonItemCreatorTests : SenTestCase
{
    YABarButtonItemCreator* creator;
}
@end


@implementation YABarButtonItemCreatorTests

- (void)setUp
{
    creator = [[YABarButtonItemCreator alloc] init];
}


- (void)testCreateWithCustomViewShouldReturnBarButtonItemHavingGivenView
{
    UIView* stubView = [UIView alloc];

    UIBarButtonItem* result = [creator createBarButtonItemWithCustomView:stubView];

    STAssertEqualObjects(stubView, [result customView], @"unexpected custom view for created bar button item");
}

@end
