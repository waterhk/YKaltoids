//
//  YAConversationDeleterTests.m
//  altoids
//
//  Created by Jon Herron on 9/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationDeleterTests.h"
#import "YAConversationDeleter.h"
#import "ConversationFetchRequestCreator.h"
#import "ConversationHandler.h"

@interface YAConversationDeleterTests()

@property (strong, nonatomic) id conversationFetchRequestCreatorMock;
@property (strong, nonatomic) id conversationHandlerMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) YAConversationDeleter *conversationDeleter;

@end

@implementation YAConversationDeleterTests

@synthesize conversationFetchRequestCreatorMock = conversationFetchRequestCreatorMock_;
@synthesize conversationHandlerMock = conversationHandlerMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize conversationDeleter = conversationDeleter_;

- (void)setUp
{
    [super setUp];
    
    [self setConversationFetchRequestCreatorMock:[OCMockObject mockForProtocol:@protocol(ConversationFetchRequestCreator)]];
    [self setConversationHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationHandler)]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    
    [self setConversationDeleter:[[YAConversationDeleter alloc] init]];
    [[self conversationDeleter] setConversationHandler:[self conversationHandlerMock]];
    [[self conversationDeleter] setConversationFetchRequestCreator:[self conversationFetchRequestCreatorMock]];
}

- (void)testDeleteAllConversationsUsesFetchRequestForAllConversations
{
    NSError *error;
    
    [[[self conversationFetchRequestCreatorMock] expect] fetchRequestForAllConversationsInManagedObjectContext:[self managedObjectContextMock]];
    
    [[[self managedObjectContextMock] stub] executeFetchRequest:OCMOCK_ANY error:[OCMArg setTo:nil]];
    
    [[self conversationDeleter] deleteAllConversationsInManagedObjectContext:[self managedObjectContextMock] error:&error];
    STAssertNil(error, @"Unexpected error");
    
    [[self conversationFetchRequestCreatorMock] verify];
}

- (void)testDeleteAllConversationsExecutesFetchRequestUsingGivenManagedObjectContext
{
    id fetchRequestMock = [OCMockObject mockForClass:[NSFetchRequest class]];
    NSError *error;
    
    [[[[self conversationFetchRequestCreatorMock] expect] andReturn:fetchRequestMock] fetchRequestForAllConversationsInManagedObjectContext:[self managedObjectContextMock]];
    
    [[[self managedObjectContextMock] stub] executeFetchRequest:fetchRequestMock error:[OCMArg setTo:nil]];
    
    [[self conversationDeleter] deleteAllConversationsInManagedObjectContext:[self managedObjectContextMock] error:&error];
    STAssertNil(error, @"Unexpected error");
    
    [[self conversationFetchRequestCreatorMock] verify];
}

- (void)testDeleteAllConversationsReturnsIfFetchRequestFails
{
    NSError *error;
    
    [[[self conversationFetchRequestCreatorMock] stub] fetchRequestForAllConversationsInManagedObjectContext:OCMOCK_ANY];
    
    [[[[self managedObjectContextMock] expect] andReturn:nil] executeFetchRequest:OCMOCK_ANY error:[OCMArg setTo:nil]];
    
    [[self conversationDeleter] deleteAllConversationsInManagedObjectContext:[self managedObjectContextMock] error:&error];
    STAssertNil(error, @"Unexpected error");
    
    [[self managedObjectContextMock] verify];
}

- (void)testDeleteAllConversationsReturnsIfNoConversationsAreFetched
{
    NSError *error;
    
    [[[self conversationFetchRequestCreatorMock] stub] fetchRequestForAllConversationsInManagedObjectContext:OCMOCK_ANY];
    
    [[[[self managedObjectContextMock] expect] andReturn:[NSArray array]] executeFetchRequest:OCMOCK_ANY error:[OCMArg setTo:nil]];
    
    STAssertTrue([[self conversationDeleter] deleteAllConversationsInManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected return");
    STAssertNil(error, @"Unexpected error");
    
    [[self managedObjectContextMock] verify];
}

- (void)testDeleteAllConversationsUsesConversationHandlerToDeleteEachFetchedConversation
{
    id conversationMock1 = [OCMockObject mockForClass:[YAConversation class]];
    id conversationMock2 = [OCMockObject mockForClass:[YAConversation class]];
    id conversationMock3 = [OCMockObject mockForClass:[YAConversation class]];
    NSArray *conversations = [NSArray arrayWithObjects:conversationMock1, conversationMock2, conversationMock3, nil];
    NSError *error;
    
    [[[self conversationFetchRequestCreatorMock] stub] fetchRequestForAllConversationsInManagedObjectContext:OCMOCK_ANY];
    
    [[[[self managedObjectContextMock] stub] andReturn:conversations] executeFetchRequest:OCMOCK_ANY error:[OCMArg setTo:nil]];
    
    [[[self conversationHandlerMock] expect] deleteConversation:conversationMock1 inManagedObjectContext:[self managedObjectContextMock]];
    [[[self conversationHandlerMock] expect] deleteConversation:conversationMock2 inManagedObjectContext:[self managedObjectContextMock]];
    [[[self conversationHandlerMock] expect] deleteConversation:conversationMock3 inManagedObjectContext:[self managedObjectContextMock]];
    
    [[[self managedObjectContextMock] stub] save:[OCMArg setTo:nil]];
    
    [[self conversationDeleter] deleteAllConversationsInManagedObjectContext:[self managedObjectContextMock] error:&error];
    STAssertNil(error, @"Unexpected error returned");
    
    [[self conversationHandlerMock] verify];
}

- (void)testDeleteAllConversationsIssuesSaveOnManagedObjectContext
{
    BOOL didSave = YES;
    id conversationMock = [OCMockObject mockForClass:[YAConversation class]];
    NSArray *conversations = [NSArray arrayWithObject:conversationMock];
    NSError *error;
    
    [[[self conversationFetchRequestCreatorMock] stub] fetchRequestForAllConversationsInManagedObjectContext:OCMOCK_ANY];
    [[[[self managedObjectContextMock] stub] andReturn:conversations] executeFetchRequest:OCMOCK_ANY error:[OCMArg setTo:nil]];
    
    [[[self conversationHandlerMock] stub] deleteConversation:OCMOCK_ANY inManagedObjectContext:[self managedObjectContextMock]];
    
    [[[[self managedObjectContextMock] expect] andReturnValue:OCMOCK_VALUE(didSave)] save:[OCMArg setTo:nil]];
    
    STAssertTrue([[self conversationDeleter] deleteAllConversationsInManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected return");
    STAssertNil(error, @"Unexpected error");
    
    [[self managedObjectContextMock] verify];
}

@end
