//
//  YAConversationCreateURLWithURLParametersBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/10/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationCreateURLWithURLParametersBuilderTests.h"
#import "MMCURLCreator.h"
#import "MMCRelativeURICreator.h"
#import "YAConversationCreateURLWithURLParametersBuilder.h"

@interface YAConversationCreateURLWithURLParametersBuilderTests()

@property (strong, nonatomic) id urlMock;
@property (strong, nonatomic) id requestParametersMock;
@property (strong, nonatomic) id mmcURLCreatorMock;
@property (strong, nonatomic) id mmcRelativeURICreatorMock;
@property (strong, nonatomic) YAConversationCreateURLWithURLParametersBuilder *conversationCreateURLWithURLParametersBuilder;

@end

@implementation YAConversationCreateURLWithURLParametersBuilderTests

@synthesize urlMock = urlMock_;
@synthesize requestParametersMock = requestParametersMock_;
@synthesize mmcURLCreatorMock = mmcURLCreatorMock_;
@synthesize mmcRelativeURICreatorMock = mmcRelativeURICreatorMock_;
@synthesize conversationCreateURLWithURLParametersBuilder = conversationCreateURLWithURLParametersBuilder_;

- (void)setUp
{
    [self setUrlMock:[OCMockObject mockForClass:[NSURL class]]];
    [self setRequestParametersMock:[OCMockObject mockForClass:[NSDictionary class]]];
    [self setMmcURLCreatorMock:[OCMockObject mockForProtocol:@protocol(MMCURLCreator)]];
    [self setMmcRelativeURICreatorMock:[OCMockObject mockForProtocol:@protocol(MMCRelativeURICreator)]];

    [self setConversationCreateURLWithURLParametersBuilder:[[YAConversationCreateURLWithURLParametersBuilder alloc] init]];
    [[self conversationCreateURLWithURLParametersBuilder] setMmcURLCreator:[self mmcURLCreatorMock]];
    [[self conversationCreateURLWithURLParametersBuilder] setMmcRelativeURICreator:[self mmcRelativeURICreatorMock]];
}

- (void)tesUsesMMCURLCreatorToCreateURLRequsetWithMMCConversationURLAndGivenParameters
{
    NSString *relativeURI = @"uri";
    
    [[[[self urlMock] expect] andReturn:[self urlMock]] absoluteURL];
    [[[[self mmcRelativeURICreatorMock] expect] andReturn:relativeURI] createRelativeURIToCreateConversation];
    
    [[[[self mmcURLCreatorMock] expect] andReturn:[self urlMock]] createMMCURLWithRelativeURI:relativeURI params:[self requestParametersMock]];
    
    STAssertEqualObjects([self urlMock], [[[self conversationCreateURLWithURLParametersBuilder] buildRequestURLWithURLParameters:[self requestParametersMock]] URL], @"Unexpected url");
}

@end
