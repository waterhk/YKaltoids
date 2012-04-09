//
//  YAContactRepository.m
//  altoids
//
//  Created by Derrick Whittle on 2/7/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactRepository.h"
#import "AppFactory.h"
#import "ContactStore.h"
#import "CommandQueue.h"
#import "ContactRepositorySubscriber.h"
#import "AddressBookObserver.h"
#import "AddressBookLoader.h"

@interface YAContactRepository()
- (void) asyncLoadContactsAllowingOverlapping:(BOOL)allowOverlapping;
@end


@implementation YAContactRepository

@synthesize contactStore = contactStore_,
            addressBookObserver = addressBookObserver_,
            addressBookLoadCommandInstanceFactory = addressBookLoadCommandInstanceFactory_,
            addressBookLoader = addressBookLoader_,
            contactCommandQueue = contactCommandQueue_,
            subscribers = subscribers_,
            cachingSubscribers = cachingSubscribers_;


- (void) dealloc
{
    [addressBookObserver_ clearDelegate:self];
}

- (void) setAddressBookObserver:(id<AddressBookObserver>)addressBookObserver
{
    if(addressBookObserver == addressBookObserver_)
    {
        return;
    }

    [addressBookObserver_ clearDelegate:self];
    addressBookObserver_ = addressBookObserver;
    [addressBookObserver_ observeAddressBookForDelegate:self];
}

- (void) addSubscriber:(id<ContactRepositorySubscriber>)subscriber
{
    // we cannot allow our subscribers array to retain the subscriber, or it will create a retention cycle;
    // instead, we add a point to the subscriber to our array
    // (we are applying the "assign" semantics conventional for delegates to our subscribers)
    [subscribers_ addObject:[NSValue valueWithNonretainedObject:subscriber]];
}

- (void) removeSubscriber:(id<ContactRepositorySubscriber>)subscriber
{
    [subscribers_ removeObject:[NSValue valueWithNonretainedObject:subscriber]];
}

- (void) addCachingSubscriber:(id<ContactRepositorySubscriber>)subscriber
{
    // we cannot allow our subscribers array to retain the subscriber, or it will create a retention cycle;
    // instead, we add a point to the subscriber to our array
    // (we are applying the "assign" semantics conventional for delegates to our subscribers)
    [cachingSubscribers_ addObject:[NSValue valueWithNonretainedObject:subscriber]];
}

- (void) removeCachingSubscriber:(id<ContactRepositorySubscriber>)subscriber
{
    [cachingSubscribers_ removeObject:[NSValue valueWithNonretainedObject:subscriber]];
}

- (NSArray*) contacts
{
    if([contactStore_ empty])
    {
        [self asyncLoadContactsAllowingOverlapping:NO];
        return nil;
    }

    return [contactStore_ contacts];
}

- (YAContact*) contactWithRecordID:(YAContactRecordID*)recordID
{
    if([contactStore_ empty])
    {
        [self asyncLoadContactsAllowingOverlapping:NO];
        return nil;
    }

    return [[contactStore_ contactsByRecordID] objectForKey:recordID];
}

- (NSData*) imageDataForContact:(YAContact*)contact
{
    return [addressBookLoader_ imageDataForContact:contact];
}

- (void) asyncLoadContactsAllowingOverlapping:(BOOL)allowOverlapping
{
    if(!allowOverlapping && [contactCommandQueue_ count] > 0)   // if we ever have multiple types of contact-related commands, we'll need a more sophisticated way to prevent overlapping async loads
    {
        return;
    }

    [contactCommandQueue_ append:[addressBookLoadCommandInstanceFactory_ createAddressBookLoadCommandWithDelegate:self]];
}


#pragma mark AddressBookOberverDelegate implementation

- (void) addressBookObserverDidObserveChanges:(id<AddressBookObserver>)observer
{
    [self asyncLoadContactsAllowingOverlapping:YES];
}


#pragma mark AddressBookLoadCommandDelegate implementation

- (void) addressBookLoadCommand:(id<AddressBookLoadCommand>)command didLoadContacts:(NSArray*)contacts
{
    [contactStore_ setContacts:contacts];

    // Notifying all caching subscribers before non-caching subscribers ensures fresh caches when the non-cachers handle change notification.
    // In practice, this is so YACachingContactLocator is guaranteed to clear its cache before data sources and view controllers re-map participants to contacts.
    for(NSValue* value in cachingSubscribers_)
    {
        id<ContactRepositorySubscriber> subscriber = [value nonretainedObjectValue];
        [subscriber contactRepositoryDidLoadContacts:self];
    }

    for(NSValue* value in subscribers_)
    {
        id<ContactRepositorySubscriber> subscriber = [value nonretainedObjectValue];
        [subscriber contactRepositoryDidLoadContacts:self];
    }
}

- (void) addressBookLoadCommandDidFail:(id<AddressBookLoadCommand>)command
{
    // there's nothing meaningful we can do...
}


@end
