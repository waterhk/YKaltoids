//
//  YAConversationManagementURLWithURLParametersBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationManagementURLWithURLParametersBuilderTests.h"
#import "MMCURLCreator.h"
#import "MMCRelativeURICreator.h"
#import "YAConversationManagementURLWithURLParametersBuilder.h"
#import "YAConversation.h"
#import "ManagedObjectContextFactory.h"

@interface YAConversationManagementURLWithURLParametersBuilderTests()

@property (strong, nonatomic) id mmcURLCreatorMock;
@property (strong, nonatomic) id mmcRelativeURICreatorMock;
@property (strong, nonatomic) id conversationMock;
@property (strong, nonatomic) id urlParametersMock;
@property (strong, nonatomic) YAConversationManagementURLWithURLParametersBuilder *conversationManagementURLWithURLParametersBuilder;
@property (strong, nonatomic) id managedObjectContextfactoryMock;

@end

@implementation YAConversationManagementURLWithURLParametersBuilderTests

@synthesize mmcURLCreatorMock = mmcURLCreatorMock_;
@synthesize mmcRelativeURICreatorMock = mmcRelativeURICreatorMock_;
@synthesize conversationMock = conversationMock_;
@synthesize urlParametersMock = urlParametersMock_;
@synthesize conversationManagementURLWithURLParametersBuilder = conversationManagementURLWithURLParametersBuilder_;
@synthesize managedObjectContextfactoryMock = managedObjectContextfactoryMock_;

- (void)setUp
{
    [self setMmcURLCreatorMock:[OCMockObject mockForProtocol:@protocol(MMCURLCreator)]];
    [self setMmcRelativeURICreatorMock:[OCMockObject mockForProtocol:@protocol(MMCRelativeURICreator)]];
    [self setConversationMock:[OCMockObject mockForClass:[YAConversation class]]];
    [self setUrlParametersMock:[OCMockObject mockForClass:[NSDictionary class]]];
    [self setManagedObjectContextfactoryMock:[OCMockObject mockForProtocol:@protocol(ManagedObjectContextFactory)]];
    
    OCMockObject *managedObjectIDMock = [OCMockObject mockForClass:[NSManagedObjectID class]];    
    [[[[self conversationMock] expect] andReturn:managedObjectIDMock] objectID];

    [self setConversationManagementURLWithURLParametersBuilder:[[YAConversationManagementURLWithURLParametersBuilder alloc] initWithMMCURLCreator:[self mmcURLCreatorMock] mmcRelativeURICreator:[self mmcRelativeURICreatorMock] conversation:[self conversationMock] managedObjectContextFactory:[self managedObjectContextfactoryMock]]];
}

- (void)testCanBuildMutableURLRequestForManagingAGivenConversation
{
    NSString *relativeURI = @"/some/path";
    NSURL *url = [NSURL URLWithString:@"http://www.yahoo.com"];
    
    [[[[self mmcURLCreatorMock] expect] andReturn:url] createMMCURLWithRelativeURI:relativeURI params:[self urlParametersMock]];
    [[[[self mmcRelativeURICreatorMock] expect] andReturn:relativeURI] createRelativeURIToManageConversation:[self conversationMock]];
    
    OCMockObject *managedObjectContextMock = [OCMockObject mockForClass:[NSManagedObjectContext class]];
    [[[[self managedObjectContextfactoryMock] expect] andReturn:managedObjectContextMock] create];
    
    [[[managedObjectContextMock expect] andReturn:[self conversationMock]] objectWithID:OCMOCK_ANY];

    STAssertTrue([[[[[self conversationManagementURLWithURLParametersBuilder] buildRequestURLWithURLParameters:[self urlParametersMock]] URL] host] isEqualToString:@"www.yahoo.com"], @"Unexpected url");
    
    [[self mmcRelativeURICreatorMock] verify];
    [[self mmcURLCreatorMock] verify];
    [[self conversationMock] verify];
    [[self urlParametersMock] verify];
    [[self managedObjectContextfactoryMock] verify];
    [managedObjectContextMock verify];
}

@end
