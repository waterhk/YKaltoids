//
//  YAAddressTypeDetectorTests.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "YAAddressTypeDetector.h"
#import "AddressHandler.h"
#import "YAAddress.h"
#import "YAMMCAddressInfo.h"
#import "YASMSAddressInfo.h"
#import "YAEmailAddressInfo.h"


@interface YAAddressTypeDetectorTests : YATestCase
{
    YAAddressTypeDetector* addressTypeDetector;

    id addressHandlerMock;

    YAAddress* testAddress;
    YAMMCAddressInfo* testMMCAddressInfo;
    YASMSAddressInfo* testSMSAddressInfo;
    YAEmailAddressInfo* testEmailAddressInfo;

    BOOL yes, no;   // OCMOCK_VALUE needs references to scalars, not literals
}

@end


@implementation YAAddressTypeDetectorTests

- (void) setUp
{
    addressHandlerMock = [OCMockObject mockForProtocol:@protocol(AddressHandler)];

    addressTypeDetector = [[YAAddressTypeDetector alloc] init];
    [addressTypeDetector setAddressHandler:addressHandlerMock];

    testAddress = [OCMockObject mockForClass:[YAAddress class]];
    testMMCAddressInfo = [[YAMMCAddressInfo alloc] init];
    testSMSAddressInfo = [[YASMSAddressInfo alloc] init];
    testEmailAddressInfo = [[YAEmailAddressInfo alloc] init];

    yes = YES;
    no = NO;
}


//
// MMC address
//

- (void) testIsMMCAddressShouldReturnYesOnlyWhenGivenMMCAddress
{
    [[[addressHandlerMock expect] andReturnValue:OCMOCK_VALUE(yes)] isMMCAddressType:testAddress];
    STAssertTrue([addressTypeDetector isMMCAddress:testAddress], nil);
    
    [[[addressHandlerMock expect] andReturnValue:OCMOCK_VALUE(no)] isMMCAddressType:testAddress];
    STAssertFalse([addressTypeDetector isMMCAddress:testAddress], nil);
    
    [addressHandlerMock verify];
}

- (void) testIsMMCAddressInfoShouldReturnYesOnlyWhenGivenMMCAddressInfo
{
    STAssertTrue([addressTypeDetector isMMCAddressInfo:testMMCAddressInfo], nil);
    STAssertFalse([addressTypeDetector isMMCAddressInfo:testSMSAddressInfo], nil);
    STAssertFalse([addressTypeDetector isMMCAddressInfo:testEmailAddressInfo], nil);
}

- (void) testIsMMCMMCAddressTypeReturnsYesOnlyWhenGivenMMCAddressType
{
    STAssertTrue([addressTypeDetector isMMCMMCAddressType:@"mmc"], nil);
    STAssertFalse([addressTypeDetector isMMCMMCAddressType:@"sms"], nil);
    STAssertFalse([addressTypeDetector isMMCMMCAddressType:@"email"], nil);
}


//
// SMS address
//

- (void) testIsSMSAddressShouldReturnYesOnlyWhenGivenSMSAddress
{
    [[[addressHandlerMock expect] andReturnValue:OCMOCK_VALUE(yes)] isSMSAddressType:testAddress];
    STAssertTrue([addressTypeDetector isSMSAddress:testAddress], nil);
    
    [[[addressHandlerMock expect] andReturnValue:OCMOCK_VALUE(no)] isSMSAddressType:testAddress];
    STAssertFalse([addressTypeDetector isSMSAddress:testAddress], nil);

    [addressHandlerMock verify];
}

- (void) testIsSMSAddressInfoShouldReturnYesOnlyWhenGivenSMSAddressInfo
{
    STAssertFalse([addressTypeDetector isSMSAddressInfo:testMMCAddressInfo], nil);
    STAssertTrue([addressTypeDetector isSMSAddressInfo:testSMSAddressInfo], nil);
    STAssertFalse([addressTypeDetector isSMSAddressInfo:testEmailAddressInfo], nil);
}

- (void) testIsSMSMMCAddressTypeReturnsYesOnlyWhenGivenSMSAddressType
{
    STAssertFalse([addressTypeDetector isSMSMMCAddressType:@"mmc"], nil);
    STAssertTrue([addressTypeDetector isSMSMMCAddressType:@"sms"], nil);
    STAssertFalse([addressTypeDetector isSMSMMCAddressType:@"email"], nil);
}


//
// email address
//

- (void) testIsEmailAddressShouldReturnYesOnlyWhenGivenEmailAddress
{
    [[[addressHandlerMock expect] andReturnValue:OCMOCK_VALUE(yes)] isEmailAddressType:testAddress];
    STAssertTrue([addressTypeDetector isEmailAddress:testAddress], nil);

    [[[addressHandlerMock expect] andReturnValue:OCMOCK_VALUE(no)] isEmailAddressType:testAddress];
    STAssertFalse([addressTypeDetector isEmailAddress:testAddress], nil);

    [addressHandlerMock verify];
}

- (void) testIsEmailAddressInfoShouldReturnYesOnlyWhenGivenEmailAddressInfo
{
    STAssertFalse([addressTypeDetector isEmailAddressInfo:testMMCAddressInfo], nil);
    STAssertFalse([addressTypeDetector isEmailAddressInfo:testSMSAddressInfo], nil);
    STAssertTrue([addressTypeDetector isEmailAddressInfo:testEmailAddressInfo], nil);
}

- (void) testIsEmailMMCAddressTypeReturnsYesOnlyWhenGivenEmailAddressType
{
    STAssertFalse([addressTypeDetector isEmailMMCAddressType:@"mmc"], nil);
    STAssertFalse([addressTypeDetector isEmailMMCAddressType:@"sms"], nil);
    STAssertTrue([addressTypeDetector isEmailMMCAddressType:@"email"], nil);
}


@end
