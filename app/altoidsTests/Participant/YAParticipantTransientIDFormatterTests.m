//
//  YAParticipantTransientIDFormatterTests.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAParticipantTransientIDFormatterTests.h"
#import "AddressHandleFormatter.h"
#import "ParticipantHandler.h"
#import "YAAddress.h"
#import "YAParticipant.h"
#import "YAParticipantTransientIDFormatter.h"

@interface YAParticipantTransientIDFormatterTests()

@property (strong, nonatomic) id addressHandleFormatterMock;
@property (strong, nonatomic) id addressMock;
@property (strong, nonatomic) id participantHandlerMock;
@property (strong, nonatomic) id participantMock;
@property (strong, nonatomic) YAParticipantTransientIDFormatter *participantTransientIDFormatter;

- (void)verifyMocks;

@end

@implementation YAParticipantTransientIDFormatterTests

@synthesize addressHandleFormatterMock = addressHandleFormatterMock_;
@synthesize addressMock = addressMock_;
@synthesize participantHandlerMock = participantHandlerMock_;
@synthesize participantMock = participantMock_;
@synthesize participantTransientIDFormatter = participantTransientIDFormatter_;

- (void)setUp
{
    [self setAddressHandleFormatterMock:[OCMockObject mockForProtocol:@protocol(AddressHandleFormatter)]];
    [self setAddressMock:[OCMockObject mockForClass:[YAAddress class]]];
    [self setParticipantHandlerMock:[OCMockObject mockForProtocol:@protocol(ParticipantHandler)]];
    [self setParticipantMock:[OCMockObject mockForClass:[YAParticipant class]]];
    [self setParticipantTransientIDFormatter:[[YAParticipantTransientIDFormatter alloc] init]];
    [[self participantTransientIDFormatter] setAddressHandleFormatter:[self addressHandleFormatterMock]];
    [[self participantTransientIDFormatter] setParticipantHandler:[self participantHandlerMock]];
}

- (void)testReturnsResultOfFormattingParticipantsAddressHandle
{
    NSString *expectedTransientID = @"id";
    
    [[[[self participantHandlerMock] stub] andReturn:[self addressMock]] addressForParticipant:OCMOCK_ANY];
    [[[[self addressHandleFormatterMock] stub] andReturn:expectedTransientID] formatAddressHandleForServerRequest:OCMOCK_ANY];

    STAssertTrue([[[self participantTransientIDFormatter] transientIDForParticipant:nil] isEqualToString:expectedTransientID], @"Unexpected transient id");
    
    [self verifyMocks];
}

- (void)testIfGivenAddressIsNilThenNilIsReturned
{
    [[[[self participantHandlerMock] expect] andReturn:nil] addressForParticipant:[self participantMock]];
    
    STAssertNil([[self participantTransientIDFormatter] transientIDForParticipant:[self participantMock]], @"Unexpected transient id");
}

- (void)verifyMocks
{
    [[self addressHandleFormatterMock] verify];
    [[self addressMock] verify];
    [[self participantHandlerMock] verify];
    [[self participantMock] verify];
}

@end
