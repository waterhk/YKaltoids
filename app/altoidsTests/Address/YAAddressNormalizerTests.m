//
//  YAAddressNormalizerTests.m
//  altoids
//
//  Created by Derrick Whittle on 3/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "YAAddressNormalizer.h"
#import "AddressTypeDetector.h"
#import "AddressNormalizer.h"
#import "YAAddress.h"


@interface YAAddressNormalizerTests : YATestCase
{
    YAAddressNormalizer* normalizer;

    id addressTypeDetectorMock;
    id smsAddressNormalizerMock;

    id testAddress;
    BOOL yes;
    BOOL no;
}
@end

@implementation YAAddressNormalizerTests

- (void) setUp
{
    addressTypeDetectorMock = [OCMockObject mockForProtocol:@protocol(AddressTypeDetector)];
    smsAddressNormalizerMock = [OCMockObject mockForProtocol:@protocol(AddressNormalizer)];

    normalizer = [[YAAddressNormalizer alloc] init];
    [normalizer setAddressTypeDetector:addressTypeDetectorMock];
    [normalizer setSmsAddressNormalizer:smsAddressNormalizerMock];

    testAddress = [OCMockObject mockForClass:[YAAddress class]];
    yes = YES;
    no = NO;
}


//
// normalizeAddress
//

- (void) testNormalizeAddressShouldReturnSMSNormalizedAddressGivenSMSAddress
{
    NSString* expectedResult = @"normalized address";
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isSMSAddress:testAddress];
    [[[smsAddressNormalizerMock expect] andReturn:expectedResult] normalizeAddress:testAddress];

    NSString* result = [normalizer normalizeAddress:testAddress];
    STAssertEquals(expectedResult, result, nil);
    [addressTypeDetectorMock verify];
    [smsAddressNormalizerMock verify];
}

- (void) testNormalizeAddressShouldReturnSMSNormalizedAddressGivenMMCAddressHavingSMSHandle
{
    NSString* expectedResult = @"normalized address";
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isSMSAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isMMCAddressWithSMSAddressHandle:testAddress];
    [[[smsAddressNormalizerMock expect] andReturn:expectedResult] normalizeAddress:testAddress];
    
    NSString* result = [normalizer normalizeAddress:testAddress];
    STAssertEquals(expectedResult, result, nil);
    [addressTypeDetectorMock verify];
    [smsAddressNormalizerMock verify];
}

- (void) testNormalizeAddressShouldReturnNilGivenUnrecognizedAddressType
{
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isSMSAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isMMCAddressWithSMSAddressHandle:OCMOCK_ANY];
    
    NSString* result = [normalizer normalizeAddress:testAddress];
    STAssertNil(result, nil);
}


@end
