//
//  YAAddressInfoCreatorTests.m
//  altoids
//
//  Created by Derrick Whittle on 3/18/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "YAAddressInfoCreator.h"
#import "AddressHandler.h"
#import "AddressTypeDetector.h"
#import "PhoneNumberNormalizer.h"
#import "YAAddressInfo.h"
#import "YASMSAddressInfo.h"
#import "YAMMCAddressInfo.h"
#import "YAEmailAddressInfo.h"
#import "YAAddress.h"
#import "YAMMCParticipant.h"


@interface YAAddressInfoCreatorTests : YATestCase
{
    YAAddressInfoCreator* addressInfoCreator;

    id addressHandlerMock;
    id addressTypeDetectorMock;
    id phoneNumberNormalizerMock;

    YAAddress* testAddress;
    YAMMCParticipant* testMMCParticipant;
    NSString* testAddressHandle;
    NSString* testAddressType;

    BOOL yes, no;   // OCMOCK_VALUE needs references to scalars, not literals
}
@end


@implementation YAAddressInfoCreatorTests

- (void) setUp
{
    addressHandlerMock = [OCMockObject mockForProtocol:@protocol(AddressHandler)];
    addressTypeDetectorMock = [OCMockObject mockForProtocol:@protocol(AddressTypeDetector)];
    phoneNumberNormalizerMock = [OCMockObject mockForProtocol:@protocol(PhoneNumberNormalizer)];

    addressInfoCreator = [[YAAddressInfoCreator alloc] init];
    [addressInfoCreator setAddressHandler:addressHandlerMock];
    [addressInfoCreator setAddressTypeDetector:addressTypeDetectorMock];
    [addressInfoCreator setPhoneNumberNormalizer:phoneNumberNormalizerMock];

    testAddress = [OCMockObject mockForClass:[YAAddress class]];
    testAddressHandle = @"some address handle";

    testMMCParticipant = [[YAMMCParticipant alloc] initWithParsedJSONParticipantResponse:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                          testAddressHandle, @"address",
                                                                                          testAddressType, @"addressType",
                                                                                          nil]];

    yes = YES;
    no = NO;
}

- (void) stubAddressTypeDetectionToAlwaysReturnNO
{
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isSMSAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isMMCAddress:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isEmailAddress:OCMOCK_ANY];

    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isSMSMMCAddressType:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isMMCMMCAddressType:OCMOCK_ANY];
    [[[addressTypeDetectorMock stub] andReturnValue:OCMOCK_VALUE(no)] isEmailMMCAddressType:OCMOCK_ANY];
}


//
// addressInfoWithRawPhoneNumber
//

- (void) testAddressInfoWithRawPhoneNumberShouldReturnSMSAddressInfoWithYE164FormattedPhoneNumber
{
    NSString* rawPhoneNumber = @"some raw phone number";
    NSString* normalizedPhoneNumber = @"some normalized phone number";
    [[[phoneNumberNormalizerMock expect] andReturn:normalizedPhoneNumber] ye164FormatForPhoneNumber:rawPhoneNumber];

    YAAddressInfo* result = [addressInfoCreator addressInfoWithRawPhoneNumber:rawPhoneNumber];
    STAssertTrue([result isKindOfClass:[YASMSAddressInfo class]], nil);
    STAssertEquals(normalizedPhoneNumber, [result handle], nil);
    [phoneNumberNormalizerMock verify];
}


//
// addressInfoWithYE164PhoneNumber
//

- (void) testAddressInfoWithYE164PhoneNumberShouldReturnSMSAddressInfoWithGivenPhoneNumber
{
    NSString* phoneNumber = @"some raw phone number";

    YAAddressInfo* result = [addressInfoCreator addressInfoWithYE164PhoneNumber:phoneNumber];
    STAssertTrue([result isKindOfClass:[YASMSAddressInfo class]], nil);
    STAssertEquals(phoneNumber, [result handle], nil);
}


//
// addressInfoWithAddress
//

- (void) testAddressInfoWithAddressShouldReturnSMSAddressInfoWithHandleOfGivenAddressWhenGivenSMSAddress
{
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isSMSAddress:testAddress];
    [[[addressHandlerMock expect] andReturn:testAddressHandle] handleForAddress:testAddress];
    [self stubAddressTypeDetectionToAlwaysReturnNO];

    YAAddressInfo* result = [addressInfoCreator addressInfoWithAddress:testAddress];
    STAssertTrue([result isKindOfClass:[YASMSAddressInfo class]], nil);
    STAssertEquals(testAddressHandle, [result handle], nil);
    [addressTypeDetectorMock verify];
    [addressHandlerMock verify];
}

- (void) testAddressInfoWithAddressShouldReturnMMCAddressInfoWithHandleOfGivenAddressWhenGivenMMCAddress
{
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isMMCAddress:testAddress];
    [[[addressHandlerMock expect] andReturn:testAddressHandle] handleForAddress:testAddress];
    [self stubAddressTypeDetectionToAlwaysReturnNO];
    
    YAAddressInfo* result = [addressInfoCreator addressInfoWithAddress:testAddress];
    STAssertTrue([result isKindOfClass:[YAMMCAddressInfo class]], nil);
    STAssertEquals(testAddressHandle, [result handle], nil);
    [addressTypeDetectorMock verify];
    [addressHandlerMock verify];
}

- (void) testAddressInfoWithAddressShouldReturnEmailAddressInfoWithHandleOfGivenAddressWhenGivenEmailAddress
{
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isEmailAddress:testAddress];
    [[[addressHandlerMock expect] andReturn:testAddressHandle] handleForAddress:testAddress];
    [self stubAddressTypeDetectionToAlwaysReturnNO];
    
    YAAddressInfo* result = [addressInfoCreator addressInfoWithAddress:testAddress];
    STAssertTrue([result isKindOfClass:[YAEmailAddressInfo class]], nil);
    STAssertEquals(testAddressHandle, [result handle], nil);
    [addressTypeDetectorMock verify];
    [addressHandlerMock verify];
}

- (void) testAddressInfoWithAddressShouldReturnNilWhenGivenAddressOfUnknownType
{
    [self stubAddressTypeDetectionToAlwaysReturnNO];
    STAssertNil([addressInfoCreator addressInfoWithAddress:testAddress], nil);
}


//
// addressInfoWithMMCParticipant
//

- (void) testAddressInfoWithMMCParticipantShouldReturnSMSAddressInfoWithAddressOfGivenMMCParticipantWhenGivenSMSMMCParticipant
{
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isSMSMMCAddressType:testAddressType];
    [self stubAddressTypeDetectionToAlwaysReturnNO];

    YAAddressInfo* result = [addressInfoCreator addressInfoWithMMCParticipant:testMMCParticipant];
    STAssertTrue([result isKindOfClass:[YASMSAddressInfo class]], nil);
    STAssertEquals(testAddressHandle, [result handle], nil);
    [addressTypeDetectorMock verify];
}

- (void) testAddressInfoWithMMCParticipantShouldReturnMMCAddressInfoWithAddressOfGivenMMCParticipantWhenGivenMMCMMCParticipant
{
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isMMCMMCAddressType:testAddressType];
    [self stubAddressTypeDetectionToAlwaysReturnNO];
    
    YAAddressInfo* result = [addressInfoCreator addressInfoWithMMCParticipant:testMMCParticipant];
    STAssertTrue([result isKindOfClass:[YAMMCAddressInfo class]], nil);
    STAssertEquals(testAddressHandle, [result handle], nil);
    [addressTypeDetectorMock verify];
}

- (void) testAddressInfoWithMMCParticipantShouldReturnEmailAddressInfoWithAddressOfGivenMMCParticipantWhenGivenEmailMMCParticipant
{
    [[[addressTypeDetectorMock expect] andReturnValue:OCMOCK_VALUE(yes)] isEmailMMCAddressType:testAddressType];
    [self stubAddressTypeDetectionToAlwaysReturnNO];
    
    YAAddressInfo* result = [addressInfoCreator addressInfoWithMMCParticipant:testMMCParticipant];
    STAssertTrue([result isKindOfClass:[YAEmailAddressInfo class]], nil);
    STAssertEquals(testAddressHandle, [result handle], nil);
    [addressTypeDetectorMock verify];
}

- (void) testAddressInfoWithMMCParticipantShouldReturnNilWhenGivenMMCParticipantHavingUnrecognizedAddressType
{
    [self stubAddressTypeDetectionToAlwaysReturnNO];
    STAssertNil([addressInfoCreator addressInfoWithMMCParticipant:testMMCParticipant], nil);
}


@end
