//
//  YAParticipantsRequestDataBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAParticipantsRequestDataBuilderTests.h"
#import "YAParticipantsRequestDataBuilder.h"
#import "ParticipantRequestDataBuilder.h"
#import "MutableArrayCreator.h"

@interface YAParticipantsRequestDataBuilderTests()

@property (strong, nonatomic) id mutableArrayCreatorMock;
@property (strong, nonatomic) id mutableArrayMock;
@property (strong, nonatomic) id participantRequestDataBuilderMock;
@property (strong, nonatomic) YAParticipantsRequestDataBuilder *participantsRequestDataBuilder;

@end

@implementation YAParticipantsRequestDataBuilderTests

@synthesize mutableArrayCreatorMock = mutableArrayCreatorMock_;
@synthesize mutableArrayMock = mutableArrayMock_;
@synthesize participantRequestDataBuilderMock = participantRequestDataBuilderMock_;
@synthesize participantsRequestDataBuilder = participantsRequestDataBuilder_;

- (void)setUp
{
    [self setMutableArrayCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableArrayCreator)]];
    [self setMutableArrayMock:[OCMockObject mockForClass:[NSMutableArray class]]];
    [self setParticipantRequestDataBuilderMock:[OCMockObject mockForProtocol:@protocol(ParticipantRequestDataBuilder)]];
    [self setParticipantsRequestDataBuilder:[[YAParticipantsRequestDataBuilder alloc] init]];
    [[self participantsRequestDataBuilder] setParticipantRequestDataBuilder:[self participantRequestDataBuilderMock]];
    [[self participantsRequestDataBuilder] setMutableArrayCreator:[self mutableArrayCreatorMock]];
}

- (void)testBuildsRequestDataForEachGivenParticipant
{
    id participantMock1 = [OCMockObject mockForClass:[YAParticipant class]];
    id participantMock2 = [OCMockObject mockForClass:[YAParticipant class]];
    id participantMock1RequestData = [NSDictionary dictionary];
    id participantMock2RequestData = [NSDictionary dictionary];
    NSSet *participants = [NSSet setWithObjects:participantMock1, participantMock2, nil];
    NSArray *requestData = nil;
    
    [[[[self mutableArrayCreatorMock] expect] andReturn:[self mutableArrayMock]] mutableArrayWithCapacity:[participants count]];
    [[[[self participantRequestDataBuilderMock] expect] andReturn:participantMock1RequestData] requestDataForParticipant:participantMock1];
    [[[[self participantRequestDataBuilderMock] expect] andReturn:participantMock2RequestData] requestDataForParticipant:participantMock2];
    
    [[[self mutableArrayMock] expect] addObject:participantMock1RequestData];
    [[[self mutableArrayMock] expect] addObject:participantMock2RequestData];
    
    requestData = [[self participantsRequestDataBuilder] requestDataForParticipants:participants];
    
    [[self mutableArrayMock] verify];
    [[self mutableArrayCreatorMock] verify];
    [[self participantRequestDataBuilderMock] verify];
}

@end
