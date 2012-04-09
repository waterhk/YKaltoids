//
//  YAParticipantRequestDataBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAParticipantRequestDataBuilderTests.h"
#import "YAParticipantRequestDataBuilder.h"
#import "YAParticipant.h"
#import "ParticipantRequestBuilder.h"
#import "ParticipantTransientIDFormatter.h"
#import "MutableDictionaryCreator.h"

@interface YAParticipantRequestDataBuilderTests()

@property (strong, nonatomic) id mutableDictionaryCreatorMock;
@property (strong, nonatomic) id participantHandlerMock;
@property (strong, nonatomic) id participantMock;
@property (strong, nonatomic) id participantTransientIDFormatterMock;
@property (strong, nonatomic) YAParticipantRequestDataBuilder *participantRequestDataBuilder;

- (void)validateRequestDataWithTransientID:(NSString *)theTransientID firstName:(NSString *)theFirstName lastName:(NSString *)theLastName;

@end

@implementation YAParticipantRequestDataBuilderTests

@synthesize mutableDictionaryCreatorMock = mutableDictionaryCreatorMock_;
@synthesize participantHandlerMock = participantHandlerMock_;
@synthesize participantMock = participantMock_;
@synthesize participantRequestDataBuilder = participantRequestDataBuilder_;
@synthesize participantTransientIDFormatterMock = participantTransientIDFormatterMock_;

- (void)setUp
{
    [self setMutableDictionaryCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableDictionaryCreator)]];
    [self setParticipantHandlerMock:[OCMockObject mockForProtocol:@protocol(ParticipantHandler)]];
    [self setParticipantMock:[OCMockObject mockForClass:[YAParticipant class]]];
    [self setParticipantTransientIDFormatterMock:[OCMockObject mockForProtocol:@protocol(ParticipantTransientIDFormatter)]];
    
    [self setParticipantRequestDataBuilder:[[YAParticipantRequestDataBuilder alloc] init]];
    [[self participantRequestDataBuilder] setParticipantHandler:[self participantHandlerMock]];
    [[self participantRequestDataBuilder] setMutableDictionaryCreator:[self mutableDictionaryCreatorMock]];
    [[self participantRequestDataBuilder] setParticipantTransientIDFormatter:[self participantTransientIDFormatterMock]];
}

- (void)testBuildsDictionaryWithTransientIDFirstAndLastNames
{
    NSString *transientID = @"id";
    NSString *firstName = @"fname";
    NSString *lastName = @"lname";
    
    [self validateRequestDataWithTransientID:transientID firstName:firstName lastName:lastName];
}

- (void)testIfFirstNameIsNilDictionaryStillContainsLastNameAndTransientID
{
    NSString *transientID = @"id";
    NSString *firstName = nil;
    NSString *lastName = @"lname";
    
    [self validateRequestDataWithTransientID:transientID firstName:firstName lastName:lastName];
}

- (void)testIfFirstNameIsEmptyDictionaryStillContainsLastNameAndTransientID
{
    NSString *transientID = @"id";
    NSString *firstName = @"";
    NSString *lastName = @"lname";
    
    [self validateRequestDataWithTransientID:transientID firstName:firstName lastName:lastName];
}

- (void)testIfLastNameIsNilDictionaryStillContainsFirstNameAndTransientID
{
    NSString *transientID = @"id";
    NSString *firstName = @"fname";
    NSString *lastName = nil;
    
    [self validateRequestDataWithTransientID:transientID firstName:firstName lastName:lastName];
}

- (void)testIfLastNameIsEmptyDictionaryStillContainsFirstNameAndTransientID
{
    NSString *transientID = @"id";
    NSString *firstName = @"fname";
    NSString *lastName = @"";
    
    [self validateRequestDataWithTransientID:transientID firstName:firstName lastName:lastName];
}

- (void)testIfTransientIDIsNilDictionaryContainsFirstAndLastNameAndGeneratedTransientID
{
    NSString *transientID = nil;
    NSString *firstName = @"fname";
    NSString *lastName = @"lname";
    
    [self validateRequestDataWithTransientID:transientID firstName:firstName lastName:lastName];
}

- (void)validateRequestDataWithTransientID:(NSString *)theTransientID firstName:(NSString *)theFirstName lastName:(NSString *)theLastName
{
    NSDictionary *requestData = nil;
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionary];
    NSUInteger expectedCount = 3;
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:mutableDictionary] mutableDictionaryWithCapacity:expectedCount];
    
    [[[[self participantHandlerMock] expect] andReturn:theTransientID] participantIDForParticipant:[self participantMock]];
    
    if (!theTransientID) 
    {
        theTransientID = @"generated_id";
        
        [[[[self participantTransientIDFormatterMock] expect] andReturn:theTransientID] transientIDForParticipant:[self participantMock]];
    }
    
    [[[[self participantHandlerMock] expect] andReturn:theFirstName] firstNameForParticipant:[self participantMock]];
    [[[[self participantHandlerMock] expect] andReturn:theLastName] lastNameForParticipant:[self participantMock]];
    
    requestData = [[self participantRequestDataBuilder] requestDataForParticipant:[self participantMock]];
    
    STAssertEquals(theTransientID, [requestData objectForKey:@"id"], @"Unexpected id");
    
    if ([theFirstName length] > 0) 
    {
        STAssertEquals(theFirstName, [requestData objectForKey:@"firstname"], @"Unexpected firstname");
    }
    else
    {
        --expectedCount;
    }
    
    if ([theLastName length] > 0) 
    {
        STAssertEquals(theLastName, [requestData objectForKey:@"lastname"], @"Unexpected lastname");
    }
    else
    {
        --expectedCount;
    }
    
    STAssertTrue([requestData count] == expectedCount, @"Unexpected count");
    
    [[self mutableDictionaryCreatorMock] verify];
    [[self participantMock] verify];
    [[self participantHandlerMock] verify];
    [[self participantTransientIDFormatterMock] verify];
}

@end
