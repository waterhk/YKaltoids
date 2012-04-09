//
//  YAMessageLocatorTests.m
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMessageLocatorTests.h"
#import "MessageFetchRequestCreator.h"
#import "YAMessageLocator.h"

@interface YAMessageLocatorTests()

@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id messageIDsMock;
@property (strong, nonatomic) id fetchRequestMock;
@property (strong, nonatomic) id messagesMock;
@property (strong, nonatomic) id messageFetchRequestCreatorMock;
@property (strong, nonatomic) YAMessageLocator *messageLocator;

- (void)verifyMocks;

@end

@implementation YAMessageLocatorTests

@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize messageIDsMock = messageIDsMock_;
@synthesize fetchRequestMock = fetchRequestMock_;
@synthesize messagesMock = messagesMock_;
@synthesize messageFetchRequestCreatorMock = messageFetchRequestCreatorMock_;
@synthesize messageLocator = messageLocator_;

- (void)setUp
{
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setMessageIDsMock:[OCMockObject mockForClass:[NSArray class]]];
    [self setFetchRequestMock:[OCMockObject mockForClass:[NSFetchRequest class]]];
    [self setMessagesMock:[OCMockObject mockForClass:[NSArray class]]];
    [self setMessageFetchRequestCreatorMock:[OCMockObject mockForProtocol:@protocol(MessageFetchRequestCreator)]];
    
    [self setMessageLocator:[[YAMessageLocator alloc] init]];
    [[self messageLocator] setMessageFetchRequestCreator:[self messageFetchRequestCreatorMock]];
}

- (void)testReturnsMessageEntitiesMatchingGivenMessageIDsInGivenManagedObjectContext
{
    [[[[self messageFetchRequestCreatorMock] expect] andReturn:[self fetchRequestMock]] fetchRequestForMessagesMatchingIDs:[self messageIDsMock] inManagedObjectContext:[self managedObjectContextMock]];
    [[[[self managedObjectContextMock] expect] andReturn:[self messagesMock]] executeFetchRequest:[self fetchRequestMock] error:[OCMArg setTo:nil]];
    
    STAssertEqualObjects([self messagesMock], [[self messageLocator] messagesMatchingIDs:[self messageIDsMock] inManagedObjectContext:[self managedObjectContextMock]], @"Unexpected messages");
    
    [self verifyMocks];
}

- (void)testIfFetchRequestCouldNotBeCreatedLocatorReturnsNil
{
    [[[[self messageFetchRequestCreatorMock] expect] andReturn:nil] fetchRequestForMessagesMatchingIDs:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    
    STAssertNil([[self messageLocator] messagesMatchingIDs:nil inManagedObjectContext:nil], @"Expected nil return");
    
    [self verifyMocks];
}

- (void)testIfManagedObjectContextFailsToExecuteFetchRequestLocatorReturnsNil
{
    [[[[self messageFetchRequestCreatorMock] stub] andReturn:[self fetchRequestMock]] fetchRequestForMessagesMatchingIDs:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    [[[[self managedObjectContextMock] expect] andReturn:nil] executeFetchRequest:OCMOCK_ANY error:[OCMArg setTo:nil]];
    
    STAssertNil([[self messageLocator] messagesMatchingIDs:nil inManagedObjectContext:[self managedObjectContextMock]], @"Expected nil return");
    
    [self verifyMocks];
}

- (void)verifyMocks
{
    [[self managedObjectContextMock] verify];
    [[self messageIDsMock] verify];
    [[self fetchRequestMock] verify];
    [[self messagesMock] verify];
    [[self messageFetchRequestCreatorMock] verify];
}

@end
