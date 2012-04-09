//
//  YAParticipantInfoCreatorTests.m
//  altoids
//
//  Created by Derrick Whittle on 4/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <objc/runtime.h>
#import "YATestCase.h"
#import "YATestUser.h"
#import "YATestRegistrationInfo.h"
#import "YATestParticipant.h"
#import "YAParticipantInfoCreator.h"
#import "YAParticipantInfo.h"
#import "AddressInfoCreator.h"
#import "UserProfileRepository.h"
#import "RegistrationFetcher.h"
#import "YAContact.h"
#import "YAContactEndpoint.h"
#import "YAContactPhoneNumberAddress.h"
#import "YAAddress.h"

@interface YAParticipantInfoCreatorTests : YATestCase
{
    YAParticipantInfoCreator* participantInfoCreator;

    id addressInfoCreatorMock;
    id userProfileRepositoryMock;
    id registrationFetcherMock;
    id participantHandlerMock;

    YAContact* testContact;
    YAContactEndpoint* testContactEndpoint;
    YAContactPhoneNumberAddress* testContactPhoneNumberAddress;
    NSString* testGivenName;
    NSString* testFamilyName;
    NSString* testPhoneNumber;
    YAAddressInfo* testAddressInfo;
    YAUser* testUser;
    YARegistrationInfo* testRegistrationInfo;
    YAParticipant* testParticipant;
    YAAddress* testAddress;
    NSManagedObjectContext* testManagedObjectContext;
}
@end


@implementation YAParticipantInfoCreatorTests

- (void) setUp
{
    addressInfoCreatorMock = [OCMockObject mockForProtocol:@protocol(AddressInfoCreator)];
    userProfileRepositoryMock = [OCMockObject mockForProtocol:@protocol(UserProfileRepository)];
    registrationFetcherMock = [OCMockObject mockForProtocol:@protocol(RegistrationFetcher)];

    participantInfoCreator = [[YAParticipantInfoCreator alloc] init];
    [participantInfoCreator setAddressInfoCreator:addressInfoCreatorMock];
    [participantInfoCreator setUserProfileRepository:userProfileRepositoryMock];
    [participantInfoCreator setRegistrationFetcher:registrationFetcherMock];

    testGivenName = @"some given name";
    testFamilyName = @"some family name";
    testPhoneNumber = @"some phone number";

    testContactPhoneNumberAddress = [[YAContactPhoneNumberAddress alloc] initWithDisplayPhoneNumber:testPhoneNumber label:nil];
    testContact = [[YAContact alloc] initWithRecordID:0 givenName:testGivenName familyName:testFamilyName compositeName:nil phoneNumberAddresses:[NSArray arrayWithObject:testContactPhoneNumberAddress]];
    testContactEndpoint = [[YAContactEndpoint alloc] initWithContact:testContact address:testContactPhoneNumberAddress];

    testAddressInfo = [[YAAddressInfo alloc] init];

    YATestUser* user = [[YATestUser alloc] init];
    [user setFirstName:testGivenName];
    [user setLastName:testFamilyName];
    [user setManagedObjectContext:testManagedObjectContext];
    testUser = user;

    testRegistrationInfo = [[YATestRegistrationInfo alloc] init];
    [testRegistrationInfo setPhoneNumber:testPhoneNumber];

    testAddress = [[YAAddress alloc] init];
    testParticipant = [[YATestParticipant alloc] init];
    [testParticipant setAddress:testAddress];
    [testParticipant setFirstName:testGivenName];
    [testParticipant setLastName:testFamilyName];
}


//
// participantInfoWithContactEndpoint
//

- (void) testParticipantInfoWithContactEndpointShouldReturnParticipantInfoHavingNamesOfGivenContact
{
    [[[addressInfoCreatorMock stub] andReturn:testAddressInfo] addressInfoWithRawPhoneNumber:OCMOCK_ANY];

    YAParticipantInfo* result = [participantInfoCreator participantInfoWithContactEndpoint:testContactEndpoint];
    STAssertEquals(testGivenName, [result firstName], nil);
    STAssertEquals(testFamilyName, [result lastName], nil);
}

- (void) testParticipantInfoWithContactEndpointShouldReturnParticipantInfoHavingContactCompositeNameAsGivenNameWhenGivenAndFamilyNameOfGivenContactAreEmpty
{
    [[[addressInfoCreatorMock stub] andReturn:testAddressInfo] addressInfoWithRawPhoneNumber:OCMOCK_ANY];

    NSString* compositeName = @"some composite name";
    testContact = [[YAContact alloc] initWithRecordID:nil givenName:@"" familyName:@"" compositeName:compositeName phoneNumberAddresses:[testContact phoneNumberAddresses]];
    testContactEndpoint = [[YAContactEndpoint alloc] initWithContact:testContact address:[testContactEndpoint address]];

    YAParticipantInfo* result = [participantInfoCreator participantInfoWithContactEndpoint:testContactEndpoint];
    STAssertEquals(compositeName, [result firstName], nil);
    STAssertTrue(![[result lastName] length], nil);
}

- (void) testParticipantInfoWithContactEndpointShouldReturnParticipantInfoHavingContactCompositeNameAsGivenNameWhenGivenAndFamilyNameOfGivenContactAreNil
{
    [[[addressInfoCreatorMock stub] andReturn:testAddressInfo] addressInfoWithRawPhoneNumber:OCMOCK_ANY];
    
    NSString* compositeName = @"some composite name";
    testContact = [[YAContact alloc] initWithRecordID:nil givenName:nil familyName:nil compositeName:compositeName phoneNumberAddresses:[testContact phoneNumberAddresses]];
    testContactEndpoint = [[YAContactEndpoint alloc] initWithContact:testContact address:[testContactEndpoint address]];
    
    YAParticipantInfo* result = [participantInfoCreator participantInfoWithContactEndpoint:testContactEndpoint];
    STAssertEquals(compositeName, [result firstName], nil);
    STAssertTrue(![[result lastName] length], nil);
}

- (void) testParticipantInfoWithContactEndpointShouldReturnParticipantInfoHavingAddressInfoCreatedWithGivenAddress
{
    [[[addressInfoCreatorMock expect] andReturn:testAddressInfo] addressInfoWithRawPhoneNumber:testPhoneNumber];

    YAParticipantInfo* result = [participantInfoCreator participantInfoWithContactEndpoint:testContactEndpoint];
    STAssertEquals(testAddressInfo, [result addressInfo], nil);
}

- (void) testParticipantInfoWithContactEndpointShouldReturnNilGivenNonPhoneNumberAddressAtLeastForNow
{
    YAContactAddress* address = [[YAContactAddress alloc] initWithLabel:nil];

    testContact = [[YAContact alloc] initWithRecordID:0 givenName:testGivenName familyName:testFamilyName compositeName:nil phoneNumberAddresses:[NSArray arrayWithObject:address]];
    testContactEndpoint = [[YAContactEndpoint alloc] initWithContact:testContact address:address];

    YAParticipantInfo* result = [participantInfoCreator participantInfoWithContactEndpoint:testContactEndpoint];
    STAssertNil(result, nil);
}


//
// participantInfoWithUserInput
//

- (void) testParticipantInfoWithUserInputShouldReturnParticipantInfoHavingUserInputForFirstName
{
    [[[addressInfoCreatorMock stub] andReturn:testAddressInfo] addressInfoWithRawPhoneNumber:OCMOCK_ANY];

    NSString* userInput = @"some user input";
    YAParticipantInfo* result = [participantInfoCreator participantInfoWithUserInput:userInput];
    STAssertEquals(userInput, [result firstName], nil);
}

- (void) testParticipantInfoWithUserInputShouldReturnParticipantInfoHavingNoLastName
{
    [[[addressInfoCreatorMock stub] andReturn:testAddressInfo] addressInfoWithRawPhoneNumber:OCMOCK_ANY];
    
    YAParticipantInfo* result = [participantInfoCreator participantInfoWithUserInput:@"some user input"];
    STAssertNil([result lastName], nil);
}

- (void) testParticipantInfoWithUserInputShouldReturnParticipantInfoHavingAddressInfoCreatedWithUserInputAsRawPhoneNumberAtLeastForNow
{
    NSString* userInput = @"some user input";
    [[[addressInfoCreatorMock expect] andReturn:testAddressInfo] addressInfoWithRawPhoneNumber:userInput];

    YAParticipantInfo* result = [participantInfoCreator participantInfoWithUserInput:userInput];
    STAssertEquals(testAddressInfo, [result addressInfo], nil);
}


//
// participantInfoWithParticipant
//

- (void) testParticipantInfoWithParticipantShouldReturnParticipantInfoHavingNamesOfGivenParticipant
{
    [[addressInfoCreatorMock stub] addressInfoWithAddress:OCMOCK_ANY];

    YAParticipantInfo* result = [participantInfoCreator participantInfoWithParticipant:testParticipant];
    STAssertEquals(testGivenName, [result firstName], nil);
    STAssertEquals(testFamilyName, [result lastName], nil);
}

- (void) testParticipantInfoWithParticipantShouldReturnParticipantInfoHavingAddressOfGivenParticipant
{
    [[[addressInfoCreatorMock expect] andReturn:testAddressInfo] addressInfoWithAddress:testAddress];

    YAParticipantInfo* result = [participantInfoCreator participantInfoWithParticipant:testParticipant];
    STAssertEquals(testAddressInfo, [result addressInfo], nil);
}


//
// participantInfoForCurrentUser
//

- (void) testParticipantInfoForCurrentUserShouldReturnNilWhenUserProfileRepositoryFetchDoesFail
{
    [[[userProfileRepositoryMock expect] andReturn:testUser] fetchCurrentUserProfileWithError:[OCMArg setTo:[[NSError alloc] init]]];

    YAParticipantInfo* result = [participantInfoCreator participantInfoForCurrentUser];
    STAssertNil(result,  nil);
}

- (void) testParticipantInfoForCurrentUserShouldReturnNilWhenRegistrationInfoFetchDoesFail
{
    [[[userProfileRepositoryMock stub] andReturn:testUser] fetchCurrentUserProfileWithError:[OCMArg setTo:nil]];

    [[[registrationFetcherMock expect] andReturn:testRegistrationInfo] fetchRegistrationInfoInManagedObjectContext:OCMOCK_ANY error:[OCMArg setTo:[[NSError alloc] init]]];
    
    YAParticipantInfo* result = [participantInfoCreator participantInfoForCurrentUser];
    STAssertNil(result,  nil);
}

- (void) testParticipantInfoForCurrentUserShouldReturnParticipantInfoHavingNamesOfCurrentUserFromUserProfileRepository
{
    [[addressInfoCreatorMock stub] addressInfoWithYE164PhoneNumber:OCMOCK_ANY];

    [[[userProfileRepositoryMock expect] andReturn:testUser] fetchCurrentUserProfileWithError:[OCMArg setTo:nil]];
    [[[registrationFetcherMock expect] andReturn:testRegistrationInfo] fetchRegistrationInfoInManagedObjectContext:OCMOCK_ANY error:[OCMArg setTo:nil]];

    YAParticipantInfo* result = [participantInfoCreator participantInfoForCurrentUser];
    STAssertEquals(testGivenName, [result firstName], nil);
    STAssertEquals(testFamilyName, [result lastName], nil);
}

- (void) testParticipantInfoForCurrentUserShouldReturnParticipantInfoHavingAddressInfoCreatedWithYE164FormattedPhoneNumberOfCurrentUserFromUserProfileRepository
{
    [[[userProfileRepositoryMock expect] andReturn:testUser] fetchCurrentUserProfileWithError:[OCMArg setTo:nil]];
    [[[registrationFetcherMock expect] andReturn:testRegistrationInfo] fetchRegistrationInfoInManagedObjectContext:testManagedObjectContext error:[OCMArg setTo:nil]];
    [[[addressInfoCreatorMock expect] andReturn:testAddressInfo] addressInfoWithYE164PhoneNumber:testPhoneNumber];

    YAParticipantInfo* result = [participantInfoCreator participantInfoForCurrentUser];
    STAssertEquals(testAddressInfo, [result addressInfo], nil);
}


@end
