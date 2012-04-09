//
//  YAJSONWriterTests.m
//  altoids
//
//  Created by Jon Herron on 10/4/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <SBJson/SBJson.h>
#import "YAJSONWriterTests.h"
#import "YAJSONWriter.h"

@interface YAJSONWriterTests()

@property (strong, nonatomic) id sbJSONWriterMock;
@property (strong, nonatomic) NSDictionary *dictionary;
@property (strong, nonatomic) YAJSONWriter *jsonWriter;

@end

@implementation YAJSONWriterTests

@synthesize sbJSONWriterMock = sbJSONWriterMock_;
@synthesize dictionary = dictionary_;
@synthesize jsonWriter = jsonWriter_;

- (void)setUp
{
    [self setSbJSONWriterMock:[OCMockObject mockForClass:[SBJsonWriter class]]];
    [self setDictionary:[NSDictionary dictionary]];
    [self setJsonWriter:[[YAJSONWriter alloc] init]];
    [[self jsonWriter] setSBJSONWriter:[self sbJSONWriterMock]];
}

- (void)testReturnsProductOfSBJSONWritingDictionaryToNSData
{
    NSData *data = [NSData data];
    
    [[[[self sbJSONWriterMock] expect] andReturn:data] dataWithObject:[self dictionary]];
    
    STAssertEqualObjects(data, [[self jsonWriter] dataFromDictionary:[self dictionary]], @"Unexpected data returned");
}

@end
