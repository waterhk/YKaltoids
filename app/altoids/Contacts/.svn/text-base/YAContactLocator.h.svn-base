//
//  YAContactLocator.h
//  altoids
//
//  Created by Jon Herron on 11/3/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactLocator.h"
@protocol ContactEndpointLocator, ContactRepository, ParticipantHandler, ContactPredicateCreator, AddressHandler, MutableArrayCreator, MutableSetCreator, ArrayFilterer, SetFilterer, TimerInstanceFactory;


@interface YAContactLocator : NSObject <ContactLocator>

@property (strong, nonatomic) id<ContactRepository> contactRepository;
@property (strong, nonatomic) id<ParticipantHandler> participantHandler;
@property (strong, nonatomic) id<ContactPredicateCreator> contactPredicateCreator;
@property (strong, nonatomic) id<AddressHandler> addressHandler;
@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;
@property (strong, nonatomic) id<MutableSetCreator> mutableSetCreator;
@property (strong, nonatomic) id<ArrayFilterer> arrayFilterer;
@property (strong, nonatomic) id<SetFilterer> setFilterer;
@property (strong, nonatomic) id<TimerInstanceFactory> timerInstanceFactory;
@property (strong, nonatomic) id<ContactEndpointLocator> contactEndpointLocator;


- (YAContactEndpoint*) contactEndpointMatchingAddress:(NSString*)address familyName:(NSString*)familyName givenName:(NSString*)givenName;

@end
