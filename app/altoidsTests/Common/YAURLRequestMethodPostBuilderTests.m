//
//  YAURLRequestMethodPostBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAURLRequestMethodPostBuilderTests.h"
#import "YAURLRequestMethodPostBuilder.h"

@interface YAURLRequestMethodPostBuilderTests()

@property (strong, nonatomic) id mutableURLRequestMock;
@property (strong, nonatomic) YAURLRequestMethodPostBuilder *urlRequestMethodPostBuilder;

@end

@implementation YAURLRequestMethodPostBuilderTests

@synthesize mutableURLRequestMock = mutalbeURLRequestMock_;
@synthesize urlRequestMethodPostBuilder = urlRequestMethodPostBuilder_;

- (void)setUp
{
    [self setMutableURLRequestMock:[OCMockObject mockForClass:[NSMutableURLRequest class]]];
    [self setUrlRequestMethodPostBuilder:[[YAURLRequestMethodPostBuilder alloc] init]];
}

- (void)testSetsHttpMethodToPostForGivenURLRequest
{
    [[[self mutableURLRequestMock] expect] setHTTPMethod:@"POST"];
    
    STAssertEqualObjects([self mutableURLRequestMock], [[self urlRequestMethodPostBuilder] buildRequestMethodForURLRequest:[self mutableURLRequestMock]], @"Unexpected url request returned");
    
    [[self mutableURLRequestMock] verify];
}

@end
