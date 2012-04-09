//
//  YAURLRequestCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAURLRequestCreatorTests.h"
#import "YAURLRequestCreator.h"
#import "URLRequestBuilder.h"

@interface YAURLRequestCreatorTests()

@property (strong, nonatomic) id urlRequestBuilderMock;
@property (strong, nonatomic) YAURLRequestCreator *urlRequestCreator;

@end

@implementation YAURLRequestCreatorTests

@synthesize urlRequestCreator = urlRequestCreator_;
@synthesize urlRequestBuilderMock = urlRequestBuilderMock_;

- (void)setUp
{
    [self setUrlRequestBuilderMock:[OCMockObject mockForProtocol:@protocol(URLRequestBuilder)]];
    [self setUrlRequestCreator:[[YAURLRequestCreator alloc] init]];
}

- (void)testUsesGivenURLRequestBuilderToFormReturnedURLRequest
{
    id mutableURLRequestMock1 = [OCMockObject mockForClass:[NSMutableURLRequest class]];
    id mutableURLRequestMock2 = [OCMockObject mockForClass:[NSMutableURLRequest class]];
    id mutableURLRequestMock3 = [OCMockObject mockForClass:[NSMutableURLRequest class]];
    id mutableURLRequestMock4 = [OCMockObject mockForClass:[NSMutableURLRequest class]];
    NSDictionary *urlParameters = [NSDictionary dictionary];
    NSData *requestData = [NSData data];
    
    [[[[self urlRequestBuilderMock] expect] andReturn:mutableURLRequestMock1] buildRequestURLWithURLParameters:urlParameters];
    [[[[self urlRequestBuilderMock] expect] andReturn:mutableURLRequestMock2] buildRequestMethodForURLRequest:mutableURLRequestMock1];
    [[[[self urlRequestBuilderMock] expect] andReturn:mutableURLRequestMock3] buildRequestBodyForURLRequest:mutableURLRequestMock2 withRequestData:requestData];
    [[[[self urlRequestBuilderMock] expect] andReturn:mutableURLRequestMock4] buildRequestHeadersForURLRequest:mutableURLRequestMock3];
    
    STAssertEquals(mutableURLRequestMock4, [[self urlRequestCreator] urlRequestFromURLRequestBuilder:[self urlRequestBuilderMock] withURLParameters:urlParameters requestData:requestData], @"Unexpected url returned from url creator");
}

@end
