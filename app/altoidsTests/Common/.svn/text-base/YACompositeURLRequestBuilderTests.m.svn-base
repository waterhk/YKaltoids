//
//  YACompositeURLRequestBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YACompositeURLRequestBuilderTests.h"
#import "URLRequestURLWithURLParametersBuilder.h"
#import "URLRequestMethodBuilder.h"
#import "URLRequestHeadersBuilder.h"
#import "URLRequestBodyBuilder.h"
#import "YACompositeURLRequestBuilder.h"

@interface YACompositeURLRequestBuilderTests()

@property (strong, nonatomic) id mutableURLRequestMock;
@property (strong, nonatomic) id requestParametersMock;
@property (strong, nonatomic) id requestDataMock;
@property (strong, nonatomic) id urlWithURLRequestParametersBuilderMock;
@property (strong, nonatomic) id urlRequestMethodBuilderMock;
@property (strong, nonatomic) id urlRequestHeadersBuilderMock;
@property (strong, nonatomic) id urlRequestBodyBuilderMock;
@property (strong, nonatomic) YACompositeURLRequestBuilder *compositeURLRequestBuilder;

- (void)verifyMocks;

@end

@implementation YACompositeURLRequestBuilderTests

@synthesize mutableURLRequestMock = mutableURLRequestMock_;
@synthesize requestParametersMock = requestParametersMock_;
@synthesize requestDataMock = requestDataMock_;
@synthesize urlWithURLRequestParametersBuilderMock = urlWithURLRequestParametersBuilderMock_;
@synthesize urlRequestMethodBuilderMock = urlRequestMethodBuilderMock_;
@synthesize urlRequestHeadersBuilderMock = urlRequestHeadersBuilderMock_;
@synthesize urlRequestBodyBuilderMock = urlRequestBodyBuilderMock_;
@synthesize compositeURLRequestBuilder = compositeURLRequestBuilder_;

- (void)setUp
{
    [self setMutableURLRequestMock:[OCMockObject mockForClass:[NSMutableURLRequest class]]];
    [self setRequestParametersMock:[OCMockObject mockForClass:[NSDictionary class]]];
    [self setRequestDataMock:[OCMockObject mockForClass:[NSData class]]];
    
    [self setUrlWithURLRequestParametersBuilderMock:[OCMockObject mockForProtocol:@protocol(URLRequestURLWithURLParametersBuilder)]];
    [self setUrlRequestMethodBuilderMock:[OCMockObject mockForProtocol:@protocol(URLRequestMethodBuilder)]];
    [self setUrlRequestHeadersBuilderMock:[OCMockObject mockForProtocol:@protocol(URLRequestHeadersBuilder)]];
    [self setUrlRequestBodyBuilderMock:[OCMockObject mockForProtocol:@protocol(URLRequestBodyBuilder)]];
    
    [self setCompositeURLRequestBuilder:[[YACompositeURLRequestBuilder alloc] initWithURLWithURLParametersBuilder:[self urlWithURLRequestParametersBuilderMock] urlRequestMethodBuilder:[self urlRequestMethodBuilderMock] urlRequestHeadersBuilder:[self urlRequestHeadersBuilderMock] urlRequestBodyBuilder:[self urlRequestBodyBuilderMock]]];
}

- (void)testDelegatesToURLWithURLParametersRequestBuilder
{
    [[[[self urlWithURLRequestParametersBuilderMock] expect] andReturn:[self mutableURLRequestMock]] buildRequestURLWithURLParameters:[self requestParametersMock]];
    
    STAssertEqualObjects([self mutableURLRequestMock], [[self compositeURLRequestBuilder] buildRequestURLWithURLParameters:[self requestParametersMock]], @"Unexpected url request");
    
    [self verifyMocks];
}

- (void)testDelegatesToRequestMethodRequestBuilder
{
    [[[[self urlRequestMethodBuilderMock] expect] andReturn:[self mutableURLRequestMock]] buildRequestMethodForURLRequest:[self mutableURLRequestMock]];
    
    STAssertEqualObjects([self mutableURLRequestMock], [[self compositeURLRequestBuilder] buildRequestMethodForURLRequest:[self mutableURLRequestMock]], @"Unexpected url request");
    
    [self verifyMocks];
}

- (void)testDelegatesToRequestHeadersRequestBuilder
{
    [[[[self urlRequestHeadersBuilderMock] expect] andReturn:[self mutableURLRequestMock]] buildRequestHeadersForURLRequest:[self mutableURLRequestMock]];
    
    STAssertEqualObjects([self mutableURLRequestMock], [[self compositeURLRequestBuilder] buildRequestHeadersForURLRequest:[self mutableURLRequestMock]], @"Unexpected url request");
    
    [self verifyMocks];
}

- (void)testDelegatesToRequestBodyRequestBuilder
{
    [[[[self urlRequestBodyBuilderMock] expect] andReturn:[self mutableURLRequestMock]] buildRequestBodyForURLRequest:[self mutableURLRequestMock] withRequestData:[self requestDataMock]];
    
    STAssertEqualObjects([self mutableURLRequestMock], [[self compositeURLRequestBuilder] buildRequestBodyForURLRequest:[self mutableURLRequestMock] withRequestData:[self requestDataMock]], @"Unexpected url request");
    
    [self verifyMocks];
}

- (void)verifyMocks
{
    [[self mutableURLRequestMock] verify];
    [[self requestParametersMock] verify];
    [[self requestDataMock] verify];
    [[self urlWithURLRequestParametersBuilderMock] verify];
    [[self urlRequestMethodBuilderMock] verify];
    [[self urlRequestHeadersBuilderMock] verify];
    [[self urlRequestBodyBuilderMock] verify];
}

@end
