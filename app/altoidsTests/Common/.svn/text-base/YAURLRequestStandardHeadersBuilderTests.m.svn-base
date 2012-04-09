//
//  YARequestHeadersBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAURLRequestStandardHeadersBuilderTests.h"
#import "YAURLRequestStandardHeadersBuilder.h"
#import "AuthInfoProvider.h"

@interface YAURLRequestStandardHeadersBuilderTests()

@property (strong, nonatomic) id authInfoProviderMock;
@property (strong, nonatomic) id urlMock;
@property (strong, nonatomic) id urlRequestMock;
@property (strong, nonatomic) YAURLRequestStandardHeadersBuilder *urlRequestHeadersBuilder;

@end

@implementation YAURLRequestStandardHeadersBuilderTests

@synthesize authInfoProviderMock = authInfoProviderMock_;
@synthesize urlMock = urlMock_;
@synthesize urlRequestMock = urlRequestMock_;
@synthesize urlRequestHeadersBuilder = urlRequestHeadersBuilder_;

- (void)setUp
{
    [self setAuthInfoProviderMock:[OCMockObject mockForProtocol:@protocol(AuthInfoProvider)]];
    [self setUrlMock:[OCMockObject mockForClass:[NSURL class]]];
    [self setUrlRequestMock:[OCMockObject mockForClass:[NSMutableURLRequest class]]];

    [self setUrlRequestHeadersBuilder:[[YAURLRequestStandardHeadersBuilder alloc] init]];
    [[self urlRequestHeadersBuilder] setAuthInfoProvider:[self authInfoProviderMock]];
}

- (void)testSetsHostAcceptAndCookieHeadersForGivenURLRequest
{
    NSString *host = @"host";
    NSString *yCookie = @"ycookie";
    NSString *tCookie = @"tcookie";
    NSString *cookie = [NSString stringWithFormat:@"Y=%@; T=%@", yCookie, tCookie];
    
    [[[[self authInfoProviderMock] expect] andReturn:yCookie] yCookie];
    [[[[self authInfoProviderMock] expect] andReturn:tCookie] tCookie];
    
    [[[[self urlMock] expect] andReturn:host] host];
    [[[[self urlRequestMock] expect] andReturn:[self urlMock]] URL];
    
    [[[self urlRequestMock] expect] setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [[[self urlRequestMock] expect] setValue:cookie forHTTPHeaderField:@"Cookie"];
    [[[self urlRequestMock] expect] setValue:host forHTTPHeaderField:@"Host"];
    
    STAssertEqualObjects([self urlRequestMock], [[self urlRequestHeadersBuilder] buildRequestHeadersForURLRequest:[self urlRequestMock]], @"Unexpected url request");
    
    [[self urlMock] verify];
    [[self urlRequestMock] verify];
    [[self authInfoProviderMock] verify];
}

@end
