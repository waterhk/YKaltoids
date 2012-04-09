//
//  YAAddressHandleFormatterTests.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "YAAddressHandleFormatter.h"
#import "AddressNormalizer.h"
#import "AddressTypeDetector.h"
#import "YAAddress.h"

@interface YAAddressHandleFormatterTests : YATestCase
{
    YAAddressHandleFormatter* formatter;

    id addressTypeDetectorMock;
    id addressNormalizerMock;
    id smsAddressHandleFormatterMock;
    id emailAddressHandleFormatterMock;

    id testAddress;
    BOOL yes;
    BOOL no;
}
@end


@implementation YAAddressHandleFormatterTests

- (void) setUp
{
    addressTypeDetectorMock = [OCMockObject mockForProtocol:@protocol(AddressTypeDetector)];
    addressNormalizerMock = [OCMockObject mockForProtocol:@protocol(AddressNormalizer)];
    smsAddressHandleFormatterMock = [OCMockObject mockForProtocol:@protocol(AddressHandleFormatter)];
    emailAddressHandleFormatterMock = [OCMockObject mockForProtocol:@protocol(AddressHandleFormatter)];
    
    formatter = [[YAAddressHandleFormatter alloc] init];
    [formatter setAddressNormalizer:addressNormalizerMock];
    [formatter setAddressTypeDetector:addressTypeDetectorMock];
    [formatter setSmsAddressHandleFormatter:smsAddressHandleFormatterMock];
    [formatter setEmailAddressHandleFormatter:emailAddressHandleFormatterMock];
    
    testAddress = [OCMockObject mockForClass:[YAAddress class]];
    yes = YES;
    no = NO;
}


//
// formatAddressHandleForDisplay
//

- (void) testFormatAddressHandleForDisplayShouldReturnSMSFormattedHandleGivenSMSAddress
{
    NSString* expectedResult = @"formatted handle";
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isSMSAddress:testAddress];
    [[[smsAddressHandleFormatterMock expect] andReturn:expectedResult] formatAddressHandleForDisplay:testAddress];

    NSString* result = [formatter formatAddressHandleForDisplay:testAddress];
    STAssertEquals(expectedResult, result, nil);
    [addressTypeDetectorMock verify];
    [smsAddressHandleFormatterMock verify];
}

- (void) testFormatAddressHandleForDisplayShouldReturnSMSFormattedHandleGivenMMCAddressHavingSMSHandle
{
    NSString* expectedResult = @"formatted handle";
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isSMSAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isMMCAddressWithSMSAddressHandle:testAddress];
    [[[smsAddressHandleFormatterMock expect] andReturn:expectedResult] formatAddressHandleForDisplay:testAddress];
    
    NSString* result = [formatter formatAddressHandleForDisplay:testAddress];
    STAssertEquals(expectedResult, result, nil);
    [addressTypeDetectorMock verify];
    [smsAddressHandleFormatterMock verify];
}

- (void) testFormatAddressHandleForDisplayShouldReturnEmailFormattedHandleGivenEmailAddress
{
    NSString* expectedResult = @"formatted handle";
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isSMSAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isMMCAddressWithSMSAddressHandle:OCMOCK_ANY];
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isEmailAddress:testAddress];
    [[[emailAddressHandleFormatterMock expect] andReturn:expectedResult] formatAddressHandleForDisplay:testAddress];
    
    NSString* result = [formatter formatAddressHandleForDisplay:testAddress];
    STAssertEquals(expectedResult, result, nil);
    [addressTypeDetectorMock verify];
    [emailAddressHandleFormatterMock verify];
}

- (void) testFormatAddressHandleForDisplayShouldReturnEmailFormattedHandleGivenMMCAddressHavingEmailHandle
{
    NSString* expectedResult = @"formatted handle";
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isSMSAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isMMCAddressWithSMSAddressHandle:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isEmailAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isMMCAddressWithEmailAddressHandle:testAddress];
    [[[emailAddressHandleFormatterMock expect] andReturn:expectedResult] formatAddressHandleForDisplay:testAddress];
    
    NSString* result = [formatter formatAddressHandleForDisplay:testAddress];
    STAssertEquals(expectedResult, result, nil);
    [addressTypeDetectorMock verify];
    [emailAddressHandleFormatterMock verify];
}

- (void) testFormatAddressHandleForDisplayShouldReturnNilGivenUnrecognizedAddressType
{
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isSMSAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isMMCAddressWithSMSAddressHandle:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isEmailAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isMMCAddressWithEmailAddressHandle:OCMOCK_ANY];
    
    NSString* result = [formatter formatAddressHandleForDisplay:testAddress];
    STAssertNil(result, nil);
}


//
// formatAddressHandleForServerRequest
//

- (void) testFormatAddressHandleForServerRequestShouldReturnSMSFormattedHandleGivenSMSAddress
{
    NSString* expectedResult = @"formatted handle";
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isSMSAddress:testAddress];
    [[[smsAddressHandleFormatterMock expect] andReturn:expectedResult] formatAddressHandleForServerRequest:testAddress];
    
    NSString* result = [formatter formatAddressHandleForServerRequest:testAddress];
    STAssertEquals(expectedResult, result, nil);
    [addressTypeDetectorMock verify];
    [smsAddressHandleFormatterMock verify];
}

- (void) testFormatAddressHandleForServerRequestShouldReturnSMSFormattedHandleGivenMMCAddressHavingSMSHandle
{
    NSString* expectedResult = @"formatted handle";
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isSMSAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isMMCAddressWithSMSAddressHandle:testAddress];
    [[[smsAddressHandleFormatterMock expect] andReturn:expectedResult] formatAddressHandleForServerRequest:testAddress];
    
    NSString* result = [formatter formatAddressHandleForServerRequest:testAddress];
    STAssertEquals(expectedResult, result, nil);
    [addressTypeDetectorMock verify];
    [smsAddressHandleFormatterMock verify];
}

- (void) testFormatAddressHandleForServerRequestShouldReturnEmailFormattedHandleGivenEmailAddress
{
    NSString* expectedResult = @"formatted handle";
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isSMSAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isMMCAddressWithSMSAddressHandle:OCMOCK_ANY];
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isEmailAddress:testAddress];
    [[[emailAddressHandleFormatterMock expect] andReturn:expectedResult] formatAddressHandleForServerRequest:testAddress];
    
    NSString* result = [formatter formatAddressHandleForServerRequest:testAddress];
    STAssertEquals(expectedResult, result, nil);
    [addressTypeDetectorMock verify];
    [emailAddressHandleFormatterMock verify];
}

- (void) testFormatAddressHandleForServerRequestShouldReturnEmailFormattedHandleGivenMMCAddressWithEmailHandle
{
    NSString* expectedResult = @"formatted handle";
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isSMSAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isMMCAddressWithSMSAddressHandle:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isEmailAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isMMCAddressWithEmailAddressHandle:testAddress];
    [[[emailAddressHandleFormatterMock expect] andReturn:expectedResult] formatAddressHandleForServerRequest:testAddress];
    
    NSString* result = [formatter formatAddressHandleForServerRequest:testAddress];
    STAssertEquals(expectedResult, result, nil);
    [addressTypeDetectorMock verify];
    [emailAddressHandleFormatterMock verify];
}

- (void) testFormatAddressHandleForServerRequestShouldReturnNilGivenUnrecognizedAddressType
{
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isSMSAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isMMCAddressWithSMSAddressHandle:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isEmailAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isMMCAddressWithEmailAddressHandle:OCMOCK_ANY];
    
    NSString* result = [formatter formatAddressHandleForServerRequest:testAddress];
    STAssertNil(result, nil);
}

@end
