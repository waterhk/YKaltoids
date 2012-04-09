//
//  YAJSONParserForMutableResultTests.m
//  altoids
//
//  Created by Jon Herron on 10/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <SBJSON/SBJSON.h>
#import "YAJSONParserForMutableResultTests.h"
#import "YAJSONParserForMutableResult.h"

@interface YAJSONParserForMutableResultTests()

@property (strong, nonatomic) id sbJSONParserMock;
@property (strong, nonatomic) YAJSONParserForMutableResult *jsonParser;

@end

@implementation YAJSONParserForMutableResultTests

@synthesize sbJSONParserMock = sbJSONParserMock_;
@synthesize jsonParser = jsonParser_;

- (void)setUp
{
    [self setSbJSONParserMock:[OCMockObject mockForClass:[SBJsonParser class]]];
    [self setJsonParser:[[YAJSONParserForMutableResult alloc] init]];
    [[self jsonParser] setSBJSONParser:[self sbJSONParserMock]];
}

- (void)testDelegatesToSBJSONParserToParseGivenNSDataAndReturnsResultingNSMutableDictionary
{
    NSData *data = [NSData data];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    [[[[self sbJSONParserMock] expect] andReturn:dictionary] objectWithData:data];
    
    STAssertEquals(dictionary, [[self jsonParser] parseJSONDataForMutableResult:data], @"Unexpected mutable dictionary returned");
}

- (void)testDelegatesToSBJSONParserTOParseGivenStringAndReturnsResultingNSMutableDictionary
{
    NSString *string = [NSString string];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    [[[[self sbJSONParserMock] expect] andReturn:dictionary] objectWithString:string];
    
    STAssertEquals(dictionary, [[self jsonParser] parseJSONStringForMutableResult:string], @"Unexpected mutable dictionary returned");
}

@end
