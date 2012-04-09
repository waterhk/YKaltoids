//
//  YASMSAddressNormalizerTests.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YASMSAddressNormalizerTests.h"
#import "AddressHandler.h"
#import "PhoneNumberNormalizer.h"
#import "YASMSAddressNormalizer.h"

@interface YASMSAddressNormalizerTests()

@property (strong, nonatomic) id addressHandlerMock;
@property (strong, nonatomic) id addressMock;
@property (strong, nonatomic) id phoneNumberNormalizerMock;
@property (strong, nonatomic) YASMSAddressNormalizer *smsAddressNormalizer;

@end

@implementation YASMSAddressNormalizerTests

@synthesize addressHandlerMock = addressHandlerMock_;
@synthesize addressMock = addressMock_;
@synthesize phoneNumberNormalizerMock = phoneNumberNormalizer_;
@synthesize smsAddressNormalizer = smsAddressNormalizer_;

- (void)setUp
{
    [self setAddressHandlerMock:[OCMockObject mockForProtocol:@protocol(AddressHandler)]];
    [self setAddressMock:[OCMockObject mockForClass:[YAAddress class]]];
    [self setPhoneNumberNormalizerMock:[OCMockObject mockForProtocol:@protocol(PhoneNumberNormalizer)]];

    [self setSmsAddressNormalizer:[[YASMSAddressNormalizer alloc] init]];
    [smsAddressNormalizer_ setAddressHandler:addressHandlerMock_];
    [smsAddressNormalizer_ setPhoneNumberNormalizer:phoneNumberNormalizer_];
}


- (void)testNormalizerAddressShouldReturnNilGivenNilAddress
{
    NSString* result = [smsAddressNormalizer_ normalizeAddress:nil];
    STAssertNil(result, nil);
}

- (void)testNormalizerAddressShouldReturnNilGivenAddressHavingNilHandle
{
    [[[addressHandlerMock_ expect] andReturn:nil] handleForAddress:addressMock_];

    NSString* result = [smsAddressNormalizer_ normalizeAddress:addressMock_];
    STAssertNil(result, nil);
    [addressHandlerMock_ verify];
}

- (void)testNormalizerAddressShouldReturnYE164FormatForHandleOfGivenAddress
{
    NSString* handle = @"some handle";
    NSString* ye164FormatForHandle = @"ye164 format for some handle";
    [[[addressHandlerMock_ expect] andReturn:handle] handleForAddress:addressMock_];
    [[[phoneNumberNormalizer_ expect] andReturn:ye164FormatForHandle] ye164FormatForPhoneNumber:handle];

    NSString* result = [smsAddressNormalizer_ normalizeAddress:addressMock_];
    STAssertEqualObjects(ye164FormatForHandle, result, nil);
    [addressHandlerMock_ verify];
    [phoneNumberNormalizer_ verify];
}

@end
