//
//  YAURLRequestBodyBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAURLRequestBodyBuilderTests.h"
#import "YAURLRequestBodyBuilder.h"

@interface YAURLRequestBodyBuilderTests()

@property (strong, nonatomic) id mutableURLRequestMock;
@property (strong, nonatomic) id requestDataMock;
@property (strong, nonatomic) YAURLRequestBodyBuilder *urlRequestBodyBuilder;

@end

@implementation YAURLRequestBodyBuilderTests

@synthesize mutableURLRequestMock = mutableURLRequestMock_;
@synthesize requestDataMock = requestDataMock_;
@synthesize urlRequestBodyBuilder = urlRequestBodyBuilder_;

- (void)setUp
{
    [self setMutableURLRequestMock:[OCMockObject mockForClass:[NSMutableURLRequest class]]];
    [self setRequestDataMock:[OCMockObject mockForClass:[NSData class]]];
    [self setUrlRequestBodyBuilder:[[YAURLRequestBodyBuilder alloc] init]];
}

- (void)testIfGivenRequestDataIsNilBodyBuilderDoesNotSetHTTPBodyForGivenURLRequest
{
    STAssertEqualObjects([self mutableURLRequestMock], [[self urlRequestBodyBuilder] buildRequestBodyForURLRequest:[self mutableURLRequestMock] withRequestData:nil], @"Unexpected url request");
    
    [[self mutableURLRequestMock] verify];
    [[self requestDataMock] verify];
}

- (void)testIfGivenRequestDataIsNotNilBodyBuilderDoesSetHTTPBodyForGivenURLRequest
{
    [[[self mutableURLRequestMock] expect] setHTTPBody:[self requestDataMock]];
    
    STAssertEqualObjects([self mutableURLRequestMock], [[self urlRequestBodyBuilder] buildRequestBodyForURLRequest:[self mutableURLRequestMock] withRequestData:[self requestDataMock]], @"Unexpected url request");
    
    [[self mutableURLRequestMock] verify];
    [[self requestDataMock] verify];
}

@end
