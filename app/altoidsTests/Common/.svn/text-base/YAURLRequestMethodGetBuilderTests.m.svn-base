//
//  YAURLRequestMethodGetBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAURLRequestMethodGetBuilderTests.h"
#import "YAURLRequestMethodGetBuilder.h"

@interface YAURLRequestMethodGetBuilderTests()

@property (strong, nonatomic) id mutableURLRequestMock;
@property (strong, nonatomic) YAURLRequestMethodGetBuilder *urlRequestMethodGetBuilder;

@end

@implementation YAURLRequestMethodGetBuilderTests

@synthesize mutableURLRequestMock = mutableURLRequestMock_;
@synthesize urlRequestMethodGetBuilder = urlRequestMethodGetBuilder_;

- (void)setUp
{
    [self setMutableURLRequestMock:[OCMockObject mockForClass:[NSMutableURLRequest class]]];
    [self setUrlRequestMethodGetBuilder:[[YAURLRequestMethodGetBuilder alloc] init]];
}

- (void)testSetsHttpMethodToGetForGivenURLRequest
{
    [[[self mutableURLRequestMock] expect] setHTTPMethod:@"GET"];
    
    STAssertEqualObjects([self mutableURLRequestMock], [[self urlRequestMethodGetBuilder] buildRequestMethodForURLRequest:[self mutableURLRequestMock]], @"Unexpected url request returned");
    
    [[self mutableURLRequestMock] verify];
}

@end
