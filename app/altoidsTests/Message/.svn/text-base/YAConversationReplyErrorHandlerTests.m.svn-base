//
//  YAConversationReplyErrorHandlerTests.m
//  altoids
//
//  Created by Anand Biligiri on 11/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "ManagedObjectContextFactory.h"
#import "MessageHandler.h"
#import "YAConversationReplyErrorHandlerTests.h"
#import "YAConversationReplyErrorHandler.h"
#import "YAMessage.h"

@interface YAConversationReplyErrorHandlerTests()
@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) id managedObjectContextFactoryMock;
@property (strong, nonatomic) id messageMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id objectIDMock;
@end

@implementation YAConversationReplyErrorHandlerTests
@synthesize messageHandlerMock = messageHandlerMock_;
@synthesize messageMock = messageMock_;
@synthesize managedObjectContextFactoryMock = managedObjectContextFactoryMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize objectIDMock = objectIDMock_;

- (void)setUp
{
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];
    [self setManagedObjectContextFactoryMock:[OCMockObject mockForProtocol:@protocol(ManagedObjectContextFactory)]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setMessageMock:[OCMockObject mockForClass:[YAMessage class]]];
    [self setObjectIDMock:[OCMockObject mockForClass:[NSManagedObjectID class]]];
}

// All code under test must be linked into the Unit Test bundle
- (void)testCreateConversationReplyErrorHandlerUsesObjectID
{
    [[[[self messageMock] expect] andReturn:[self objectIDMock]] objectID];
    YAConversationReplyErrorHandler *errorHandler = [[YAConversationReplyErrorHandler alloc] initWithMessage:[self messageMock]
                                                                                             messageHandler:[self messageHandlerMock]
                                                                                managedObjectContextFactory:[self managedObjectContextFactoryMock]];
    
    
    STAssertNotNil(errorHandler, @"Expecing non-nil for errorHandler after create");
    [[self messageMock] verify];
}

- (void)testConversationDoesNotExistError {
    
    [[[[self messageMock] stub] andReturn:[self objectIDMock]] objectID];
    YAConversationReplyErrorHandler *errorHandler = [[YAConversationReplyErrorHandler alloc] initWithMessage:[self messageMock]
                                                                                             messageHandler:[self messageHandlerMock]
                                                                                managedObjectContextFactory:[self managedObjectContextFactoryMock]];


    NSError *error = [NSError errorWithDomain:@"mgr" code:YAMMCServerErrorConversationDoesNotExist userInfo:nil];
    [[[[self managedObjectContextFactoryMock] expect] andReturn:[self managedObjectContextMock]] create];
    [[[[self  managedObjectContextMock] expect] andReturn:[self messageMock]] objectWithID:[self objectIDMock]];
    [[[self messageHandlerMock] expect] setStatusAsPendingWithErrorsForMessage:[self messageMock]];
    [[[self managedObjectContextMock] expect] save:[OCMArg setTo:nil]];
    
    [errorHandler handleError:error];
    [[self managedObjectContextFactoryMock] verify];
    [[self managedObjectContextMock] verify];
    [[self messageHandlerMock] verify];
}

@end
