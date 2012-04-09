//
//  ContactRepository.h
//  altoids
//
//  Created by Derrick Whittle on 2/7/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ContactRepositorySubscriber;
@class YAContact, YAContactRecordID;


// for usage, see docs/design/ContactRepository.md

@protocol ContactRepository <NSObject>

- (void) addSubscriber:(id<ContactRepositorySubscriber>)subscriber;
- (void) removeSubscriber:(id<ContactRepositorySubscriber>)subscriber;

// All caching subscribers are notified of changes before all non-caching subscribers
// (but the order of notification within the group of caching subscribers is undefined);
// this allows caching subscribers to clear their caches before the common use case of non-caching subscribers performing lookups when notified of a change.
// NOTE: Most clients should NOT use addCachingSubscriber (it's unlikely anything but YACachingContactLocator qualifies as a caching subscriber).
- (void) addCachingSubscriber:(id<ContactRepositorySubscriber>)cachingSubscriber;
- (void) removeCachingSubscriber:(id<ContactRepositorySubscriber>)cachingSubscriber;

// Returns array of YAContact*, or nil if contacts have not yet been loaded.
// Most clients will be interested in subscribing to receive notification when contacts are loaded or change.
- (NSArray*) contacts;

- (YAContact*) contactWithRecordID:(YAContactRecordID*)recordID;

- (NSData*) imageDataForContact:(YAContact*)contact;

@end
