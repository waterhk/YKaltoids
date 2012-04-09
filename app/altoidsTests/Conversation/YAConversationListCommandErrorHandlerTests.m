//
//  YAConversationListCommandErrorHandler.m
//  altoids
//
//  Created by Jon Herron on 11/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationListCommandErrorHandlerTests.h"
#import "MMCErrorCreator.h"
#import "ConversationErrorCreator.h"
#import "MMCConversationErrorDetector.h"
#import "ConversationLocator.h"
#import "ConversationHandler.h"
#import "ManagedObjectContextFactory.h"
#import "YAConversationListCommandErrorHandler.h"
#import "YAConversation.h"

@interface YAConversationListCommandErrorHandlerTests()

@property (strong, nonatomic) id mmcConversationMock;
@property (strong, nonatomic) id mmcConversationErrorDetectorMock;
@property (strong, nonatomic) id mmcErrorCreatorMock;
@property (strong, nonatomic) id conversationErrorCreatorMock;
@property (strong, nonatomic) id conversationLocatorMock;
@property (strong, nonatomic) id conversationHandlerMock;
@property (strong, nonatomic) id managedObjectContextFactoryMock;
@property (strong, nonatomic) id conversationMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) YAConversationListCommandErrorHandler *conversationListCommandErrorHandler;

@end

@implementation YAConversationListCommandErrorHandlerTests

@synthesize mmcConversationMock = mmcConversationMock_;
@synthesize mmcConversationErrorDetectorMock = mmcConversationErrorDetectorMock_;
@synthesize mmcErrorCreatorMock = mmcErrorCreatorMock_;
@synthesize conversationErrorCreatorMock = conversationErrorCreatorMock_;
@synthesize conversationLocatorMock = conversationLocatorMock_;
@synthesize conversationHandlerMock = conversationHandlerMock_;
@synthesize managedObjectContextFactoryMock = managedObjectContextFactoryMock_;
@synthesize conversationMock = conversationMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize conversationListCommandErrorHandler = conversationListCommandErrorHandler_;

- (void)setUp
{
    [self setMmcConversationMock:[OCMockObject mockForClass:[YAMMCConversation class]]];
    [self setMmcConversationErrorDetectorMock:[OCMockObject mockForProtocol:@protocol(MMCConversationErrorDetector)]];
    [self setMmcErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(MMCErrorCreator)]];
    [self setConversationErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(ConversationErrorCreator)]];
    [self setConversationLocatorMock:[OCMockObject mockForProtocol:@protocol(ConversationLocator)]];
    [self setConversationHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationHandler)]];
    [self setManagedObjectContextFactoryMock:[OCMockObject mockForProtocol:@protocol(ManagedObjectContextFactory)]];
    [self setConversationMock:[OCMockObject mockForClass:[YAConversation class]]];

    [self setConversationListCommandErrorHandler:[[YAConversationListCommandErrorHandler alloc] init]];
    [[self conversationListCommandErrorHandler] setMmcConversationErrorDetector:[self mmcConversationErrorDetectorMock]];
    [[self conversationListCommandErrorHandler] setMmcErrorCreator:[self mmcErrorCreatorMock]];
    [[self conversationListCommandErrorHandler] setConversationErrorCreator:[self conversationErrorCreatorMock]];
    [[self conversationListCommandErrorHandler] setConversationLocator:[self conversationLocatorMock]];
    [[self conversationListCommandErrorHandler] setConversationHandler:[self conversationHandlerMock]];
    [[self conversationListCommandErrorHandler] setManagedObjectContextFactory:[self managedObjectContextFactoryMock]];
}

- (void)testIfConversationErrorDetectorIndicatesNoErrorsHasErrorReturnsNo
{
    BOOL hasError = NO;
    NSError *error;
    
    [[[[self mmcConversationErrorDetectorMock] expect] andReturnValue:OCMOCK_VALUE(hasError)] mmcConversationHasErrors:[self mmcConversationMock]];
    
    STAssertFalse([[self conversationListCommandErrorHandler] mmcConversationHasError:[self mmcConversationMock] error:&error], @"Unexpected error found");
    
    [[self mmcConversationErrorDetectorMock] verify];
    [[self mmcConversationMock] verify];
}

- (void)testIfConversationErrorDetectorIndicatesErrorHasErrorCreatesErrorAndReturnsYes
{
    BOOL hasError = YES;
    NSArray *mmcErrors = [NSArray array];
    NSError *error;
    NSError *underlyingError = [NSError errorWithDomain:@"underlying" code:2 userInfo:nil];
    NSError *conversationError = [NSError errorWithDomain:@"convo" code:1 userInfo:nil];
    
    [[[[self mmcConversationMock] expect] andReturn:mmcErrors] errors];
    
    [[[[self mmcConversationErrorDetectorMock] expect] andReturnValue:OCMOCK_VALUE(hasError)] mmcConversationHasErrors:[self mmcConversationMock]];
    
    [[[[self mmcErrorCreatorMock] expect] andReturn:underlyingError] errorFromMMCConversationErrors:mmcErrors];
    
    [[[[self conversationErrorCreatorMock] expect] andReturn:conversationError] errorWithCode:YAConversationErrorCodeFailedToRetrieveConversationFromServer underlyingError:underlyingError];
    
    STAssertTrue([[self conversationListCommandErrorHandler] mmcConversationHasError:[self mmcConversationMock] error:&error], @"Expected an error");
    
    STAssertEqualObjects(error, conversationError, @"Unexpected error set");
    
    [[self mmcConversationErrorDetectorMock] verify];
    [[self mmcConversationMock] verify];
    [[self mmcErrorCreatorMock] verify];
    [[self conversationErrorCreatorMock] verify];
}

- (void)testIfMMCConversationInErrorDoesNotHaveAnIDErrorHandlerWillAbort
{
    [[[[self mmcConversationMock] expect] andReturn:nil] conversationID];
    
    [[self conversationListCommandErrorHandler] handleError:nil forMMCConversation:[self mmcConversationMock]];
    
    [[self managedObjectContextFactoryMock] verify];
}

- (void)testIfMMCConversationHasAnIDWhichDoesNotExistANewEntityWillBeCreated
{
    NSString *conversationID = @"cid";
    
    [[[[self managedObjectContextFactoryMock] expect] andReturn:[self managedObjectContextMock]] create];
    [[[[self mmcConversationMock] expect] andReturn:conversationID] conversationID];
    [[[[self conversationLocatorMock] expect] andReturn:nil] conversationWithID:conversationID inManagedObjectContext:[self managedObjectContextMock]];
    [[[[self conversationHandlerMock] expect] andReturn:[self conversationMock]] createConversationEntityInManagedObjectContext:[self managedObjectContextMock]];
    
    [[[self conversationHandlerMock] expect] setStatusAsReceivedWithErrorsForConversation:[self conversationMock]];
    [[[self conversationHandlerMock] expect] save:[self conversationMock] inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:nil]];
    
    [[self conversationListCommandErrorHandler] handleError:nil forMMCConversation:[self mmcConversationMock]];
    
    [[self managedObjectContextFactoryMock] verify];
    [[self managedObjectContextMock] verify];
    [[self mmcConversationMock] verify];
    [[self conversationMock] verify];
    [[self conversationHandlerMock] verify];
    [[self conversationLocatorMock] verify];
}

- (void)testIfMMCConversationHasAnIDWhichDoesExistTheExistingConversationWillBeUsed
{
    NSString *conversationID = @"cid";
    
    [[[[self managedObjectContextFactoryMock] expect] andReturn:[self managedObjectContextMock]] create];
    [[[[self mmcConversationMock] expect] andReturn:conversationID] conversationID];
    [[[[self conversationLocatorMock] expect] andReturn:[self conversationMock]] conversationWithID:conversationID inManagedObjectContext:[self managedObjectContextMock]];
    
    [[[self conversationHandlerMock] expect] setStatusAsReceivedWithErrorsForConversation:[self conversationMock]];
    [[[self conversationHandlerMock] expect] save:[self conversationMock] inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:nil]];
    
    [[self conversationListCommandErrorHandler] handleError:nil forMMCConversation:[self mmcConversationMock]];
    
    [[self managedObjectContextFactoryMock] verify];
    [[self managedObjectContextMock] verify];
    [[self mmcConversationMock] verify];
    [[self conversationMock] verify];
    [[self conversationHandlerMock] verify];
    [[self conversationLocatorMock] verify];
}

@end
