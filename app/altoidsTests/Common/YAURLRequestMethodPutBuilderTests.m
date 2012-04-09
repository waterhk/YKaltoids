//
//  YAURLRequestMethodPutBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAURLRequestMethodPutBuilderTests.h"
#import "YAURLRequestMethodPutBuilder.h"

@interface YAURLRequestMethodPutBuilderTests()

@property (strong, nonatomic) id mutableURLRequestMock;
@property (strong, nonatomic) YAURLRequestMethodPutBuilder *urlRequestMethodPutBuilder;

@end

@implementation YAURLRequestMethodPutBuilderTests

@synthesize mutableURLRequestMock = mutableURLRequestMock_;
@synthesize urlRequestMethodPutBuilder = urlRequestMethodPutBuilder_;

- (void)setUp
{
    [self setMutableURLRequestMock:[OCMockObject mockForClass:[NSMutableURLRequest class]]];
    [self setUrlRequestMethodPutBuilder:[[YAURLRequestMethodPutBuilder alloc] init]];
}

- (void)testSetsHttpMethodToPutForGivenURLRequest
{
    [[[self mutableURLRequestMock] expect] setHTTPMethod:@"PUT"];
    
    STAssertEqualObjects([self mutableURLRequestMock], [[self urlRequestMethodPutBuilder] buildRequestMethodForURLRequest:[self mutableURLRequestMock]], @"Unexpected url request returned");
    
    [[self mutableURLRequestMock] verify];
}

@end
