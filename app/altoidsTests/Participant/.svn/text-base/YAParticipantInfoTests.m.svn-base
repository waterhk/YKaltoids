//
//  YAParticipantInfoTests.m
//  altoids
//
//  Created by Jon Herron on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantInfoTests.h"
#import "YAParticipantInfo.h"
#import "YASMSAddressInfo.h"

@interface YAParticipantInfoTests()

- (void)assertParticipantInfo:(YAParticipantInfo *)aParticipantInfo 
             hasParticipantID:(NSString *)aParticipantID
                    firstName:(NSString *)aFirstName
                     lastName:(NSString *)aLastName
                  addressInfo:(YAAddressInfo *)anAddress
                    isContact:(BOOL)anIsContact
                    timestamp:(NSDate *)aTimestamp
        isConversationCreator:(BOOL)anIsConversationCreator
                       isUser:(BOOL)anIsUser 
                  transientID:(NSString *)aTransientID;

@end

@implementation YAParticipantInfoTests

- (void)testProvidesAccessToTheSameValuesProvidedDuringInitialization
{
    NSDate *timestamp = [NSDate date];
    NSString *firstName = @"firstName";
    NSString *lastName = @"lastName";
    NSString *participantID = @"participantID";
    NSString *transientID = @"transientID";
    YASMSAddressInfo *address = [[YASMSAddressInfo alloc] initWithYE164PhoneNumber:@"handle"];
    BOOL isContact = YES;
    BOOL isConversationCreator = YES;
    BOOL isUser = YES;
    YAParticipantInfo *participantInfo = [[YAParticipantInfo alloc] initWithParticipantID:participantID firstName:firstName lastName:lastName imageURL:nil
                                                                              addressInfo:address
                                                                                isContact:isContact timestamp:timestamp
                                                                    isConversationCreator:isConversationCreator isUser:isUser transientID:transientID];
    
    [self assertParticipantInfo:participantInfo hasParticipantID:participantID firstName:firstName lastName:lastName addressInfo:address isContact:isContact
                      timestamp:timestamp isConversationCreator:isConversationCreator isUser:isUser transientID:transientID];
}

- (void)testWhenCreatedWithFirstLastNameAddressFactoryMethodSetsThoseValuesAndDefaultsCorrectly
{
    NSString *firstName = @"firstName";
    NSString *lastName = @"lastName";
    YASMSAddressInfo *address = [[YASMSAddressInfo alloc] initWithYE164PhoneNumber:@"handle"];
    YAParticipantInfo *participantInfo = [YAParticipantInfo participantInfoWithFirstName:firstName lastName:lastName addressInfo:address];
    
    [self assertParticipantInfo:participantInfo hasParticipantID:nil firstName:firstName lastName:lastName addressInfo:address isContact:NO timestamp:nil isConversationCreator:NO isUser:NO transientID:nil];
}

- (void)testWhenCreatedWithFirstLastNameAddressIsContactFactoryMethodSetsThoseValuesAndDefaultsCorrectly
{
    NSString *firstName = @"firstName";
    NSString *lastName = @"lastName";
    YASMSAddressInfo *address = [[YASMSAddressInfo alloc] initWithYE164PhoneNumber:@"handle"];
    BOOL isContact = YES;
    YAParticipantInfo *participantInfo = [YAParticipantInfo participantInfoWithFirstName:firstName lastName:lastName addressInfo:address isContact:YES];
    
    [self assertParticipantInfo:participantInfo hasParticipantID:nil firstName:firstName lastName:lastName addressInfo:address isContact:isContact timestamp:nil isConversationCreator:NO isUser:NO transientID:nil];
}

- (void)assertParticipantInfo:(YAParticipantInfo *)aParticipantInfo 
             hasParticipantID:(NSString *)aParticipantID
                    firstName:(NSString *)aFirstName
                     lastName:(NSString *)aLastName
                  addressInfo:(YAAddressInfo *)anAddress
                    isContact:(BOOL)anIsContact
                    timestamp:(NSDate *)aTimestamp
        isConversationCreator:(BOOL)anIsConversationCreator
                       isUser:(BOOL)anIsUser 
                  transientID:(NSString *)aTransientID
{
    STAssertNotNil(aParticipantInfo, @"Unexpected nil participantInfo");
    STAssertTrue([[aParticipantInfo firstName] isEqualToString:aFirstName], @"Unexpected firstName");
    STAssertTrue([[aParticipantInfo lastName] isEqualToString:aLastName], @"Unexpected lastName");
    STAssertEqualObjects([aParticipantInfo addressInfo], anAddress, @"Unexpected address");
    STAssertTrue([aParticipantInfo isContact] == anIsContact, @"Unexpected isContact");
    
    if (aTimestamp) 
    {
        STAssertTrue([[aParticipantInfo timestamp] isEqualToDate:aTimestamp], @"Unexpected timestamp");
    }
    else
    {
        STAssertNil([aParticipantInfo timestamp], @"Expected nil timestamp");
    }
    
    if (aTransientID) 
    {
        STAssertTrue([[aParticipantInfo transientID] isEqualToString:aTransientID], @"Unexpected transientID");
    }
    else
    {
        STAssertNil([aParticipantInfo transientID], @"Expected nil transient id");
    }
    
    if (aParticipantID) 
    {
        STAssertTrue([[aParticipantInfo participantID] isEqualToString:aParticipantID], @"Unexpected participant id");
    }
    else
    {
        STAssertNil([aParticipantInfo participantID], @"Expected nil participant id");
    }

    STAssertTrue([aParticipantInfo isConversationCreator] == anIsConversationCreator, @"Unexpected isConversationCreator");
    STAssertTrue([aParticipantInfo isUser] == anIsUser, @"Unexpected isUser");
}

@end
