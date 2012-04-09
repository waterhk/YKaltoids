//
//  YAURLRequestJSONPayloadHeadersBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/10/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAURLRequestJSONPayloadHeadersBuilderTests.h"
#import "URLRequestStandardHeadersBuilder.h"
#import "YAURLRequestJSONPayloadHeadersBuilder.h"

@interface YAURLRequestJSONPayloadHeadersBuilderTests()

@property (strong, nonatomic) id urlRequestMock;
@property (strong, nonatomic) id httpBodyMock;
@property (strong, nonatomic) id urlRequestStandardHeadersBuilderMock;
@property (strong, nonatomic) YAURLRequestJSONPayloadHeadersBuilder *urlRequestJSONPayloadHeadersBuilder;

@end

@implementation YAURLRequestJSONPayloadHeadersBuilderTests

@synthesize urlRequestMock = urlRequestMock_;
@synthesize httpBodyMock = httpBodyMock_;
@synthesize urlRequestStandardHeadersBuilderMock = urlRequestStandardHeadersBuilderMock_;
@synthesize urlRequestJSONPayloadHeadersBuilder = urlRequestJSONPayloadHeadersBuilder_;

- (void)setUp
{
    [self setUrlRequestMock:[OCMockObject mockForClass:[NSMutableURLRequest class]]];
    [self setHttpBodyMock:[OCMockObject mockForClass:[NSData class]]];
    [self setUrlRequestStandardHeadersBuilderMock:[OCMockObject mockForProtocol:@protocol(URLRequestStandardHeadersBuilder)]];

    [self setUrlRequestJSONPayloadHeadersBuilder:[[YAURLRequestJSONPayloadHeadersBuilder alloc] init]];
    [[self urlRequestJSONPayloadHeadersBuilder] setUrlRequestStandardHeadersBuilder:[self urlRequestStandardHeadersBuilderMock]];
}

- (void)testAddsContentLengthAndContentTypeToStandardHeadersToIndicateJSONPayload
{
    NSUInteger httpBodyLength = 12345;
    NSString *contentLength = [NSString stringWithFormat:@"%d", httpBodyLength];
    
    [[[[self httpBodyMock] expect] andReturnValue:OCMOCK_VALUE(httpBodyLength)] length];
    [[[[self urlRequestMock] expect] andReturn:[self httpBodyMock]] HTTPBody];
    
    [[[[self urlRequestStandardHeadersBuilderMock] expect] andReturn:[self urlRequestMock]] buildRequestHeadersForURLRequest:[self urlRequestMock]];
    
    [[[self urlRequestMock] expect] setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [[[self urlRequestMock] expect] setValue:contentLength forHTTPHeaderField:@"Content-Length"];
    
    STAssertEqualObjects([self urlRequestMock], [[self urlRequestJSONPayloadHeadersBuilder] buildRequestHeadersForURLRequest:[self urlRequestMock]], @"Unexpected urlRequest");
    
    [[self httpBodyMock] verify];
    [[self urlRequestMock] verify];
    [[self urlRequestStandardHeadersBuilderMock] verify];
}

@end
