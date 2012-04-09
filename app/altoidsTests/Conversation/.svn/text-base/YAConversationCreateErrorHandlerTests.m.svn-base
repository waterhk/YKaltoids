//
//  YAConversationCreateErrorHandlerTests.m
//  altoids
//
//  Created by Jon Herron on 11/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationCreateErrorHandlerTests.h"
#import "YAConversationCreateErrorHandler.h"
#import "ConversationHandler.h"
#import "ManagedObjectContextFactory.h"
#import "YAConversation.h"
#import "MessageHandler.h"

@interface YAConversationCreateErrorHandlerTests()

@property (strong, nonatomic) id conversationHandlerMock;
@property (strong, nonatomic) id managedObjectContextFactoryMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id conversationObjectIDMock;
@property (strong, nonatomic) id conversationMock;
@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) YAConversationCreateErrorHandler *conversationCreateErrorHandler;

@end

@implementation YAConversationCreateErrorHandlerTests

@synthesize conversationHandlerMock = conversationHandlerMock_;
@synthesize managedObjectContextFactoryMock = managedObjectContextFactoryMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize conversationObjectIDMock = conversationObjectIDMock_;
@synthesize conversationMock = conversationMock_;
@synthesize messageHandlerMock = messageHandlerMock_;
@synthesize conversationCreateErrorHandler = conversationCreateErrorHandler_;

- (void)setUp
{
    [self setConversationHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationHandler)]];
    [self setManagedObjectContextFactoryMock:[OCMockObject mockForProtocol:@protocol(ManagedObjectContextFactory)]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setConversationObjectIDMock:[OCMockObject mockForClass:[NSManagedObjectID class]]];
    [self setConversationMock:[OCMockObject mockForClass:[YAConversation class]]];
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];
    
    [self setConversationCreateErrorHandler:[[YAConversationCreateErrorHandler alloc] initWithConversationHandler:[self conversationHandlerMock] managedObjectContextFactory:[self managedObjectContextFactoryMock] conversationObjectID:[self conversationObjectIDMock] messageHandler:[self messageHandlerMock]]];
}

- (void)testHandlesConversationCreateErrorsFromServerBySettingLocalConversationStatusToPendingWithErrors
{
    NSError *error = [NSError errorWithDomain:@"d" code:1 userInfo:nil];
    
    [[[[self managedObjectContextFactoryMock] expect] andReturn:[self managedObjectContextMock]] create];
    [[[[self managedObjectContextMock] expect] andReturn:[self conversationMock]] objectWithID:[self conversationObjectIDMock]];
    
    [[[self conversationHandlerMock] expect] setStatusAsPendingWithErrorsForConversation:[self conversationMock]];
    
    id lastMessageMock = [OCMockObject mockForClass:[YAMessage class]];
    NSSet *messages = [NSSet setWithArray:[NSArray arrayWithObject:lastMessageMock]];
    [[[[self conversationHandlerMock] stub] andReturn:messages] messagesForConversation:[self conversationMock]];
    [[[self conversationHandlerMock] expect] save:[self conversationMock] inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:nil]];
    
    [[[self messageHandlerMock] expect] setStatusAsPendingWithErrorsForMessage:lastMessageMock];
    
    [[self conversationCreateErrorHandler] handleError:error];
    
    [[self conversationHandlerMock] verify];
    [[self managedObjectContextFactoryMock] verify];
    [[self managedObjectContextMock] verify];
    [[self conversationObjectIDMock] verify];
    [[self conversationMock] verify];
}

@end
