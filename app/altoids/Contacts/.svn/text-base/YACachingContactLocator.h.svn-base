//
//  YACachingContactLocator.h
//  altoids
//
//  Created by Derrick Whittle on 2/29/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactLocator.h"
#import "ContactRepositorySubscriber.h"
@protocol ContactRepository, ParticipantHandler, AddressHandler;

@interface YACachingContactLocator : NSObject <ContactLocator, ContactRepositorySubscriber>

@property (nonatomic, strong) id<ContactLocator> nonCachingContactLocator;
@property (nonatomic, strong) id<ContactRepository> contactRepository;
@property (nonatomic, strong) id<ParticipantHandler> participantHandler;
@property (nonatomic, strong) id<AddressHandler> addressHandler;
@property (nonatomic, strong) NSMutableDictionary* cache;               // [NSString* address => YAContact* contact]
@property (nonatomic, strong) NSMutableSet* addressesMatchingNoContact; // [YAContact*]
@property (nonatomic, strong) NSNotificationCenter* memoryWarningNotificationCenter;


- (void) didReceiveMemoryWarningFromNotificationCenter:(NSNotificationCenter*)notificationCenter;

@end
