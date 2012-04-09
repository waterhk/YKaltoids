//
//  YASMSAddressTest.m
//  altoids
//
//  Created by Jon Herron on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YASMSAddressInfoTests.h"
#import "YASMSAddressInfo.h"

@implementation YASMSAddressInfoTests

- (void)testProvidesAccessToTheSameHandleGivenDuringInitialization
{
    NSString *handle = @"4042134512";
    YASMSAddressInfo *smsAddress = [[YASMSAddressInfo alloc] initWithYE164PhoneNumber:handle];
    
    
    STAssertEquals(handle, [smsAddress handle], @"Unexpected handle returned from smsAddress");
}

@end
