//
//  YASMSAddressHandleFormatterTests.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YASMSAddressHandleFormatterTests.h"
#import "YAAddress.h"
#import "YASMSAddressHandleFormatter.h"
#import "AddressHandler.h"

@interface YASMSAddressHandleFormatterTests()

@property (strong, nonatomic) id addressMock;
@property (strong, nonatomic) id addressHandlerMock;
@property (strong, nonatomic) YASMSAddressHandleFormatter *smsAddressHandleFormatter;

@end

@implementation YASMSAddressHandleFormatterTests

@synthesize addressMock = addressMock_;
@synthesize addressHandlerMock = addrsesHandlerMock_;
@synthesize smsAddressHandleFormatter = smsAddressHandleFormatter_;

- (void)setUp
{
    [self setAddressHandlerMock:[OCMockObject mockForProtocol:@protocol(AddressHandler)]];
    [self setAddressMock:[OCMockObject mockForClass:[YAAddress class]]];

    [self setSmsAddressHandleFormatter:[[YASMSAddressHandleFormatter alloc] init]];
    [[self smsAddressHandleFormatter] setAddressHandler:[self addressHandlerMock]];
}

- (void)testReturnsAddressHandleWithSMSPrefix
{
    NSString* addressHandle = @"some address handle";
    NSString *expectedFormattedHandle = [NSString stringWithFormat:@"sms:%@", addressHandle];

    [[[[self addressHandlerMock] expect] andReturn:addressHandle] handleForAddress:[self addressMock]];

    NSString* result = [[self smsAddressHandleFormatter] formatAddressHandleForServerRequest:[self addressMock]];
    STAssertTrue([result isEqualToString:expectedFormattedHandle], @"Formatted handle was not as expected");
    [[self addressHandlerMock] verify];
}

@end
