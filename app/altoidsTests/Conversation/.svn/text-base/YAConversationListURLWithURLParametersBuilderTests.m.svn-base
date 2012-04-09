//
//  YAConversationListURLWithURLParametersBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationListURLWithURLParametersBuilderTests.h"
#import "MMCURLCreator.h"
#import "MMCRelativeURICreator.h"
#import "YAConversationListURLWithURLParametersBuilder.h"

@interface YAConversationListURLWithURLParametersBuilderTests()

@property (strong, nonatomic) id urlMock;
@property (strong, nonatomic) id urlRequestParametersMock;
@property (strong, nonatomic) id mmcURLCreatorMock;
@property (strong, nonatomic) id mmcRelativeURICreatorMock;
@property (strong, nonatomic) YAConversationListURLWithURLParametersBuilder *conversationListURLWithURLParametersBuilder;

@end

@implementation YAConversationListURLWithURLParametersBuilderTests

@synthesize urlMock = urlMock_;
@synthesize urlRequestParametersMock = urlRequestParametersMock_;
@synthesize mmcURLCreatorMock = mmcURLCreatorMock_;
@synthesize mmcRelativeURICreatorMock = mmcRelativeURICreatorMock_;
@synthesize conversationListURLWithURLParametersBuilder = conversationListURLWithURLParametersBuilder_;

- (void)setUp
{
    [self setUrlMock:[OCMockObject mockForClass:[NSURL class]]];
    [self setUrlRequestParametersMock:[OCMockObject mockForClass:[NSDictionary class]]];
    [self setMmcURLCreatorMock:[OCMockObject mockForProtocol:@protocol(MMCURLCreator)]];
    [self setMmcRelativeURICreatorMock:[OCMockObject mockForProtocol:@protocol(MMCRelativeURICreator)]];

    [self setConversationListURLWithURLParametersBuilder:[[YAConversationListURLWithURLParametersBuilder alloc] init]];
    [[self conversationListURLWithURLParametersBuilder] setMmcURLCreator:[self mmcURLCreatorMock]];
    [[self conversationListURLWithURLParametersBuilder] setMmcRelativeURICreator:[self mmcRelativeURICreatorMock]];
}

- (void)testBuildsMutableURLRequestWithMMCConversationsURLAndGivenURLParameters
{
    NSString *relativeURI = @"uri";
    
    [[[[self urlMock] stub] andReturn:[self urlMock]] absoluteURL];
    [[[[self mmcRelativeURICreatorMock] expect] andReturn:relativeURI] createRelativeURIToRetrieveConversations];
    
    [[[[self mmcURLCreatorMock] expect] andReturn:[self urlMock]] createMMCURLWithRelativeURI:relativeURI params:[self urlRequestParametersMock]];
 
    STAssertEqualObjects([self urlMock], [[[self conversationListURLWithURLParametersBuilder] buildRequestURLWithURLParameters:[self urlRequestParametersMock]] URL], @"Unexpected url");
    
    [[self mmcURLCreatorMock] verify];
    [[self urlMock] verify];
    [[self urlRequestParametersMock] verify];
}

@end
