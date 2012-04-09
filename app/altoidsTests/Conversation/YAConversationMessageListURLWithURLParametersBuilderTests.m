//
//  YAConversationMessageListURLWithURLParametersBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationMessageListURLWithURLParametersBuilderTests.h"
#import "MMCURLCreator.h"
#import "MMCRelativeURICreator.h"
#import "YAConversation.h"
#import "YAConversationMessageListURLWithURLParametersBuilder.h"
#import "ManagedObjectContextFactory.h"

@interface YAConversationMessageListURLWithURLParametersBuilderTests()

@property (strong, nonatomic) id urlMock;
@property (strong, nonatomic) id urlParametersMock;
@property (strong, nonatomic) id mmcURLCreatorMock;
@property (strong, nonatomic) id mmcRelativeURICreatorMock;
@property (strong, nonatomic) id conversationMock;
@property (strong, nonatomic) YAConversationMessageListURLWithURLParametersBuilder *conversationMessageListURLWithURLParametersBuilder;
@property (strong, nonatomic) id managedObjectContextfactoryMock;

@end

@implementation YAConversationMessageListURLWithURLParametersBuilderTests

@synthesize urlMock = urlMock_;
@synthesize urlParametersMock = urlParametersMock_;
@synthesize mmcURLCreatorMock = mmcURLCreatorMock_;
@synthesize mmcRelativeURICreatorMock = mmcRelativeURICreatorMock_;
@synthesize conversationMock = conversationMock_;
@synthesize conversationMessageListURLWithURLParametersBuilder = conversationMessageListURLWithURLParametersBuilder_;
@synthesize managedObjectContextfactoryMock = managedObjectContextfactoryMock_;

- (void)setUp
{
    [self setUrlMock:[OCMockObject mockForClass:[NSURL class]]];
    [self setUrlParametersMock:[OCMockObject mockForClass:[NSDictionary class]]];
    
    [self setMmcURLCreatorMock:[OCMockObject mockForProtocol:@protocol(MMCURLCreator)]];
    [self setMmcRelativeURICreatorMock:[OCMockObject mockForProtocol:@protocol(MMCRelativeURICreator)]];
    [self setConversationMock:[OCMockObject mockForClass:[YAConversation class]]];
    [self setManagedObjectContextfactoryMock:[OCMockObject mockForProtocol:@protocol(ManagedObjectContextFactory)]];
    
    OCMockObject *managedObjectIDMock = [OCMockObject mockForClass:[NSManagedObjectID class]];    
    [[[[self conversationMock] expect] andReturn:managedObjectIDMock] objectID];

    [self setConversationMessageListURLWithURLParametersBuilder:[[YAConversationMessageListURLWithURLParametersBuilder alloc] initWithMMCURLCreator:[self mmcURLCreatorMock] mmcRelativeURICreator:[self mmcRelativeURICreatorMock] conversation:[self conversationMock] managedObjectContextFactory:[self managedObjectContextfactoryMock]]];
}

- (void)testCanConstructURLWithURLParametersToRetrieveMessagesForAConversation
{
    NSString *relativeURI = @"uri";
    
    [[[[self mmcRelativeURICreatorMock] expect] andReturn:relativeURI] createRelativeURIToRetrieveMessagesInConversation:[self conversationMock]];
    [[[[self urlMock] expect] andReturn:[self urlMock]] absoluteURL];
    [[[[self mmcURLCreatorMock] expect] andReturn:[self urlMock]] createMMCURLWithRelativeURI:relativeURI params:[self urlParametersMock]];    
    
    OCMockObject *managedObjectContextMock = [OCMockObject mockForClass:[NSManagedObjectContext class]];
    [[[[self managedObjectContextfactoryMock] expect] andReturn:managedObjectContextMock] create];
    
    [[[managedObjectContextMock expect] andReturn:[self conversationMock]] objectWithID:OCMOCK_ANY];

    STAssertEqualObjects([self urlMock], [[[self conversationMessageListURLWithURLParametersBuilder] buildRequestURLWithURLParameters:[self urlParametersMock]] URL], @"Unexpected url");
    
    [[self mmcURLCreatorMock] verify];
    [[self mmcRelativeURICreatorMock] verify];
    [[self urlParametersMock] verify];
    [[self urlMock] verify];
    [[self conversationMock] verify];
    [[self managedObjectContextfactoryMock] verify];
    [managedObjectContextMock verify];
}

@end
