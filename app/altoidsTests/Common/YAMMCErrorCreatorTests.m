//
//  YAMMCErrorCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 11/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMMCErrorCreatorTests.h"
#import "ErrorCreator.h"
#import "YAMMCErrorCreator.h"

@interface YAMMCErrorCreatorTests()

@property (strong, nonatomic) id errorCreatorMock;
@property (strong, nonatomic) YAMMCErrorCreator *mmcErrorCreator;

@end

@implementation YAMMCErrorCreatorTests

@synthesize errorCreatorMock = errorCreatorMock_;
@synthesize mmcErrorCreator = mmcErrorCreator_;

- (void)setUp
{
    [self setErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(ErrorCreator)]];
    [self setMmcErrorCreator:[[YAMMCErrorCreator alloc] init]];
    [[self mmcErrorCreator] setErrorCreator:[self errorCreatorMock]];
}

- (void)testIfGivenNilOrEmptyArrayOfErrorsReturnsNil
{
    STAssertNil([[self mmcErrorCreator] errorFromMMCConversationErrors:nil], @"Unexpected error returned");
    STAssertNil([[self mmcErrorCreator] errorFromMMCConversationErrors:[NSArray array]], @"Unexpected error returned");
}

- (void)testIfGivenArrayHasOneErrorReturnsThatError
{
    NSError *error = [NSError errorWithDomain:@"d" code:1 userInfo:nil];
    
    STAssertEqualObjects(error, [[self mmcErrorCreator] errorFromMMCConversationErrors:[NSArray arrayWithObject:error]], @"Unexpected error returned");
}

- (void)testIfGivenArrayHasMoreThanOneErrorErrorsAreSetAsUnderlyingErrorsOfOneAnotherWithTheFirstErrorBeingReturned
{
    NSError *error1 = [NSError errorWithDomain:@"d1" code:1 userInfo:nil];
    NSError *error2 = [NSError errorWithDomain:@"d2" code:2 userInfo:nil];
    NSError *error3 = [NSError errorWithDomain:@"d3" code:3 userInfo:nil];
    NSArray *errors = [NSArray arrayWithObjects:error1, error2, error3, nil];
    
    [[[[self errorCreatorMock] expect] andReturn:error1] errorFromError:error1 withUnderlyingError:error2];
    [[[[self errorCreatorMock] expect] andReturn:error2] errorFromError:error2 withUnderlyingError:error3];
    [[[[self errorCreatorMock] expect] andReturn:error3] errorFromError:error3 withUnderlyingError:nil];
    
    NSError *returnedError = [[self mmcErrorCreator] errorFromMMCConversationErrors:errors];
    
    STAssertEqualObjects(returnedError, error1, @"Unexpected error returned");
    
    [[self errorCreatorMock] verify];
}

@end
