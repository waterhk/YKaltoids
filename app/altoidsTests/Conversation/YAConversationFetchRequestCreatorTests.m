//
//  YAConversationFetchRequestCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationFetchRequestCreatorTests.h"
#import "YAConversationFetchRequestCreator.h"

@interface YAConversationFetchRequestCreatorTests()

@property (strong, nonatomic) id fetchRequestCreatorMock;
@property (strong, nonatomic) id conversationEntityDescriptionCreatorMock;
@property (strong, nonatomic) id conversationPredicateCreatorMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id sortDescriptorsMock;
@property (strong, nonatomic) YAConversationFetchRequestCreator *conversationFetchRequestCreator;

@end

@implementation YAConversationFetchRequestCreatorTests

@synthesize fetchRequestCreatorMock = fetchRequestCreatorMock_;
@synthesize conversationEntityDescriptionCreatorMock = conversationEntityDescriptionCreatorMock_;
@synthesize conversationPredicateCreatorMock = conversationPredicateCreatorMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize sortDescriptorsMock = sortDescriptorsMock_;
@synthesize conversationFetchRequestCreator = conversationFetchRequestCreator_;

- (void)setUp
{
    [super setUp];
    
    [self setFetchRequestCreatorMock:[OCMockObject mockForProtocol:@protocol(FetchRequestCreator)]];
    [self setConversationEntityDescriptionCreatorMock:[OCMockObject mockForProtocol:@protocol(ConversationEntityDescriptionCreator)]];
    [self setConversationPredicateCreatorMock:[OCMockObject mockForProtocol:@protocol(ConversationPredicateCreator)]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    
    [self setSortDescriptorsMock:[OCMockObject mockForClass:[NSArray class]]];
    
    [self setConversationFetchRequestCreator:[[YAConversationFetchRequestCreator alloc] init]];
    [[self conversationFetchRequestCreator] setFetchRequestCreator:[self fetchRequestCreatorMock]];
    [[self conversationFetchRequestCreator] setConversationEntityDescriptionCreator:[self conversationEntityDescriptionCreatorMock]];
    [[self conversationFetchRequestCreator] setConversationPredicateCreator:[self conversationPredicateCreatorMock]];
    [[self conversationFetchRequestCreator] setSortDescriptors:[self sortDescriptorsMock]];
}

- (void)testFetchRequestForAllConversationsUsesEntityDescriptionCreatorToCreateConverationEntityInManagedObjectContext
{
    [[[self conversationEntityDescriptionCreatorMock] expect] conversationEntityDescriptionInManagedObjectContext:[self managedObjectContextMock]];
    
    [[[self fetchRequestCreatorMock] stub] fetchRequestForEntity:OCMOCK_ANY withSortDescriptors:OCMOCK_ANY];
    
    [[self conversationFetchRequestCreator] fetchRequestForAllConversationsInManagedObjectContext:[self managedObjectContextMock]];
    
    [[self conversationEntityDescriptionCreatorMock] verify];
}

- (void)testFetchRequestForAllConversationsUsesConversationListSortDescriptors
{
    [[[self conversationEntityDescriptionCreatorMock] stub] conversationEntityDescriptionInManagedObjectContext:OCMOCK_ANY];
    
    [[[self fetchRequestCreatorMock] stub] fetchRequestForEntity:OCMOCK_ANY withSortDescriptors:[self sortDescriptorsMock]];
    
    [[self conversationFetchRequestCreator] fetchRequestForAllConversationsInManagedObjectContext:nil];
    
    [[self conversationEntityDescriptionCreatorMock] verify];
}

- (void)testFetchRequestForAllConversationsUsesFetchRequestCreatorToCreateFetchRequestWithConversationEntityDescriptionSortDescriptors
{
    id entityDescriptionMock = [OCMockObject mockForClass:[NSEntityDescription class]];
    
    [[[[self conversationEntityDescriptionCreatorMock] stub] andReturn:entityDescriptionMock] conversationEntityDescriptionInManagedObjectContext:[self managedObjectContextMock]];
    
    [[[self fetchRequestCreatorMock] expect] fetchRequestForEntity:entityDescriptionMock withSortDescriptors:OCMOCK_ANY];
    
    [[self conversationFetchRequestCreator] fetchRequestForAllConversationsInManagedObjectContext:[self managedObjectContextMock]];
    
    [[self fetchRequestCreatorMock] verify];
}

- (void)testFetchRequestForConversationsMatchingIDsUsesEntityDescriptionCreatorToCreateConversationEntityInManagedObjectContext
{
    [[[self conversationEntityDescriptionCreatorMock] expect] conversationEntityDescriptionInManagedObjectContext:[self managedObjectContextMock]];
    
    [[[self conversationPredicateCreatorMock] stub] predicateMatchingConversationsByID:OCMOCK_ANY];
    [[[self fetchRequestCreatorMock] stub] fetchRequestForEntity:OCMOCK_ANY withPredicate:OCMOCK_ANY sortDescriptors:OCMOCK_ANY];
    
    [[self conversationFetchRequestCreator] fetchRequestForConversationsWithIDs:nil inManagedObjectContext:[self managedObjectContextMock]];
    
    [[self conversationEntityDescriptionCreatorMock] verify];
}

- (void)testFetchRequestForConversationsMatchingIDsUsesConversationPredicateCreatorToCreatePredicateMatchingConversationIDs
{
    NSArray *conversationIDs = [NSArray array];
    
    [[[self conversationPredicateCreatorMock] expect] predicateMatchingConversationsByID:conversationIDs];
    
    [[[self conversationEntityDescriptionCreatorMock] stub] conversationEntityDescriptionInManagedObjectContext:OCMOCK_ANY];
    [[[self fetchRequestCreatorMock] stub] fetchRequestForEntity:OCMOCK_ANY withPredicate:OCMOCK_ANY sortDescriptors:OCMOCK_ANY];
    
    [[self conversationFetchRequestCreator] fetchRequestForConversationsWithIDs:conversationIDs inManagedObjectContext:[self managedObjectContextMock]];
    
    [[self conversationPredicateCreatorMock] verify];
}

- (void)testFetchRequestForConversationsMatchingIDsUsesConversationSortDescriptorCreatorToCreatorConversationListSortDescriptors
{
    [[[self conversationPredicateCreatorMock] stub] predicateMatchingConversationsByID:OCMOCK_ANY];
    [[[self conversationEntityDescriptionCreatorMock] stub] conversationEntityDescriptionInManagedObjectContext:OCMOCK_ANY];
    [[[self fetchRequestCreatorMock] stub] fetchRequestForEntity:OCMOCK_ANY withPredicate:OCMOCK_ANY sortDescriptors:[self sortDescriptorsMock]];
    
    [[self conversationFetchRequestCreator] fetchRequestForConversationsWithIDs:nil inManagedObjectContext:[self managedObjectContextMock]];
    
    [[self fetchRequestCreatorMock] verify];
}

- (void)testFetchRequestForConversationsMatchingIDsUsesFetchRequestCreatorToCreateFetchRequestWithConverationEntityAndPredicateSortDescriptors
{
    id entityDescriptionMock = [OCMockObject mockForClass:[NSEntityDescription class]];
    id predicateMock = [OCMockObject mockForClass:[NSPredicate class]];
    
    [[[self fetchRequestCreatorMock] expect] fetchRequestForEntity:entityDescriptionMock withPredicate:predicateMock sortDescriptors:[self sortDescriptorsMock]];
    
    [[[[self conversationEntityDescriptionCreatorMock] stub] andReturn:entityDescriptionMock] conversationEntityDescriptionInManagedObjectContext:OCMOCK_ANY];
    [[[[self conversationPredicateCreatorMock] stub] andReturn:predicateMock] predicateMatchingConversationsByID:OCMOCK_ANY];
    
    [[self conversationFetchRequestCreator] fetchRequestForConversationsWithIDs:nil inManagedObjectContext:nil];
    
    [[self fetchRequestCreatorMock] verify];
}

- (void)testFetchRequestForConversationsMatchingIDsReturnsResultsFromFetchRequestCreator
{
    id fetchRequestMock = [OCMockObject mockForClass:[NSFetchRequest class]];
    
    [[[self conversationEntityDescriptionCreatorMock] stub] conversationEntityDescriptionInManagedObjectContext:OCMOCK_ANY];
    [[[self conversationPredicateCreatorMock] stub] predicateMatchingConversationsByID:OCMOCK_ANY];
    [[[[self fetchRequestCreatorMock] stub] andReturn:fetchRequestMock] fetchRequestForEntity:OCMOCK_ANY withPredicate:OCMOCK_ANY sortDescriptors:OCMOCK_ANY];
    
    STAssertEqualObjects(fetchRequestMock, [[self conversationFetchRequestCreator] fetchRequestForConversationsWithIDs:nil inManagedObjectContext:nil], @"Unexpected fetch request");
}

- (void)testCanCreateFetchRequestForConversationMatchingID
{
    id entityDescriptionMock = [OCMockObject mockForClass:[NSEntityDescription class]];
    id predicateMock = [OCMockObject mockForClass:[NSPredicate class]];
    id fetchRequestMock = [OCMockObject mockForClass:[NSFetchRequest class]];
    NSString *conversationID = @"cid";
    
    [[[[self conversationEntityDescriptionCreatorMock] expect] andReturn:entityDescriptionMock] conversationEntityDescriptionInManagedObjectContext:[self managedObjectContextMock]];
    [[[[self conversationPredicateCreatorMock] expect] andReturn:predicateMock] predicateMatchingConversationByID:conversationID];
    [[[[self fetchRequestCreatorMock] expect] andReturn:fetchRequestMock] fetchRequestForEntity:entityDescriptionMock withPredicate:predicateMock sortDescriptors:[self sortDescriptorsMock]];
    
    STAssertEqualObjects(fetchRequestMock, [[self conversationFetchRequestCreator] fetchRequestForConversationWithID:conversationID inManagedObjectContext:[self managedObjectContextMock]], @"Unexpected fetch request");
}

@end
