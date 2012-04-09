//
//  YACompositeCommandTests.m
//  altoids
//
//  Created by Jon Herron on 1/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "YACompositeCommand.h"

@interface YACompositeCommandTests : SenTestCase

@property (strong, nonatomic) YACompositeCommand *compositeCommand;

@end

@implementation YACompositeCommandTests

@synthesize compositeCommand = compositeCommand_;

- (void)testHandlesNilInputGracefully
{
    [[[YACompositeCommand alloc] initWithCommands:nil] execute];
}

- (void)testHandlesEmptyArrayOfCommandsGracefully
{
    [[[YACompositeCommand alloc] initWithCommands:[NSArray array]] execute];
}

- (void)testExecutesEachCommandProvidedInTheArrayOfCommandsAndReturnsNilUponSuccess
{
    id subCommand1 = [OCMockObject mockForProtocol:@protocol(Command)];
    id subCommand2 = [OCMockObject mockForProtocol:@protocol(Command)];
    id subCommand3 = [OCMockObject mockForProtocol:@protocol(Command)];
    NSArray *arrayOfCommands = [NSArray arrayWithObjects:subCommand1, subCommand2, subCommand3, nil];
    
    [[subCommand1 expect] execute];
    [[subCommand2 expect] execute];
    [[subCommand3 expect] execute];
    
    NSError* result = [[[YACompositeCommand alloc] initWithCommands:arrayOfCommands] execute];
    STAssertNil(result, nil);
    
    [subCommand1 verify];
    [subCommand2 verify];
    [subCommand3 verify];
}

- (void)testAbortsExecutionAndReturnsSubCommandError
{
    id subCommand1 = [OCMockObject mockForProtocol:@protocol(Command)];
    id subCommand2 = [OCMockObject mockForProtocol:@protocol(Command)];
    id subCommand3 = [OCMockObject mockForProtocol:@protocol(Command)];
    NSArray *arrayOfCommands = [NSArray arrayWithObjects:subCommand1, subCommand2, subCommand3, nil];

    NSError* error = [[NSError alloc] init];
    [[subCommand1 expect] execute];
    [[[subCommand2 expect] andReturn:error] execute];

    [[subCommand3 reject] execute];

    NSError* result = [[[YACompositeCommand alloc] initWithCommands:arrayOfCommands] execute];
    STAssertEquals(result, error, nil);
    
    [subCommand1 verify];
    [subCommand2 verify];
    [subCommand3 verify];
}


@end
