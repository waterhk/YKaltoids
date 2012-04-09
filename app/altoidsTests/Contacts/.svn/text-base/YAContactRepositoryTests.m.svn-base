//
//  YAContactRepositoryTests.m
//  altoids
//
//  Created by Derrick Whittle on 2/22/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "AppFactory.h"
#import "YAContactRepository.h"
#import "ContactStore.h"
#import "CommandQueue.h"
#import "ContactRepositorySubscriber.h"
#import "AddressBookObserver.h"
#import "AddressBookLoader.h"
#import "YAContact.h"
#import "YAContactRecordID.h"

@interface YAContactRepositoryTests : YATestCase
{
    YAContactRepository* contactRepository;
    
    id contactStoreMock;
    id addressBookObserverMock;
    id addressBookLoadCommandInstanceFactoryMock;
    id addressBookLoaderMock;
    id contactCommandQueueMock;
    id subscribersMock;
    id cachingSubscribersMock;

    YAContactRecordID* testContactRecordID;
    BOOL yes;
    BOOL no;
}
@end


@implementation YAContactRepositoryTests

- (void) setUp
{
    contactStoreMock = [OCMockObject mockForProtocol:@protocol(ContactStore)];
    addressBookLoadCommandInstanceFactoryMock = [OCMockObject mockForProtocol:@protocol(AddressBookLoadCommandInstanceFactory)];
    addressBookLoaderMock = [OCMockObject mockForProtocol:@protocol(AddressBookLoader)];
    contactCommandQueueMock = [OCMockObject mockForProtocol:@protocol(CommandQueue)];
    subscribersMock = [OCMockObject mockForClass:[NSMutableSet class]];
    cachingSubscribersMock = [OCMockObject mockForClass:[NSMutableSet class]];

    contactRepository = [[YAContactRepository alloc] init];
    [contactRepository setContactStore:contactStoreMock];
    [contactRepository setAddressBookObserver:addressBookObserverMock];
    [contactRepository setAddressBookLoadCommandInstanceFactory:addressBookLoadCommandInstanceFactoryMock];
    [contactRepository setAddressBookLoader:addressBookLoaderMock];
    [contactRepository setContactCommandQueue:contactCommandQueueMock];
    [contactRepository setSubscribers:subscribersMock];
    [contactRepository setCachingSubscribers:cachingSubscribersMock];

    testContactRecordID = [[YAContactRecordID alloc] initWithABRecordID:8008];
    yes = YES;
    no = NO;
}

- (void) assertCreatesAndEnqueuesAsyncLoadCommandDelegatingToSelfWhenExecutingBlock:(void (^)())block
{
    [[addressBookObserverMock stub] observeAddressBookForDelegate:OCMOCK_ANY];
    
    id addressBookLoadCommand = [OCMockObject mockForProtocol:@protocol(AddressBookLoadCommand)];
    
    [[[addressBookLoadCommandInstanceFactoryMock stub] andReturn:addressBookLoadCommand] createAddressBookLoadCommandWithDelegate:contactRepository];
    [[contactCommandQueueMock expect] append:addressBookLoadCommand];
    
    block();
    [addressBookLoadCommandInstanceFactoryMock verify];
    [contactCommandQueueMock verify];
}

- (NSArray*) createContacts
{
    // we use a mock for the contacts array instead of an actual NSArray for expected contacts,
    // only because NSArray is too smart by half, and alloc'ing two empty NSArrays actually gives you back the same pointer both times,
    // so our same-object pointer equality test would be worthless with real NSArrays...
    return [OCMockObject mockForClass:[NSArray class]];
}


//
// dealloc
//

- (void) testDeallocShouldClearSelfAsDelegateFromAddressBookObserver
{
    [[addressBookObserverMock stub] observeAddressBookForDelegate:OCMOCK_ANY];
    [contactRepository setAddressBookObserver:addressBookObserverMock];

    // we should expect clearDelegate:contactRepository,
    // but that would retain contactRepository, so dealloc would never get called
    [[addressBookObserverMock expect] clearDelegate:OCMOCK_ANY];

    contactRepository = nil;            // release for dealloc
    [addressBookObserverMock verify];    
}

//
// setAddressBookObserver
//

- (void) testSetAddressBookObserverShouldBeginObservingAddressBook
{
    [[addressBookObserverMock expect] observeAddressBookForDelegate:contactRepository];

    [contactRepository setAddressBookObserver:addressBookObserverMock];
    STAssertEquals(addressBookObserverMock, [contactRepository addressBookObserver], nil);
    [addressBookObserverMock verify];
}

- (void) testSetAddressBookObserverShouldNotChangeObservationGivenSameObserver
{
    [[addressBookObserverMock expect] observeAddressBookForDelegate:contactRepository];     // expected just once
    
    [contactRepository setAddressBookObserver:addressBookObserverMock];

    [contactRepository setAddressBookObserver:addressBookObserverMock];
    STAssertEquals(addressBookObserverMock, [contactRepository addressBookObserver], nil);
    [addressBookObserverMock verify];
}

- (void) testSetAddressBookObserverShouldStopObservingWithObserverAndBeginObservingWithNewObserverGivenDifferentObserver
{
    id otherAddressBookObserverMock = [OCMockObject mockForProtocol:@protocol(AddressBookObserver)];

    [[addressBookObserverMock expect] observeAddressBookForDelegate:contactRepository];
    
    [contactRepository setAddressBookObserver:addressBookObserverMock];
    
    [[addressBookObserverMock expect] clearDelegate:contactRepository];
    [[otherAddressBookObserverMock expect] observeAddressBookForDelegate:contactRepository];

    [contactRepository setAddressBookObserver:otherAddressBookObserverMock];
    STAssertEquals(otherAddressBookObserverMock, [contactRepository addressBookObserver], nil);
    [addressBookObserverMock verify];
    [otherAddressBookObserverMock verify];
}


//
// addSubscriber
//

- (void) testAddSubscriberShouldNotRetainGivenSubscriber
{
    NSObject* subscriber = [[NSObject alloc] init];

    [[subscribersMock stub] addObject:OCMOCK_ANY];

    NSNumber* initialRetainCount = [subscriber valueForKey:@"retainCount"];
    [contactRepository addSubscriber:(id<ContactRepositorySubscriber>)subscriber];
    NSNumber* postSubscriptionRetainCount = [subscriber valueForKey:@"retainCount"];
    
    STAssertEqualObjects(initialRetainCount, postSubscriptionRetainCount, nil);
}

- (void) testAddSubscriberShouldAddPointerToGivenSubscriberToSubscribersSet
{    
    id<ContactRepositorySubscriber> subscriber = (id<ContactRepositorySubscriber>)[[NSObject alloc] init];
    [[subscribersMock expect] addObject:[NSValue valueWithNonretainedObject:subscriber]];

    [contactRepository addSubscriber:subscriber];    
    [subscribersMock verify];
}

//
// removeSubscriber
//

- (void) testRemoveSubscriberShouldRemovePointerToGivenSubscriberFromSubscribersSet
{
    id<ContactRepositorySubscriber> subscriber = (id<ContactRepositorySubscriber>)[[NSObject alloc] init];
    [[subscribersMock expect] removeObject:[NSValue valueWithNonretainedObject:subscriber]];
    
    [contactRepository removeSubscriber:subscriber];    
    [subscribersMock verify];
}


//
// addCachingSubscriber
//

- (void) testAddCachingSubscriberShouldNotRetainGivenSubscriber
{
    NSObject* subscriber = [[NSObject alloc] init];
    
    [[cachingSubscribersMock stub] addObject:OCMOCK_ANY];
    
    NSNumber* initialRetainCount = [subscriber valueForKey:@"retainCount"];
    [contactRepository addCachingSubscriber:(id<ContactRepositorySubscriber>)subscriber];
    NSNumber* postSubscriptionRetainCount = [subscriber valueForKey:@"retainCount"];
    
    STAssertEqualObjects(initialRetainCount, postSubscriptionRetainCount, nil);
}

- (void) testAddCachingSubscriberShouldAddPointerToGivenSubscriberToCachingSubscribersSet
{    
    id<ContactRepositorySubscriber> subscriber = (id<ContactRepositorySubscriber>)[[NSObject alloc] init];
    [[cachingSubscribersMock expect] addObject:[NSValue valueWithNonretainedObject:subscriber]];
    
    [contactRepository addCachingSubscriber:subscriber];    
    [cachingSubscribersMock verify];
}

//
// removeCachingSubscriber
//

- (void) testRemoveCachingSubscriberShouldRemovePointerToGivenSubscriberFromCachingSubscribersSet
{
    id<ContactRepositorySubscriber> subscriber = (id<ContactRepositorySubscriber>)[[NSObject alloc] init];
    [[cachingSubscribersMock expect] removeObject:[NSValue valueWithNonretainedObject:subscriber]];
    
    [contactRepository removeCachingSubscriber:subscriber];    
    [cachingSubscribersMock verify];
}

//
// contacts
//

- (void) testContactsShouldReturnNonNilContactsWithoutLoadingContactsWhenContactStoreHasCachedContacts
{
    NSArray* expectedContacts = [self createContacts];
    [[[contactStoreMock expect] andReturnValue:OCMOCK_VALUE(no)] empty];
    [[[contactStoreMock expect] andReturn:expectedContacts] contacts];
    
    NSArray* contacts = [contactRepository contacts];
    STAssertEquals(expectedContacts, contacts, nil);
}

- (void) testContactsShouldReturnNilWhenContactStoreHasNoCachedContacts
{
    [[contactCommandQueueMock stub] append:OCMOCK_ANY];
    [[addressBookLoadCommandInstanceFactoryMock stub] createAddressBookLoadCommandWithDelegate:OCMOCK_ANY];
    [[contactCommandQueueMock stub] count];

    [[[contactStoreMock expect] andReturnValue:OCMOCK_VALUE(yes)] empty];
    
    NSArray* contacts = [contactRepository contacts];
    STAssertNil(contacts, nil);
}

- (void) testContactsShouldCreateAndEnqueueAsyncLoadCommandDelegatingToSelfWhenContactStoreIsEmpty
{
    [[contactCommandQueueMock stub] count];
    [[[contactStoreMock expect] andReturnValue:OCMOCK_VALUE(yes)] empty];

    [self assertCreatesAndEnqueuesAsyncLoadCommandDelegatingToSelfWhenExecutingBlock:^()
    {
        [contactRepository contacts];
    }];
}

- (void) testContactsShouldNotCreateOrEnqueueAsyncLoadCommandWhenAnotherAsyncLoadCommandIsAlreadyUnderway
{
    NSUInteger commandQueueCount = 1;
    [[[contactStoreMock expect] andReturnValue:OCMOCK_VALUE(yes)] empty];
    [[contactStoreMock stub] contacts];
    [[[contactCommandQueueMock expect] andReturnValue:OCMOCK_VALUE(commandQueueCount)] count];
    
    [contactRepository contacts];

    [contactStoreMock verify];
    [contactCommandQueueMock verify];
}


//
// contactWithRecordID
//

- (void) testContactWithRecordIDShouldReturnContactFromContactStore
{
    YAContact* testContact = [[YAContact alloc] init];
    id dictionary = [OCMockObject mockForClass:[NSMutableDictionary class]];
    [[[contactStoreMock expect] andReturn:dictionary] contactsByRecordID];
    [[[dictionary expect] andReturn:testContact] objectForKey:testContactRecordID];
    [[[contactStoreMock expect] andReturnValue:OCMOCK_VALUE(no)] empty];

    YAContact* result = [contactRepository contactWithRecordID:testContactRecordID];
    STAssertEquals(testContact, result, nil);
}

- (void) testContactWithRecordIDShouldReturnNilWhenContactStoreHasNoCachedContacts
{
    [[contactCommandQueueMock stub] append:OCMOCK_ANY];
    [[addressBookLoadCommandInstanceFactoryMock stub] createAddressBookLoadCommandWithDelegate:OCMOCK_ANY];
    [[contactCommandQueueMock stub] count];
    
    [[[contactStoreMock expect] andReturnValue:OCMOCK_VALUE(yes)] empty];
    
    YAContact* result = [contactRepository contactWithRecordID:testContactRecordID];
    STAssertNil(result, nil);
}

- (void) testContactWithRecordIDShouldCreateAndEnqueueAsyncLoadCommandDelegatingToSelfWhenContactStoreIsEmpty
{
    [[contactCommandQueueMock stub] count];
    [[[contactStoreMock expect] andReturnValue:OCMOCK_VALUE(yes)] empty];

    [self assertCreatesAndEnqueuesAsyncLoadCommandDelegatingToSelfWhenExecutingBlock:^()
     {
         [contactRepository contactWithRecordID:testContactRecordID];
     }];
}

- (void) testContactWithRecordIDShouldNotCreateOrEnqueueAsyncLoadCommandWhenAnotherAsyncLoadCommandIsAlreadyUnderway
{
    NSUInteger commandQueueCount = 1;
    [[[contactStoreMock expect] andReturnValue:OCMOCK_VALUE(yes)] empty];
    [[[contactCommandQueueMock expect] andReturnValue:OCMOCK_VALUE(commandQueueCount)] count];
    
    [contactRepository contactWithRecordID:testContactRecordID];
}


//
// imageDataForContact
//

- (void) testImageDataForContactShouldReturnImageDataFromAddressBookLoaderUsingGivenContact
{
    YAContact* contact = [[YAContact alloc] init];
    NSData* expectedData = [[NSData alloc] init];
    [[[addressBookLoaderMock expect] andReturn:expectedData] imageDataForContact:contact];
    
    NSData* data = [contactRepository imageDataForContact:contact];
    STAssertEquals(expectedData, data, nil);
    [addressBookLoaderMock verify];
}

//
// addressBookObserverDidObserveChanges
//

- (void) testAddressBookObserverDidObserveChangesShouldCreateAndEnqueueAsyncLoadCommandDelegatingToSelfWhenContactStoreHasNoCachedContacts
{
    [[contactCommandQueueMock reject] count];   // confirms that the queue's state is not considered, as expected

    [self assertCreatesAndEnqueuesAsyncLoadCommandDelegatingToSelfWhenExecutingBlock:^()
     {
         [contactRepository addressBookObserverDidObserveChanges:addressBookObserverMock];
     }];
}

//
// addressBookLoadComand:didLoadContacts:
//

- (void) testAddressBookLoadCommandDidLoadContactsShouldCacheGivenContactsToContactStore
{
    NSArray* contacts = [self createContacts];
    [[contactStoreMock expect] setContacts:contacts];

    [contactRepository setSubscribers:[NSSet set]];
    [contactRepository setCachingSubscribers:[NSSet set]];

    [contactRepository addressBookLoadCommand:[OCMockObject mockForProtocol:@protocol(AddressBookLoadCommand)] didLoadContacts:contacts];
    [contactStoreMock verify];
}

- (void) testAddressBookLoadCommandDidLoadContactsShouldNotifyCachingSubscribersAndThenSubscribers
{
    // this test is more of an integration than unit test, but it's not worth decomposing subscription any further

    id aSubscriber = [OCMockObject mockForProtocol:@protocol(ContactRepositorySubscriber)];
    id anotherSubscriber = [OCMockObject mockForProtocol:@protocol(ContactRepositorySubscriber)];
    
    id aCachingSubscriber = [OCMockObject mockForProtocol:@protocol(ContactRepositorySubscriber)];
    id anotherCachingSubscriber = [OCMockObject mockForProtocol:@protocol(ContactRepositorySubscriber)];

    NSMutableSet* subscribers = [NSMutableSet set];
    [subscribers addObject:[NSValue valueWithNonretainedObject:aSubscriber]];
    [subscribers addObject:[NSValue valueWithNonretainedObject:anotherSubscriber]];

    NSMutableSet* cachingSubscribers = [NSMutableSet set];
    [cachingSubscribers addObject:[NSValue valueWithNonretainedObject:aCachingSubscriber]];
    [cachingSubscribers addObject:[NSValue valueWithNonretainedObject:anotherCachingSubscriber]];
    __block BOOL aCachingSubscriberNotified = NO;           // it'd be nicer to use a set to track this, but
    __block BOOL anotherCachingSubscriberNotified = NO;     //  it requires stubbing out more on the mock caching subscribers

    [contactRepository setSubscribers:subscribers];
    [contactRepository setCachingSubscribers:cachingSubscribers];
    [[contactStoreMock stub] setContacts:OCMOCK_ANY];
        
    [[[aCachingSubscriber expect] andDo:^(NSInvocation* invocation) { aCachingSubscriberNotified = YES; } ] contactRepositoryDidLoadContacts:contactRepository];
    [[[anotherCachingSubscriber expect] andDo:^(NSInvocation* invocation) { anotherCachingSubscriberNotified = YES; }] contactRepositoryDidLoadContacts:contactRepository];

    [[[aSubscriber expect] andDo:^(NSInvocation* invocation) { STAssertTrue(aCachingSubscriberNotified && anotherCachingSubscriberNotified, nil); } ] contactRepositoryDidLoadContacts:contactRepository];
    [[[anotherSubscriber expect] andDo:^(NSInvocation* invocation) { STAssertTrue(aCachingSubscriberNotified && anotherCachingSubscriberNotified, nil); } ] contactRepositoryDidLoadContacts:contactRepository];

    [contactRepository addressBookLoadCommand:[OCMockObject mockForProtocol:@protocol(AddressBookLoadCommand)] didLoadContacts:[self createContacts]];
    [aSubscriber verify];
    [anotherSubscriber verify];
}

//
// addressBookLoadCommandDidFail
//

- (void) testAddressBookLoadCommandDidFailShouldNotNotifySubscribers
{
    // no expectation set on subscribersMock, so OCMock will throw if it is called to get subscribers to notify
    [contactRepository addressBookLoadCommandDidFail:[OCMockObject mockForProtocol:@protocol(AddressBookLoadCommand)]];
}


@end
