//
//  YAConversationHandlerTests.m
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <OCMock/OCMock.h>
#import "YAConversationHandlerTests.h"
#import "ConversationValidatorFactory.h"
#import "YAConversation.h"
#import "YAConversationHandler.h"

@interface YAConversationHandlerTests()

@property (strong, nonatomic) id conversationMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id conversationValidatorFactoryMock;
@property (strong, nonatomic) YAConversationHandler *conversationHandler;

@end

@implementation YAConversationHandlerTests

@synthesize conversationMock = conversationMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize conversationValidatorFactoryMock = conversationValidatorFactoryMock_;
@synthesize conversationHandler = conversationHandler_;

- (void)setUp
{
    [super setUp];
    
    [self setConversationMock:[OCMockObject mockForClass:[YAConversation class]]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setConversationValidatorFactoryMock:[OCMockObject mockForProtocol:@protocol(ConversationValidatorFactory)]];
    
    [self setConversationHandler:[[YAConversationHandler alloc] init]];
    [[self conversationHandler] setConversationValidatorFactory:[self conversationValidatorFactoryMock]];
}

- (void)testDeleteConversationDeletesConverstaionFromManagedObjectContext
{
    [[[self managedObjectContextMock] expect] deleteObject:[self conversationMock]];
    
    [[self conversationHandler] deleteConversation:[self conversationMock] inManagedObjectContext:[self managedObjectContextMock]];
    
    [[self managedObjectContextMock] verify];
}

@end
