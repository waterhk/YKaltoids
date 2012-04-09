//
//  YAMMCParticipantToParticipantInfoTranslatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMMCParticipantToParticipantInfoTranslatorTests.h"
#import "AddressInfoCreator.h"
#import "YAMMCParticipant.h"
#import "YAMMCParticipantToParticipantInfoTranslator.h"
#import "YASMSAddressInfo.h"

@interface YAMMCParticipantToParticipantInfoTranslatorTests()

@property (strong, nonatomic) id addressInfoCreatorMock;
@property (strong, nonatomic) id mmcParticipantMock;
@property (strong, nonatomic) YAMMCParticipantToParticipantInfoTranslator *mmcParticipantToParticipantInfoTranslator;

@end

@implementation YAMMCParticipantToParticipantInfoTranslatorTests

@synthesize addressInfoCreatorMock = addressInfoCreatorMock_;
@synthesize mmcParticipantMock = mmcParticipantMock_;
@synthesize mmcParticipantToParticipantInfoTranslator = mmcParticipantToParticipantInfoTranslator_;

- (void)setUp
{
    [self setAddressInfoCreatorMock:[OCMockObject mockForProtocol:@protocol(AddressInfoCreator)]];
    [self setMmcParticipantMock:[OCMockObject mockForClass:[YAMMCParticipant class]]];
    [self setMmcParticipantToParticipantInfoTranslator:[[YAMMCParticipantToParticipantInfoTranslator alloc] init]];
    [[self mmcParticipantToParticipantInfoTranslator] setAddressInfoCreator:[self addressInfoCreatorMock]];
}

- (void)testCanTranslateMMCParticipantToParticipantInfo
{
    BOOL isConversationCreator = YES;
    BOOL isContact = NO;
    BOOL isUser = YES;
    NSDate *timestamp = [NSDate date];
    NSString *imageURL = @"imageURL";
    NSString *participantID = @"participantID";
    NSString *firstName = @"firstName";
    NSString *lastName = @"lastName";
    NSString *transientID = @"transientID";
    YASMSAddressInfo *smsAddressInfo = [[YASMSAddressInfo alloc] initWithYE164PhoneNumber:@"some phone number"];
    YAParticipantInfo *participantInfo = nil;
    
    [[[[self addressInfoCreatorMock] expect] andReturn:smsAddressInfo] addressInfoWithMMCParticipant:[self mmcParticipantMock]];
    
    [[[[self mmcParticipantMock] expect] andReturn:participantID] participantID];
    [[[[self mmcParticipantMock] expect] andReturn:firstName] firstName];
    [[[[self mmcParticipantMock] expect] andReturn:lastName] lastName];
    [[[[self mmcParticipantMock] expect] andReturn:timestamp] created];
    [[[[self mmcParticipantMock] expect] andReturnValue:OCMOCK_VALUE(isConversationCreator)] isConversationCreator];
    [[[[self mmcParticipantMock] expect] andReturnValue:OCMOCK_VALUE(isUser)] isUser];
    [[[[self mmcParticipantMock] expect] andReturn:transientID] transientID];
    [[[[self mmcParticipantMock] expect] andReturn:imageURL] imageURL];
    
    participantInfo = [[self mmcParticipantToParticipantInfoTranslator] participantInfoFromMMCParticipant:[self mmcParticipantMock] withTransientID:nil];
    
    [[self mmcParticipantMock] verify];
    
    STAssertTrue([[participantInfo participantID] isEqualToString:participantID], @"Unexpected participantID");
    STAssertTrue([[participantInfo firstName] isEqualToString:firstName], @"Unexpected firstName");
    STAssertTrue([[participantInfo lastName] isEqualToString:lastName], @"Unexpected lastName");
    STAssertEqualObjects([participantInfo addressInfo], smsAddressInfo, @"Unexpected address");
    STAssertTrue([participantInfo isContact] == isContact, @"Unexpected isContact");
    STAssertTrue([[participantInfo timestamp] isEqualToDate:timestamp], @"Unexpected timestamp");
    STAssertTrue([participantInfo isConversationCreator] == isConversationCreator, @"Unexpected isConversationCreator");
    STAssertTrue([participantInfo isUser] == isUser, @"Unexpected isUser");
    STAssertTrue([[participantInfo transientID] isEqualToString:transientID], @"Unexpected transientID");
}

- (void)testIfAddressCreatorReturnsNilAddressInfoIsSetToNil
{
    YAParticipantInfo *participantInfo = nil;
    
    [[[self addressInfoCreatorMock] expect] addressInfoWithMMCParticipant:OCMOCK_ANY];
    
    [[[self mmcParticipantMock] stub] participantID];
    [[[self mmcParticipantMock] stub] firstName];
    [[[self mmcParticipantMock] stub] lastName];
    [[[self mmcParticipantMock] stub] created];
    [[[self mmcParticipantMock] stub] isConversationCreator];
    [[[self mmcParticipantMock] stub] isUser];
    [[[self mmcParticipantMock] stub] transientID];
    [[[self mmcParticipantMock] stub] imageURL];
    
    participantInfo = [[self mmcParticipantToParticipantInfoTranslator] participantInfoFromMMCParticipant:[self mmcParticipantMock] withTransientID:nil];
    
    [[self mmcParticipantMock] verify];
    
    STAssertNil([participantInfo addressInfo], @"Expected nil address");
}

@end
