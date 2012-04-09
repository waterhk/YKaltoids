//
//  YAInMemoryTransportIntegrationTests.m
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <SBJson/SBJson.h>
#import "YAInMemoryTransportIntegrationTests.h"
#import "YAInMemoryTransport.h"
#import "YAJSONParser.h"

@interface YAInMemoryTransportIntegrationTests()

@property (strong, nonatomic) SBJsonParser *sbJSONParser;
@property (strong, nonatomic) YAInMemoryTransport *inMemoryTransport;
@property (strong, nonatomic) YAJSONParser *jsonParser;

@end

@implementation YAInMemoryTransportIntegrationTests

@synthesize sbJSONParser = sbJSONParser_;
@synthesize inMemoryTransport = inMemoryTransport_;
@synthesize jsonParser = jsonParser_;

- (void)setUp
{
    [self setSbJSONParser:[[SBJsonParser alloc] init]];
    [self setJsonParser:[[YAJSONParser alloc] init]];
    [[self jsonParser] setSBJSONParser:[self sbJSONParser]];
    
    [self setInMemoryTransport:[[YAInMemoryTransport alloc] init]];
}

- (void)testConversationsJSONResponseWillParse
{
    id<HTTPURLResponse> urlResponse = nil;
    NSData *data = nil;
    NSDictionary *results = nil;
    NSError *error = nil;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://conversations"]];
    
    [[self inMemoryTransport] sendSynchronousRequest:urlRequest returningResponse:&urlResponse data:&data error:&error];
    
    STAssertNotNil(data, @"Unexpected nil data");
    
    results = [[self jsonParser] parseJSONData:data];
    
    STAssertNotNil(results, @"Failed to parse data");
    
    STAssertTrue([[results objectForKey:@"moreConvPresent"] boolValue], @"Unexpected false for moreConvPresent");
}

@end
