//
//  YAConversationLocatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationLocatorTests.h"
#import "ConversationFetchRequestCreator.h"
#import "YAConversationLocator.h"

@interface YAConversationLocatorTests()

@property (strong, nonatomic) id conversationFetchRequestCreatorMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id fetchRequestMock;
@property (strong, nonatomic) NSArray *converationIDs;
@property (strong, nonatomic) YAConversationLocator *conversationLocator;

@end

@implementation YAConversationLocatorTests

@synthesize conversationFetchRequestCreatorMock = conversationFetchRequestCreatorMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize fetchRequestMock = fetchRequestMock_;
@synthesize converationIDs = converationIDs_;
@synthesize conversationLocator = conversationLocator_;

- (void)setUp
{
    [super setUp];
    
    [self setConversationFetchRequestCreatorMock:[OCMockObject mockForProtocol:@protocol(ConversationFetchRequestCreator)]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setFetchRequestMock:[OCMockObject mockForClass:[NSFetchRequest class]]];
    [self setConverationIDs:[NSArray array]];
    [self setConversationLocator:[[YAConversationLocator alloc] init]];
    [[self conversationLocator] setConversationFetchRequestCreator:[self conversationFetchRequestCreatorMock]];
}

- (void)testConversationsWithIDsUsesConversationFetchRequestCreatorToCreateFetchRequestMatchingGivenConversationIDsInGivenManagedObjectContext
{
    [[[self conversationFetchRequestCreatorMock] expect] fetchRequestForConversationsWithIDs:[self converationIDs] inManagedObjectContext:[self managedObjectContextMock]];
    
    [[self conversationLocator] conversationsWithIDs:[self converationIDs] inManagedObjectContext:[self managedObjectContextMock]];
    
    [[self conversationFetchRequestCreatorMock] verify];
}

- (void)testConversationsWithIDsReturnsNilIfConversationFetchRequestCreatorReturnsNil
{
    [[[[self conversationFetchRequestCreatorMock] expect] andReturn:nil] fetchRequestForConversationsWithIDs:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    
    STAssertNil([[self conversationLocator] conversationsWithIDs:nil inManagedObjectContext:nil], @"Unexpected non-nil results");
    
    [[self conversationFetchRequestCreatorMock] verify];
}

- (void)testConversationsWithIDsExecutesFetchRequestUsingGivenManagedObjectContext
{
    [[[[self conversationFetchRequestCreatorMock] stub] andReturn:[self fetchRequestMock]] fetchRequestForConversationsWithIDs:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    
    [[[self managedObjectContextMock] expect] executeFetchRequest:[self fetchRequestMock] error:[OCMArg setTo:nil]];
    
    [[self conversationLocator] conversationsWithIDs:OCMOCK_ANY inManagedObjectContext:[self managedObjectContextMock]];
    
    [[self managedObjectContextMock] verify];
}

- (void)testConversationsWithIDsReturnsNilIfManagedObjectContextReturnsNilWhenExecutingFetchRequest
{
    [[[[self conversationFetchRequestCreatorMock] stub] andReturn:[self fetchRequestMock]] fetchRequestForConversationsWithIDs:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    
    [[[[self managedObjectContextMock] expect] andReturn:nil] executeFetchRequest:OCMOCK_ANY error:[OCMArg setTo:nil]];
    
    STAssertNil([[self conversationLocator] conversationsWithIDs:OCMOCK_ANY inManagedObjectContext:[self managedObjectContextMock]], @"Unexpected non-nil results");
    
    [[self managedObjectContextMock] verify];
}

- (void)testConversationsWithIDsReturnsNilIfManagedObjectContextSetsErrorWhenExecutingFetchRequest
{
    NSError *error = [NSError errorWithDomain:@"d" code:1 userInfo:[NSDictionary dictionary]];
    
    [[[[self conversationFetchRequestCreatorMock] stub] andReturn:[self fetchRequestMock]] fetchRequestForConversationsWithIDs:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    
    [[[[self managedObjectContextMock] expect] andReturn:[NSArray array]] executeFetchRequest:OCMOCK_ANY error:[OCMArg setTo:error]];
    
    STAssertNil([[self conversationLocator] conversationsWithIDs:OCMOCK_ANY inManagedObjectContext:[self managedObjectContextMock]], @"Unexpected non-nil results");
    
    [[self managedObjectContextMock] verify];
}

- (void)testConversationsWithIDsReturnsArrayReturnedFromManagedObjectContextWhenExecutingFetchRequset
{
    NSArray *conversations = [NSArray array];
    
    [[[[self conversationFetchRequestCreatorMock] stub] andReturn:[self fetchRequestMock]] fetchRequestForConversationsWithIDs:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    
    [[[[self managedObjectContextMock] expect] andReturn:conversations] executeFetchRequest:OCMOCK_ANY error:[OCMArg setTo:nil]];
    
    STAssertEqualObjects(conversations, [[self conversationLocator] conversationsWithIDs:OCMOCK_ANY inManagedObjectContext:[self managedObjectContextMock]], @"Unexpected results");
    
    [[self managedObjectContextMock] verify];
}

@end
