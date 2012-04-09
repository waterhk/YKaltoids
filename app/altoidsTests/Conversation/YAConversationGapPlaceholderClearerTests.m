//
//  YAConversationGapPlaceholderClearerTests.m
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientConversationListGapHandling
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "YAConversationGapPlaceholderClearer.h"
#import "YAConversation.h"
#import "MutableArrayCreator.h"
#import "ConversationPredicateCreator.h"
#import "ConversationHandler.h"


@interface YAConversationGapPlaceholderClearerTests : SenTestCase

@property (strong, nonatomic) id mutableArrayMock;
@property (strong, nonatomic) id mutableArrayCreatorMock;
@property (strong, nonatomic) id conversationPredicateCreatorMock;
@property (strong, nonatomic) id conversationHandlerMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id predicateMock;
@property (strong, nonatomic) YAConversationGapPlaceholderClearer *conversationGapPlaceholderClearer;

@end

@implementation YAConversationGapPlaceholderClearerTests

@synthesize mutableArrayMock = mutableArrayMock_;
@synthesize mutableArrayCreatorMock = mutableArrayCreatorMock_;
@synthesize conversationPredicateCreatorMock = conversationPredicateCreatorMock_;
@synthesize conversationHandlerMock = conversationHandlerMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize predicateMock = predicateMock_;
@synthesize conversationGapPlaceholderClearer = conversationGapPlaceholderClearer_;

- (void)setUp
{
    [super setUp];
    
    [self setMutableArrayMock:[OCMockObject mockForClass:[NSMutableArray class]]];
    [self setMutableArrayCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableArrayCreator)]];
    [self setConversationPredicateCreatorMock:[OCMockObject mockForProtocol:@protocol(ConversationPredicateCreator)]];
    [self setConversationHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationHandler)]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setPredicateMock:[OCMockObject mockForClass:[NSPredicate class]]];
    
    [self setConversationGapPlaceholderClearer:[[YAConversationGapPlaceholderClearer alloc] init]];
    [[self conversationGapPlaceholderClearer] setConversationHandler:[self conversationHandlerMock]];
    [[self conversationGapPlaceholderClearer] setConversationPredicateCreator:[self conversationPredicateCreatorMock]];
    [[self conversationGapPlaceholderClearer] setMutableArrayCreator:[self mutableArrayCreatorMock]];
}

- (void)testIfConversationListIsEmptyClearReturnsEmptyArray
{
    NSArray *conversationList = [NSArray array];
    NSUInteger capacity = [conversationList count];
    
    [[[[self mutableArrayCreatorMock] stub] andReturn:[self mutableArrayMock]] mutableArrayWithCapacity:capacity];
    [[[self conversationPredicateCreatorMock] stub] predicateMatchingConversationGapPlaceholders];
    
    [[self conversationGapPlaceholderClearer] clearConversationGapPlaceholdersInListOfConversations:conversationList inManagedObjectContext:[self managedObjectContextMock] moreConversationsPresentOnServer:NO];
    
    [[self mutableArrayMock] verify];
}

- (void)testClearUsesMutableArrayCreatorToCreateNewMutableArrayToHoldNonGapPlaceholderConversations
{
    NSArray *conversationList = [NSArray array];
    NSUInteger capacity = [conversationList count];
    
    [[[[self mutableArrayCreatorMock] expect] andReturn:[self mutableArrayMock]] mutableArrayWithCapacity:capacity];
    [[[self conversationPredicateCreatorMock] stub] predicateMatchingConversationGapPlaceholders];
    
    STAssertEqualObjects([self mutableArrayMock], [[self conversationGapPlaceholderClearer] clearConversationGapPlaceholdersInListOfConversations:conversationList inManagedObjectContext:[self managedObjectContextMock] moreConversationsPresentOnServer:NO], @"Unexpected cleared list");
}

- (void)testClearUsesConversationPredicateCreatorToCreatePredicateUsedToFindConversationGapPlaceholders
{
    id conversationMock = [OCMockObject mockForClass:[YAConversation class]];
    NSArray *conversationList = [NSArray arrayWithObject:conversationMock];
    NSUInteger capacity = [conversationList count];
    
    [[[self predicateMock] expect] evaluateWithObject:conversationMock];
    [[[[self conversationPredicateCreatorMock] expect] andReturn:[self predicateMock]] predicateMatchingConversationGapPlaceholders];

    [[[self mutableArrayCreatorMock] stub] mutableArrayWithCapacity:capacity];
    [[[self conversationHandlerMock] stub] deleteConversation:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    
    [[self conversationGapPlaceholderClearer] clearConversationGapPlaceholdersInListOfConversations:conversationList inManagedObjectContext:[self managedObjectContextMock] moreConversationsPresentOnServer:NO];
    
    [[self predicateMock] verify];
    [[self conversationPredicateCreatorMock] verify];
}

- (void)testClearTestsEachConversationInListWithPredicate
{
    id conversationMock1 = [OCMockObject mockForClass:[YAConversation class]];
    id conversationMock2 = [OCMockObject mockForClass:[YAConversation class]];
    id conversationMock3 = [OCMockObject mockForClass:[YAConversation class]];
    NSArray *conversationList = [NSArray arrayWithObjects:conversationMock1, conversationMock2, conversationMock3, nil];
    NSUInteger capacity = [conversationList count];
    
    [[[self predicateMock] expect] evaluateWithObject:conversationMock1];
    [[[self predicateMock] expect] evaluateWithObject:conversationMock2];
    [[[self predicateMock] expect] evaluateWithObject:conversationMock3];
    
    [[[self mutableArrayCreatorMock] stub] mutableArrayWithCapacity:capacity];
    [[[[self conversationPredicateCreatorMock] stub] andReturn:[self predicateMock]] predicateMatchingConversationGapPlaceholders];
    [[[self conversationHandlerMock] stub] deleteConversation:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    
    [[self conversationGapPlaceholderClearer] clearConversationGapPlaceholdersInListOfConversations:conversationList inManagedObjectContext:[self managedObjectContextMock] moreConversationsPresentOnServer:NO];
    
    [[self predicateMock] verify];
}

- (void)testClearUsesConversationHandlerToDeleteConversationIfPredicateReturnsTrue
{
    BOOL predicateResult = YES;
    id conversationMock1 = [OCMockObject mockForClass:[YAConversation class]];
    id conversationMock2 = [OCMockObject mockForClass:[YAConversation class]];
    id conversationMock3 = [OCMockObject mockForClass:[YAConversation class]];
    NSArray *conversationList = [NSArray arrayWithObjects:conversationMock1, conversationMock2, conversationMock3, nil];
    NSUInteger capacity = [conversationList count];
    
    [[[self conversationHandlerMock] expect] deleteConversation:conversationMock1 inManagedObjectContext:[self managedObjectContextMock]];
    [[[self conversationHandlerMock] expect] deleteConversation:conversationMock2 inManagedObjectContext:[self managedObjectContextMock]];
    [[[self conversationHandlerMock] expect] deleteConversation:conversationMock3 inManagedObjectContext:[self managedObjectContextMock]];
    
    [[[self mutableArrayCreatorMock] stub] mutableArrayWithCapacity:capacity];
    [[[[self predicateMock] stub] andReturnValue:OCMOCK_VALUE(predicateResult)] evaluateWithObject:OCMOCK_ANY];
    [[[[self conversationPredicateCreatorMock] stub] andReturn:[self predicateMock]] predicateMatchingConversationGapPlaceholders];
    
    [[self conversationGapPlaceholderClearer] clearConversationGapPlaceholdersInListOfConversations:conversationList inManagedObjectContext:[self managedObjectContextMock] moreConversationsPresentOnServer:NO];
    
    [[self conversationHandlerMock] verify];
}

- (void)testClearAddsConversationToNonGapListIfPredicateReturnsFalse
{
    BOOL predicateResult = NO;
    id conversationMock1 = [OCMockObject mockForClass:[YAConversation class]];
    id conversationMock2 = [OCMockObject mockForClass:[YAConversation class]];
    id conversationMock3 = [OCMockObject mockForClass:[YAConversation class]];
    NSArray *conversationList = [NSArray arrayWithObjects:conversationMock1, conversationMock2, conversationMock3, nil];
    NSUInteger capacity = [conversationList count];
    
    [[[self mutableArrayMock] expect] addObject:conversationMock1];
    [[[self mutableArrayMock] expect] addObject:conversationMock2];
    [[[self mutableArrayMock] expect] addObject:conversationMock3];
    
    [[[[self mutableArrayCreatorMock] stub] andReturn:[self mutableArrayMock]] mutableArrayWithCapacity:capacity];
    [[[[self predicateMock] stub] andReturnValue:OCMOCK_VALUE(predicateResult)] evaluateWithObject:OCMOCK_ANY];
    [[[[self conversationPredicateCreatorMock] stub] andReturn:[self predicateMock]] predicateMatchingConversationGapPlaceholders];
    
    [[self conversationGapPlaceholderClearer] clearConversationGapPlaceholdersInListOfConversations:conversationList inManagedObjectContext:[self managedObjectContextMock] moreConversationsPresentOnServer:NO];
    
    [[self conversationHandlerMock] verify];
}

- (void)testClearWillClearAGapIfItIsTheLastInTheConversationListAndMoreConversationsArePresentOnTheServer
{
    BOOL predicateResult = YES;
    id conversationMock1 = [OCMockObject mockForClass:[YAConversation class]];
    id conversationMock2 = [OCMockObject mockForClass:[YAConversation class]];
    id conversationMock3 = [OCMockObject mockForClass:[YAConversation class]];
    NSArray *conversationList = [NSArray arrayWithObjects:conversationMock1, conversationMock2, conversationMock3, nil];
    NSUInteger capacity = [conversationList count];
    
    [[[[self mutableArrayCreatorMock] stub] andReturn:[self mutableArrayMock]] mutableArrayWithCapacity:capacity];
    [[[[self predicateMock] expect] andReturnValue:OCMOCK_VALUE(predicateResult)] evaluateWithObject:conversationMock1];
    [[[[self predicateMock] expect] andReturnValue:OCMOCK_VALUE(predicateResult)] evaluateWithObject:conversationMock2];
    [[[[self predicateMock] expect] andReturnValue:OCMOCK_VALUE(predicateResult)] evaluateWithObject:conversationMock3];
    [[[[self conversationPredicateCreatorMock] stub] andReturn:[self predicateMock]] predicateMatchingConversationGapPlaceholders];
    
    [[[self conversationHandlerMock] expect] deleteConversation:conversationMock1 inManagedObjectContext:[self managedObjectContextMock]];
    [[[self conversationHandlerMock] expect] deleteConversation:conversationMock2 inManagedObjectContext:[self managedObjectContextMock]];
    [[[self conversationHandlerMock] expect] deleteConversation:conversationMock3 inManagedObjectContext:[self managedObjectContextMock]];
    
    [[self conversationGapPlaceholderClearer] clearConversationGapPlaceholdersInListOfConversations:conversationList inManagedObjectContext:[self managedObjectContextMock] moreConversationsPresentOnServer:YES];
    
    [[self conversationHandlerMock] verify];
    [[self mutableArrayMock] verify];
    [[self predicateMock] verify];
}

@end
