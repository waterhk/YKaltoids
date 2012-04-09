//
//  YACachingContactLocatorTests.m
//  altoids
//
//  Created by Derrick Whittle on 3/1/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "YACachingContactLocator.h"
#import "ContactLocator.h"
#import "ContactRepository.h"
#import "ParticipantHandler.h"
#import "AddressHandler.h"

#import "YAContact.h"
#import "YAContactEndpoint.h"
#import "YAParticipant.h"
#import "YAParticipantInfo.h"
#import "YAAddress.h"
#import "YAMMCAddressInfo.h"

@interface YACachingContactLocatorTests : SenTestCase
{
    YACachingContactLocator* locator;

    id nonCachingContactLocatorMock;
    id contactRepositoryMock;
    id participantHandlerMock;
    id addressHandlerMock;
    id cacheMock;
    id addressesMatchingNoContactMock;
    id memoryWarningNotificationCenterMock;

    YAContactEndpoint* testContactEndpoint;
    NSString* testAddressValue;
    YAParticipant* testParticipant;
    YAAddress* testAddress;
    YAParticipantInfo* testParticipantInfo;
}
@end


@implementation YACachingContactLocatorTests

- (void) setUp
{
    nonCachingContactLocatorMock = [OCMockObject mockForProtocol:@protocol(ContactLocator)];
    contactRepositoryMock = [OCMockObject mockForProtocol:@protocol(ContactRepository)];
    participantHandlerMock = [OCMockObject mockForProtocol:@protocol(ParticipantHandler)];
    addressHandlerMock = [OCMockObject mockForProtocol:@protocol(AddressHandler)];
    cacheMock = [OCMockObject mockForClass:[NSMutableDictionary class]];
    addressesMatchingNoContactMock = [OCMockObject mockForClass:[NSMutableSet class]];
    memoryWarningNotificationCenterMock = [OCMockObject mockForClass:[NSNotificationCenter class]];

    locator = [[YACachingContactLocator alloc] init];
    [locator setNonCachingContactLocator:nonCachingContactLocatorMock];
    [locator setParticipantHandler:participantHandlerMock];
    [locator setAddressHandler:addressHandlerMock];
    [locator setCache:cacheMock];
    [locator setAddressesMatchingNoContact:addressesMatchingNoContactMock];

    testContactEndpoint = [[YAContactEndpoint alloc] init];
    testAddressValue = @"test address";

    YAAddressInfo* addressInfo = [[YAMMCAddressInfo alloc] initWithNormalizedMMCAddress:testAddressValue];
    testParticipantInfo = [[YAParticipantInfo alloc] initWithParticipantID:nil firstName:nil lastName:nil imageURL:nil addressInfo:addressInfo isContact:NO timestamp:nil isConversationCreator:NO isUser:NO transientID:nil];

    testAddress = [[YAAddress alloc] init];
    testParticipant = [[YAParticipant alloc] init];
}



//
// contactEndpointMatchingParticipant
//

- (void) testContactEndpointMatchingParticipantShouldReturnNilGivenNilAddress
{
    [[participantHandlerMock stub] addressForParticipant:OCMOCK_ANY];
    [[addressHandlerMock stub] handleForAddress:OCMOCK_ANY];

    YAContactEndpoint* contactEndpoint = [locator contactEndpointMatchingParticipant:testParticipant];
    STAssertNil(contactEndpoint, nil);
}

- (void) testContactEndpointMatchingParticipantShouldReturnNilFromCacheWhenGivenAddressPreviouslyNotMatched
{
    [[[participantHandlerMock stub] andReturn:testAddress] addressForParticipant:testParticipant];
    [[[addressHandlerMock stub] andReturn:testAddressValue] handleForAddress:testAddress];
    [[cacheMock stub] objectForKey:OCMOCK_ANY];
    [[[addressesMatchingNoContactMock expect] andReturnValue:[NSNumber numberWithBool:YES]] containsObject:testAddressValue];

    YAContactEndpoint* contactEndpoint = [locator contactEndpointMatchingParticipant:testParticipant];
    STAssertNil(contactEndpoint, nil);
    [addressesMatchingNoContactMock verify];
}

- (void) testContactEndpointMatchingParticipantShouldReturnContactFromCacheWhenGivenAddressPreviouslyMatched
{
    [[[participantHandlerMock stub] andReturn:testAddress] addressForParticipant:testParticipant];
    [[[addressHandlerMock stub] andReturn:testAddressValue] handleForAddress:testAddress];
    [[[cacheMock expect] andReturn:testContactEndpoint] objectForKey:testAddressValue];
    
    YAContactEndpoint* contactEndpoint = [locator contactEndpointMatchingParticipant:testParticipant];
    STAssertEquals(testContactEndpoint, contactEndpoint, nil);
    [cacheMock verify];
}

- (void) testContactEndpointMatchingParticipantShouldCacheMissWhenGivenNewUnmatchingAddressAndReturnNil
{
    [[[participantHandlerMock stub] andReturn:testAddress] addressForParticipant:testParticipant];
    [[[addressHandlerMock stub] andReturn:testAddressValue] handleForAddress:testAddress];
    [[cacheMock stub] objectForKey:OCMOCK_ANY];
    [[[addressesMatchingNoContactMock stub] andReturnValue:[NSNumber numberWithBool:NO]] containsObject:OCMOCK_ANY];
    [[addressesMatchingNoContactMock expect] addObject:testAddressValue];
    [[nonCachingContactLocatorMock expect] contactEndpointMatchingParticipant:testParticipant];
    
    YAContactEndpoint* contactEndpoint = [locator contactEndpointMatchingParticipant:testParticipant];
    STAssertNil(contactEndpoint, nil);
    [addressesMatchingNoContactMock verify];
    [nonCachingContactLocatorMock verify];
}

- (void) testContactEndpointMatchingParticipantShouldCacheAndReturnMatchedContactWhenGivenNewMatchingAddress
{
    [[[participantHandlerMock stub] andReturn:testAddress] addressForParticipant:testParticipant];
    [[[addressHandlerMock stub] andReturn:testAddressValue] handleForAddress:testAddress];
    [[[addressesMatchingNoContactMock stub] andReturnValue:[NSNumber numberWithBool:NO]] containsObject:OCMOCK_ANY];
    [[[nonCachingContactLocatorMock expect] andReturn:testContactEndpoint] contactEndpointMatchingParticipant:testParticipant];

    [[[cacheMock expect] andReturn:nil] objectForKey:testAddressValue];
    [[cacheMock expect] setObject:testContactEndpoint forKey:testAddressValue];
    
    YAContactEndpoint* contactEndpoint = [locator contactEndpointMatchingParticipant:testParticipant];
    STAssertEquals(testContactEndpoint, contactEndpoint, nil);
    [cacheMock verify];
    [nonCachingContactLocatorMock verify];
}


//
// contactEndpointMatchingParticipantInfo
//

- (void) testContactEndpointMatchingParticipantInfoShouldReturnNilGivenNilAddress
{
    YAContactEndpoint* contactEndpoint = [locator contactEndpointMatchingParticipantInfo:[[YAParticipantInfo alloc] init]];
    STAssertNil(contactEndpoint, nil);
}

- (void) testContactEndpointMatchingParticipantInfoShouldReturnNilFromCacheWhenGivenAddressPreviouslyNotMatched
{
    [[cacheMock stub] objectForKey:OCMOCK_ANY];
    [[[addressesMatchingNoContactMock expect] andReturnValue:[NSNumber numberWithBool:YES]] containsObject:testAddressValue];
    
    YAContactEndpoint* contactEndpoint = [locator contactEndpointMatchingParticipantInfo:testParticipantInfo];
    STAssertNil(contactEndpoint, nil);
    [addressesMatchingNoContactMock verify];
}

- (void) testContactEndpointMatchingParticipantInfoShouldReturnContactFromCacheWhenGivenAddressPreviouslyMatched
{
    [[[cacheMock expect] andReturn:testContactEndpoint] objectForKey:testAddressValue];
    
    YAContactEndpoint* contactEndpoint = [locator contactEndpointMatchingParticipantInfo:testParticipantInfo];
    STAssertEquals(testContactEndpoint, contactEndpoint, nil);
    [cacheMock verify];
}

- (void) testContactEndpointMatchingParticipantInfoShouldCacheMissWhenGivenNewUnmatchingAddressAndReturnNil
{
    [[cacheMock stub] objectForKey:OCMOCK_ANY];
    [[[addressesMatchingNoContactMock stub] andReturnValue:[NSNumber numberWithBool:NO]] containsObject:OCMOCK_ANY];
    [[addressesMatchingNoContactMock expect] addObject:testAddressValue];
    [[nonCachingContactLocatorMock expect] contactEndpointMatchingParticipantInfo:testParticipantInfo];
    
    YAContactEndpoint* contactEndpoint = [locator contactEndpointMatchingParticipantInfo:testParticipantInfo];
    STAssertNil(contactEndpoint, nil);
    [addressesMatchingNoContactMock verify];
    [nonCachingContactLocatorMock verify];
}

- (void) testContactEndpointMatchingParticipantInfoShouldCacheAndReturnMatchedContactWhenGivenNewMatchingAddress
{
    [[[addressesMatchingNoContactMock stub] andReturnValue:[NSNumber numberWithBool:NO]] containsObject:OCMOCK_ANY];
    [[[nonCachingContactLocatorMock expect] andReturn:testContactEndpoint] contactEndpointMatchingParticipantInfo:testParticipantInfo];
    
    [[[cacheMock expect] andReturn:nil] objectForKey:testAddressValue];
    [[cacheMock expect] setObject:testContactEndpoint forKey:testAddressValue];
    
    YAContactEndpoint* contactEndpoint = [locator contactEndpointMatchingParticipantInfo:testParticipantInfo];
    STAssertEquals(testContactEndpoint, contactEndpoint, nil);
    [cacheMock verify];
    [nonCachingContactLocatorMock verify];
}


//
// contactEndpointsBeginningWithString
//

- (void) testContactEndpointsBeginningWithStringShouldReturnResultsFromNonCachingImplWithoutConsultingCache
{
    NSString* query = @"some query";
    NSArray* expectedResult = [NSArray arrayWithObject:@"whatever"];
    [[[nonCachingContactLocatorMock expect] andReturn:expectedResult] contactEndpointsBeginningWithString:query];

    NSArray* result = [locator contactEndpointsBeginningWithString:query];
    STAssertEquals(expectedResult, result, nil);
    [nonCachingContactLocatorMock verify];
}


//
// didReceiveMemoryWarningFromNotificationCenter
//

- (void) testDidReceiveMemoryWarningFromNotificationCenterShouldClearCaches
{
    [[cacheMock expect] removeAllObjects];
    [[addressesMatchingNoContactMock expect] removeAllObjects];
    
    [locator didReceiveMemoryWarningFromNotificationCenter:memoryWarningNotificationCenterMock];
    [cacheMock verify];
    [addressesMatchingNoContactMock verify];
}


//
// setMemoryWarningNotificationCenter
//

- (void) testSetMemoryWarningNotificationCenterShouldAssignPropertyAndAddSelfAsObserverForMemoryWarning
{
    [[memoryWarningNotificationCenterMock expect] addObserver:locator selector:@selector(didReceiveMemoryWarningFromNotificationCenter:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
    [locator setMemoryWarningNotificationCenter:memoryWarningNotificationCenterMock];
    STAssertEquals(memoryWarningNotificationCenterMock, [locator memoryWarningNotificationCenter], nil);
    [memoryWarningNotificationCenterMock verify];
}


//
// setContactRepository
//

- (void) testSetContactRepositoryShouldSubscribeSelf
{
    [[contactRepositoryMock expect] addCachingSubscriber:locator];

    [locator setContactRepository:contactRepositoryMock];
    STAssertEquals(contactRepositoryMock, [locator contactRepository], nil);
    [contactRepositoryMock verify];
}

- (void) testSetContactRepositoryShouldNotChangeSubscriptionGivenSameContactRepository
{
    [[contactRepositoryMock expect] addCachingSubscriber:locator];     // expected just once
    
    [locator setContactRepository:contactRepositoryMock];

    [locator setContactRepository:contactRepositoryMock];
    STAssertEquals(contactRepositoryMock, [locator contactRepository], nil);
    [contactRepositoryMock verify];
}

- (void) testSetContactRepositoryShouldUnsubscribeFromOldRepositoryAndSubscribeToNewRepositoryGivenDifferentContactRepository
{
    id otherContactRepositoryMock = [OCMockObject mockForProtocol:@protocol(ContactRepository)];
    
    [[contactRepositoryMock expect] addCachingSubscriber:locator];
    
    [locator setContactRepository:contactRepositoryMock];

    [[contactRepositoryMock expect] removeCachingSubscriber:locator];
    [[otherContactRepositoryMock expect] addCachingSubscriber:locator];

    [locator setContactRepository:otherContactRepositoryMock];
    STAssertEquals(otherContactRepositoryMock, [locator contactRepository], nil);
    [contactRepositoryMock verify];
    [otherContactRepositoryMock verify];
}


//
// contactRepositoryDidLoadContacts
//

- (void) testContactRepositoryDidLoadContactsShouldClearCaches
{
    [[cacheMock expect] removeAllObjects];
    [[addressesMatchingNoContactMock expect] removeAllObjects];
    
    [locator contactRepositoryDidLoadContacts:contactRepositoryMock];
    [cacheMock verify];
    [addressesMatchingNoContactMock verify];
}


//
// dealloc
//

- (void) testDeallocShouldRemoveSelfAsObserverFromNotificationCenter
{
    [[memoryWarningNotificationCenterMock stub] addObserver:OCMOCK_ANY selector:@selector(didReceiveMemoryWarningFromNotificationCenter:) name:OCMOCK_ANY object:OCMOCK_ANY];
    [locator setMemoryWarningNotificationCenter:memoryWarningNotificationCenterMock];
    
    // we should expect removeObserver:locator,
    // but that would retain locator, so dealloc would never get called
    [[memoryWarningNotificationCenterMock expect] removeObserver:OCMOCK_ANY];
    
    locator = nil;         // release for dealloc
    [memoryWarningNotificationCenterMock verify];
}

- (void) testDeallocShouldRemoveSelfAsSubscriberFromContactRepository
{
    [[contactRepositoryMock stub] addCachingSubscriber:OCMOCK_ANY];
    [locator setContactRepository:contactRepositoryMock];
    
    // we should expect removeCachingSubscriber:locator,
    // but that would retain locator, so dealloc would never get called
    [[contactRepositoryMock expect] removeCachingSubscriber:OCMOCK_ANY];
    
    locator = nil;         // release for dealloc
    [contactRepositoryMock verify];
}



@end
