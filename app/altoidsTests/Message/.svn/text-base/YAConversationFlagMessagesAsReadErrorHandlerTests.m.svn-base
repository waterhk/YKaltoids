//
//  YAConversationFlagMessagesAsReadErrorHandlerTests.m
//  altoids
//
//  Created by Anand Biligiri on 12/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "ManagedObjectContextFactory.h"
#import "MessageHandler.h"
#import "MessageLocator.h"
#import "YAConversationFlagMessagesAsReadErrorHandlerTests.h"
#import "YAConversationFlagMessagesAsReadErrorHandler.h"
#import "YAMessage.h"

@interface YAConversationFlagMessagesAsReadErrorHandler (NeededForTesting)
- (void)markMessagesAsUnread:(NSArray *)mids;
@end

@interface YAConversationFlagMessagesAsReadErrorHandlerTests()
@property (strong, nonatomic) id managedObjectContextFactoryMock;
@property (strong, nonatomic) id messageLocatorMock;
@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) id managedObjectContextMock;

- (void)verifyMocks;
@end

@implementation YAConversationFlagMessagesAsReadErrorHandlerTests
@synthesize managedObjectContextFactoryMock = managedObjectContextFactoryMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize messageLocatorMock = messageLocatorMock_;
@synthesize messageHandlerMock = messageHandlerMock_;

- (void)setUp
{
    managedObjectContextFactoryMock_ = [OCMockObject mockForProtocol:@protocol(ManagedObjectContextFactory)];
    messageHandlerMock_ = [OCMockObject mockForProtocol:@protocol(MessageHandler)];
    messageLocatorMock_ = [OCMockObject mockForProtocol:@protocol(MessageLocator)];
    managedObjectContextMock_ = [OCMockObject mockForClass:[NSManagedObjectContext class]];
}

- (void)testDoesCallMarkMessagesAsUnreadWhenTopErrorHasMessageIDs
{
    NSArray *arrayOfMessageIds = [NSArray arrayWithObjects:@"1", @"2", nil];
    NSError *oneErrorWithMids = [NSError errorWithDomain:@"mgr" code:4 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:arrayOfMessageIds, @"mids", nil], kMMCErrorDetailKey, nil]];
    
    id messageOneMock = [OCMockObject mockForClass:[YAMessage class]];
    id messageTwoMock = [OCMockObject mockForClass:[YAMessage class]];
    
    NSArray *messageMocks = [NSArray arrayWithObjects:messageOneMock, messageTwoMock, nil];
    [[[[self managedObjectContextFactoryMock] expect] andReturn:[self managedObjectContextMock]] create];
    [[[[self messageLocatorMock] expect] andReturn:messageMocks] messagesMatchingIDs:arrayOfMessageIds inManagedObjectContext:[self managedObjectContextMock]];
    [[[self messageHandlerMock] expect] setRead:NO forMessage:messageOneMock];
    [[[self messageHandlerMock] expect] setRead:NO forMessage:messageTwoMock];
    [[[self managedObjectContextMock] stub] save:[OCMArg setTo:nil]];

    YAConversationFlagMessagesAsReadErrorHandler *errorHandler = [[YAConversationFlagMessagesAsReadErrorHandler alloc] initWithManagedObjectContextFactory:[self managedObjectContextFactoryMock]
                                                                                                                                            messageLocator:[self messageLocatorMock]
                                                                                                                                            messageHandler:[self messageHandlerMock]
                                                                                                                                          messageIDs:nil];

    [errorHandler handleError:oneErrorWithMids];
    
    [self verifyMocks];
}

- (void)testDoesCallMarkMessagesAsUnreadWhenUnderlyingErrorHasMessageIDs
{
    NSArray *arrayOfMessageIds = [NSArray arrayWithObjects:@"1", @"2", nil];
    NSError *oneErrorWithMids = [NSError errorWithDomain:@"mgr" code:4 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:arrayOfMessageIds, @"mids", nil], kMMCErrorDetailKey, nil]];
    NSError *topError = [NSError errorWithDomain:@"mgr" code:105 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:oneErrorWithMids, NSUnderlyingErrorKey, nil]];
    
    id messageOneMock = [OCMockObject mockForClass:[YAMessage class]];
    id messageTwoMock = [OCMockObject mockForClass:[YAMessage class]];
    
    NSArray *messageMocks = [NSArray arrayWithObjects:messageOneMock, messageTwoMock, nil];
    [[[[self managedObjectContextFactoryMock] expect] andReturn:[self managedObjectContextMock]] create];
    [[[[self messageLocatorMock] expect] andReturn:messageMocks] messagesMatchingIDs:arrayOfMessageIds inManagedObjectContext:[self managedObjectContextMock]];
    [[[self messageHandlerMock] expect] setRead:NO forMessage:messageOneMock];
    [[[self messageHandlerMock] expect] setRead:NO forMessage:messageTwoMock];
    [[[self managedObjectContextMock] stub] save:[OCMArg setTo:nil]];

    YAConversationFlagMessagesAsReadErrorHandler *errorHandler = [[YAConversationFlagMessagesAsReadErrorHandler alloc] initWithManagedObjectContextFactory:[self managedObjectContextFactoryMock]
                                                                                                                                            messageLocator:[self messageLocatorMock]
                                                                                                                                            messageHandler:[self messageHandlerMock]
                                                                                                                                          messageIDs:nil];

    [errorHandler handleError:topError];
    
    [self verifyMocks];
}

- (void)testDoesCallMarkMessagesAsUnreadWhenErrorDoesNotHaveMessageIDs
{
    NSError *oneErrorWithoutMids = [NSError errorWithDomain:@"mgr" code:1005 userInfo:nil];
    
    id messageOneMock = [OCMockObject mockForClass:[YAMessage class]];
    id messageTwoMock = [OCMockObject mockForClass:[YAMessage class]];
    
    NSArray *messageIDs = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    NSArray *messageMocks = [NSArray arrayWithObjects:messageOneMock, messageTwoMock, nil];
    [[[[self managedObjectContextFactoryMock] expect] andReturn:[self managedObjectContextMock]] create];
    
    [[[[self messageLocatorMock] expect] andReturn:messageMocks] messagesMatchingIDs:messageIDs inManagedObjectContext:[self managedObjectContextMock]];
    
    [[[self messageHandlerMock] expect] setRead:NO forMessage:messageOneMock];
    [[[self messageHandlerMock] expect] setRead:NO forMessage:messageTwoMock];
    [[[self managedObjectContextMock] stub] save:[OCMArg setTo:nil]];
    
    YAConversationFlagMessagesAsReadErrorHandler *errorHandler = [[YAConversationFlagMessagesAsReadErrorHandler alloc] initWithManagedObjectContextFactory:[self managedObjectContextFactoryMock]
                                                                                                                                            messageLocator:[self messageLocatorMock]
                                                                                                                                            messageHandler:[self messageHandlerMock]
                                                                                                                                          messageIDs:messageIDs];
    
    [errorHandler handleError:oneErrorWithoutMids];
    
    [self verifyMocks];
}

- (void)verifyMocks
{
    [[self managedObjectContextFactoryMock] verify];
    [[self messageHandlerMock] verify];
    [[self messageLocatorMock] verify];
    [[self managedObjectContextMock] verify];
}
@end
