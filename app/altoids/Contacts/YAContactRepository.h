//
//  YAContactRepository.h
//  altoids
//
//  Created by Derrick Whittle on 2/7/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactRepository.h"
#import "AddressBookObserverDelegate.h"
#import "AddressBookLoadCommandDelegate.h"
@protocol ContactStore, AddressBookObserver, AddressBookLoadCommandInstanceFactory, AddressBookLoader, CommandQueue;


@interface YAContactRepository : NSObject<ContactRepository, AddressBookObserverDelegate, AddressBookLoadCommandDelegate>

@property (nonatomic, strong) id<ContactStore> contactStore;
@property (nonatomic, strong) id<AddressBookObserver> addressBookObserver;
@property (nonatomic, strong) id<AddressBookLoadCommandInstanceFactory> addressBookLoadCommandInstanceFactory;
@property (nonatomic, strong) id<AddressBookLoader> addressBookLoader;
@property (nonatomic, strong) id<CommandQueue> contactCommandQueue;
@property (nonatomic, strong) NSMutableSet* subscribers;            // [NSValue valueWithNonRetainedObject:id<ContactRepositorySubscriber>]
@property (nonatomic, strong) NSMutableSet* cachingSubscribers;     // [NSValue valueWithNonRetainedObject:id<ContactRepositorySubscriber>]

@end
