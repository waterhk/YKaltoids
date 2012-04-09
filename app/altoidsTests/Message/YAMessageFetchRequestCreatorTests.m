//
//  YAMessageFetchRequestCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMessageFetchRequestCreatorTests.h"
#import "MessageEntityDescriptionCreator.h"
#import "MessagePredicateCreator.h"
#import "FetchRequestCreator.h"
#import "YAMessageFetchRequestCreator.h"

@interface YAMessageFetchRequestCreatorTests()

@property (strong, nonatomic) id sortDescriptorsMock;
@property (strong, nonatomic) id entityDescriptionMock;
@property (strong, nonatomic) id predicateMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id fetchRequestMock;
@property (strong, nonatomic) id messageIDsMock;
@property (strong, nonatomic) id fetchRequestCreatorMock;
@property (strong, nonatomic) id messageEntityDescriptionCreatorMock;
@property (strong, nonatomic) id messagePredicateCreatorMock;
@property (strong, nonatomic) YAMessageFetchRequestCreator *messageFetchRequestCreator;

- (void)verifyMocks;

@end

@implementation YAMessageFetchRequestCreatorTests

@synthesize sortDescriptorsMock = sortDescriptorsMock_;
@synthesize entityDescriptionMock = entityDescriptionMock_;
@synthesize predicateMock = predicateMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize fetchRequestMock = fetchRequestMock_;
@synthesize messageIDsMock = messageIDsMock_;
@synthesize fetchRequestCreatorMock = fetchRequestCreatorMock_;
@synthesize messageEntityDescriptionCreatorMock = messageEntityDescriptionCreatorMock_;
@synthesize messagePredicateCreatorMock = messagePredicateCreatorMock_;
@synthesize messageFetchRequestCreator = messageFetchRequestCreator_;

- (void)setUp
{
    [self setSortDescriptorsMock:[OCMockObject mockForClass:[NSArray class]]];
    [self setEntityDescriptionMock:[OCMockObject mockForClass:[NSEntityDescription class]]];
    [self setPredicateMock:[OCMockObject mockForClass:[NSPredicate class]]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setFetchRequestMock:[OCMockObject mockForClass:[NSFetchRequest class]]];
    [self setMessageIDsMock:[OCMockObject mockForClass:[NSArray array]]];
    
    [self setFetchRequestCreatorMock:[OCMockObject mockForProtocol:@protocol(FetchRequestCreator)]];
    [self setMessageEntityDescriptionCreatorMock:[OCMockObject mockForProtocol:@protocol(MessageEntityDescriptionCreator)]];
    [self setMessagePredicateCreatorMock:[OCMockObject mockForProtocol:@protocol(MessagePredicateCreator)]];
    [self setSortDescriptorsMock:[OCMockObject mockForClass:[NSArray class]]];
    
    [self setMessageFetchRequestCreator:[[YAMessageFetchRequestCreator alloc] init]];
    [[self messageFetchRequestCreator] setFetchRequestCreator:[self fetchRequestCreatorMock]];
    [[self messageFetchRequestCreator] setMessageEntityDescriptionCreator:[self messageEntityDescriptionCreatorMock]];
    [[self messageFetchRequestCreator] setMessagePredicateCreator:[self messagePredicateCreatorMock]];
    [[self messageFetchRequestCreator] setSortDescriptors:[self sortDescriptorsMock]];
}

- (void)testCanCreateFetchRequestForAllMessagesInGivenManagedObjectContext
{
    [[[[self messageEntityDescriptionCreatorMock] expect] andReturn:[self entityDescriptionMock]] messageEntityDescriptionInManagedObjectContext:[self managedObjectContextMock]];
    [[[[self fetchRequestCreatorMock] expect] andReturn:[self fetchRequestMock]] fetchRequestForEntity:[self entityDescriptionMock] withSortDescriptors:[self sortDescriptorsMock]];
    
    STAssertEqualObjects([self fetchRequestMock], [[self messageFetchRequestCreator] fetchRequestForAllMessagesInManagedObjectContext:[self managedObjectContextMock]], @"Unexpected fetch request");
    
    [self verifyMocks];
}

- (void)testCanCreateFetchRequestForAllMessagesMatchingGivenArrayOfIDsInGivenManagedObjectContext
{
    [[[[self messageEntityDescriptionCreatorMock] expect] andReturn:[self entityDescriptionMock]] messageEntityDescriptionInManagedObjectContext:[self managedObjectContextMock]];
    [[[[self messagePredicateCreatorMock] expect] andReturn:[self predicateMock]] predicateMatchingMessagesByID:[self messageIDsMock]];
    [[[[self fetchRequestCreatorMock] expect] andReturn:[self fetchRequestMock]] fetchRequestForEntity:[self entityDescriptionMock] withPredicate:[self predicateMock] sortDescriptors:[self sortDescriptorsMock]];
    
    STAssertEqualObjects([self fetchRequestMock], [[self messageFetchRequestCreator] fetchRequestForMessagesMatchingIDs:[self messageIDsMock] inManagedObjectContext:[self managedObjectContextMock]], @"Unexpected fetch request");
    
    [self verifyMocks];
}

- (void)testCanCreateFetchRequestForAllMessagesInConversationWithIDInManagedObjectContext
{
    NSString *conversationID = @"cid";
    
    [[[[self messageEntityDescriptionCreatorMock] expect] andReturn:[self entityDescriptionMock]] messageEntityDescriptionInManagedObjectContext:[self managedObjectContextMock]];
    [[[[self messagePredicateCreatorMock] expect] andReturn:[self predicateMock]] predicateMatchingMessagesInConversationWithID:conversationID];
    [[[[self fetchRequestCreatorMock] expect] andReturn:[self fetchRequestMock]] fetchRequestForEntity:[self entityDescriptionMock] withPredicate:[self predicateMock] sortDescriptors:[self sortDescriptorsMock]];
    
    STAssertEqualObjects([self fetchRequestMock], [[self messageFetchRequestCreator] fetchRequestForMessagesInConversationWithID:conversationID inManagedObjectContext:[self managedObjectContextMock]], @"Unexpected fetch request");
    
    [self verifyMocks];
}

- (void)verifyMocks
{
    [[self sortDescriptorsMock] verify];
    [[self entityDescriptionMock] verify];
    [[self predicateMock] verify];
    [[self managedObjectContextMock] verify];
    [[self fetchRequestMock] verify];
    [[self messageIDsMock] verify];
    [[self fetchRequestCreatorMock] verify];
    [[self messageEntityDescriptionCreatorMock] verify];
    [[self messagePredicateCreatorMock] verify];
}

@end
