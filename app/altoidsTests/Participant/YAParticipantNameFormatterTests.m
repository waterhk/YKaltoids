//
//  YAParticipantNameFormatterTests.m
//  altoids
//
//  Created by Jon Herron on 10/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAParticipantNameFormatterTests.h"
#import "ParticipantHandler.h"
#import "AddressHandler.h"
#import "ContactLocator.h"
#import "YAParticipantNameFormatter.h"
#import "YAMMCAddressInfo.h"

@interface YAParticipantNameFormatterTests()

@property (strong, nonatomic) id addressMock;
@property (strong, nonatomic) id participantMock;
@property (strong, nonatomic) id participantHandlerMock;
@property (strong, nonatomic) id addressHandlerMock;
@property (strong, nonatomic) id contactLocatorMock;
@property (strong, nonatomic) YAParticipantNameFormatter *participantNameFormatter;

- (YAParticipantInfo *)participantInfoWithFirstName:(NSString *)theFirstName lastName:(NSString *)theLastName addressHandle:(NSString *)theAddressHandle;

@end

@implementation YAParticipantNameFormatterTests

@synthesize addressMock = addressMock_;
@synthesize participantMock = participantMock_;
@synthesize participantHandlerMock = participantHandlerMock_;
@synthesize addressHandlerMock = addressHandlerMock_;
@synthesize contactLocatorMock = contactLocatorMock_;
@synthesize participantNameFormatter = participantNameFormatter_;

- (void)setUp
{
    [self setAddressMock:[OCMockObject mockForClass:[YAAddress class]]];
    [self setParticipantMock:[OCMockObject mockForClass:[YAParticipant class]]];
    [self setParticipantHandlerMock:[OCMockObject mockForProtocol:@protocol(ParticipantHandler)]];
    [self setAddressHandlerMock:[OCMockObject mockForProtocol:@protocol(AddressHandler)]];
    [self setContactLocatorMock:[OCMockObject mockForProtocol:@protocol(ContactLocator)]];

    [self setParticipantNameFormatter:[[YAParticipantNameFormatter alloc] init]];
    [[self participantNameFormatter] setParticipantHandler:[self participantHandlerMock]];
    [[self participantNameFormatter] setAddressHandler:[self addressHandlerMock]];
    [[self participantNameFormatter] setContactLocator:[self contactLocatorMock]];
}

- (void)testWillReturnDisplayNameUsingFirstAndLastNameForParticipantWhenFirstAndLastNameAreNotNil
{
    NSString *addressHandle = @"addy";
    NSString *firstName = @"fname";
    NSString *lastName = @"lname";
    NSString *expectedDisplayName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    [[[self contactLocatorMock] stub] contactEndpointMatchingParticipant:[self participantMock]];
    
    BOOL expectedReturnValueForParticipantIsUser = NO;
    
    [[[[self participantHandlerMock] expect] andReturnValue:OCMOCK_VALUE(expectedReturnValueForParticipantIsUser)] participantIsUser:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:firstName] firstNameForParticipant:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:lastName] lastNameForParticipant:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:[self addressMock]] addressForParticipant:[self participantMock]];
    [[[[self addressHandlerMock] expect] andReturn:addressHandle] handleForAddress:[self addressMock]];
    
    STAssertTrue([[[self participantNameFormatter] formatDisplayNameForParticipant:[self participantMock]] isEqualToString:expectedDisplayName], @"Unexpected display name");
    
    [[self participantMock] verify];
    [[self addressMock] verify];
    [[self participantHandlerMock] verify];
    [[self addressHandlerMock] verify];
}

- (void)testWillReturnDisplayNameUsingFirstAndLastNameForParticipantInfoWhenFirstAndLastNameAreNotNil
{
    NSString *addressHandle = @"addy";
    NSString *firstName = @"fname";
    NSString *lastName = @"lname";
    NSString *expectedDisplayName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    YAParticipantInfo *participantInfo = [self participantInfoWithFirstName:firstName lastName:lastName addressHandle:addressHandle];
    
    STAssertTrue([[[self participantNameFormatter] formatDisplayNameForParticipantInfo:participantInfo] isEqualToString:expectedDisplayName], @"Unexpected display name");
}

- (void)testWillReturnParticipantFirstNameForShortNameIfFirstNameIsNotNil
{
    NSString *addressHandle = @"addy";
    NSString *firstName = @"fname";
    NSString *lastName = @"lname";
    
    [[[self contactLocatorMock] stub] contactEndpointMatchingParticipant:[self participantMock]];
    
    BOOL expectedReturnValueForParticipantIsUser = NO;
    
    [[[[self participantHandlerMock] expect] andReturnValue:OCMOCK_VALUE(expectedReturnValueForParticipantIsUser)] participantIsUser:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:firstName] firstNameForParticipant:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:lastName] lastNameForParticipant:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:[self addressMock]] addressForParticipant:[self participantMock]];
    [[[[self addressHandlerMock] expect] andReturn:addressHandle] handleForAddress:[self addressMock]];
    
    STAssertTrue([[[self participantNameFormatter] formatShortNameForParticipant:[self participantMock]] isEqualToString:firstName], @"Unexpected display name");
    
    [[self participantMock] verify];
    [[self addressMock] verify];
    [[self participantHandlerMock] verify];
    [[self addressHandlerMock] verify];
}

- (void)testWillReturnParticipantLastNameForShortNameIfFirstNameIsNilAndLastNameIsNotNil
{
    NSString *addressHandle = @"addy";
    NSString *firstName = nil;
    NSString *lastName = @"lname";
    
    [[[self contactLocatorMock] stub] contactEndpointMatchingParticipant:[self participantMock]];
    
    BOOL expectedReturnValueForParticipantIsUser = NO;
    
    [[[[self participantHandlerMock] expect] andReturnValue:OCMOCK_VALUE(expectedReturnValueForParticipantIsUser)] participantIsUser:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:firstName] firstNameForParticipant:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:lastName] lastNameForParticipant:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:[self addressMock]] addressForParticipant:[self participantMock]];
    [[[[self addressHandlerMock] expect] andReturn:addressHandle] handleForAddress:[self addressMock]];
    
    STAssertTrue([[[self participantNameFormatter] formatShortNameForParticipant:[self participantMock]] isEqualToString:lastName], @"Unexpected display name");
    
    [[self participantMock] verify];
    [[self addressMock] verify];
    [[self participantHandlerMock] verify];
    [[self addressHandlerMock] verify];
}

- (void)testWillReturnParticipantAddressHandleForShortNameIfFirstNameAndLastNameAreNil
{
    NSString *addressHandle = @"addy";
    NSString *firstName = nil;
    NSString *lastName = nil;
    
    [[[self contactLocatorMock] stub] contactEndpointMatchingParticipant:[self participantMock]];
    
    BOOL expectedReturnValueForParticipantIsUser = NO;
    
    [[[[self participantHandlerMock] expect] andReturnValue:OCMOCK_VALUE(expectedReturnValueForParticipantIsUser)] participantIsUser:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:firstName] firstNameForParticipant:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:lastName] lastNameForParticipant:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:[self addressMock]] addressForParticipant:[self participantMock]];
    [[[[self addressHandlerMock] expect] andReturn:addressHandle] handleForAddress:[self addressMock]];
    
    STAssertTrue([[[self participantNameFormatter] formatShortNameForParticipant:[self participantMock]] isEqualToString:addressHandle], @"Unexpected display name");
    
    [[self participantMock] verify];
    [[self addressMock] verify];
    [[self participantHandlerMock] verify];
    [[self addressHandlerMock] verify];
}

- (void)testWillReturnParticipantInfoFirstNameForShortNameIfFirstNameIsNotNil
{
    NSString *firstName = @"fname";
    YAParticipantInfo *participantInfo = [self participantInfoWithFirstName:firstName lastName:nil addressHandle:nil];
    
    STAssertTrue([[[self participantNameFormatter] formatShortNameForParticipantInfo:participantInfo] isEqualToString:firstName], @"Unexpected display name");
}

- (void)testWillReturnParticipantInfoLastNameForShortNameIfFirstNameIsNilAndLastNameIsNotNil
{
    NSString *lastName = @"lname";
    YAParticipantInfo *participantInfo = [self participantInfoWithFirstName:nil lastName:lastName addressHandle:nil];
    
    STAssertTrue([[[self participantNameFormatter] formatShortNameForParticipantInfo:participantInfo] isEqualToString:lastName], @"Unexpected display name");
}

- (void)testWillReturnParticipantInfoAddressHandleForShortNameIfFirstNameAndLastNameAreNil
{
    NSString *addressHandle = @"addy";
    YAParticipantInfo *participantInfo = [self participantInfoWithFirstName:nil lastName:nil addressHandle:addressHandle];
    
    STAssertTrue([[[self participantNameFormatter] formatShortNameForParticipantInfo:participantInfo] isEqualToString:addressHandle], @"Unexpected display name");
}

- (YAParticipantInfo *)participantInfoWithFirstName:(NSString *)theFirstName lastName:(NSString *)theLastName addressHandle:(NSString *)theAddressHandle
{
    YAAddressInfo *addressInfo = [[YAMMCAddressInfo alloc] initWithNormalizedMMCAddress:theAddressHandle];
    
    return [YAParticipantInfo participantInfoWithFirstName:theFirstName lastName:theLastName addressInfo:addressInfo];
}

@end
