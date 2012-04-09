//
//  YAJSONParserTests.m
//  altoids
//
//  Created by Jon Herron on 9/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <SBJSON/SBJSON.h>
#import "YAJSONParserTests.h"
#import "YAJSONParser.h"

@interface YAJSONParserTests()

@property (strong, nonatomic) id sbJSONParserMock;
@property (strong, nonatomic) YAJSONParser *jsonParser;

@end

@implementation YAJSONParserTests

@synthesize sbJSONParserMock = sbJSONParserMock_;
@synthesize jsonParser = jsonParser_;

- (void)setUp
{
    [self setSbJSONParserMock:[OCMockObject mockForClass:[SBJsonParser class]]];
    [self setJsonParser:[[YAJSONParser alloc] init]];
    [[self jsonParser] setSBJSONParser:[self sbJSONParserMock]];
}

- (void)testDelegatesToSBJSONParserToParseGivenNSDataAndReturnsResultingNSDictionary
{
    NSData *data = [NSData data];
    NSDictionary *dictionary = [NSDictionary dictionary];
    
    [[[[self sbJSONParserMock] expect] andReturn:dictionary] objectWithData:data];
    
    STAssertEquals(dictionary, [[self jsonParser] parseJSONData:data], @"Unexpected dictionary returned");
}

- (void)testDelegatesToSBJSONParserTOParseGivenStringAndReturnsResultingNSDictionary
{
    NSString *string = [NSString string];
    NSDictionary *dictionary = [NSDictionary dictionary];
    
    [[[[self sbJSONParserMock] expect] andReturn:dictionary] objectWithString:string];
    
    STAssertEquals(dictionary, [[self jsonParser] parseJSONString:string], @"Unexpected dictionary returned");
}

@end
