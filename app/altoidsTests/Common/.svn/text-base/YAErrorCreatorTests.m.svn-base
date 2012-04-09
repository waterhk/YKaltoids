//
//  YAErrorCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 11/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAErrorCreatorTests.h"
#import "YAErrorCreator.h"
#import "MutableDictionaryCreator.h"

@interface YAErrorCreatorTests()

@property (strong, nonatomic) NSMutableDictionary *userInfo;
@property (strong, nonatomic) id mutableDictionaryCreatorMock;
@property (strong, nonatomic) YAErrorCreator *errorCreator;

- (NSError *)underlyingErrorForError:(NSError *)theError;

@end

@implementation YAErrorCreatorTests

@synthesize userInfo = userInfo_;
@synthesize mutableDictionaryCreatorMock = mutableDictionaryCreatorMock_;
@synthesize errorCreator = errorCreator_;

- (void)setUp
{
    [self setUserInfo:[NSMutableDictionary dictionary]];
    
    [self setMutableDictionaryCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableDictionaryCreator)]];

    [self setErrorCreator:[[YAErrorCreator alloc] init]];
    [[self errorCreator] setMutableDictionaryCreator:[self mutableDictionaryCreatorMock]];
}

- (void)testCanCreateErrorFromExistingErrorWithNewUnderlyingError
{
    NSError *existingError = [NSError errorWithDomain:@"d" code:1 userInfo:nil];
    NSError *underlyingError = [NSError errorWithDomain:@"u" code:2 userInfo:nil];
    NSError *newError;
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:[self userInfo]] mutableDictionaryWithDictionary:nil];
    
    newError = [[self errorCreator] errorFromError:existingError withUnderlyingError:underlyingError];
    
    STAssertEqualObjects(underlyingError, [self underlyingErrorForError:newError], @"Unexpected underlying error");
    STAssertEquals(1, [newError code], @"Unexpected error code");
    STAssertTrue([[newError domain] isEqualToString:@"d"], @"Unexpected error domain");
}

- (void)testWhenCreatingErrorFromExistingErrorIfUnderlyingErrorIsNilExistingErrorIsReturned
{
    NSError *existingError = [NSError errorWithDomain:@"d" code:1 userInfo:nil];
    
    STAssertEqualObjects(existingError, [[self errorCreator] errorFromError:existingError withUnderlyingError:nil], @"Unexpected error returned");
}

- (void)testCreatedErrorHasExpectedDomain
{
    NSString *domain = @"myDomain";
    NSError *error;
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:[self userInfo]] mutableDictionaryWithCapacity:2];
    
    error = [[self errorCreator] errorWithDomain:domain code:1 localizedDescription:@"" underlyingError:nil];
    
    STAssertTrue([[error domain] isEqualToString:domain], @"Unexpected domain");
    
    [[self mutableDictionaryCreatorMock] verify];
}

- (void)testCreatedErrorHasExpectedErrorCode
{
    NSInteger errorCode = 100;
    NSError *error;
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:[self userInfo]] mutableDictionaryWithCapacity:2];
    
    error = [[self errorCreator] errorWithDomain:@"" code:errorCode localizedDescription:@"" underlyingError:nil];
    
    STAssertEquals(errorCode, [error code], @"Unexpected error code");
    
    [[self mutableDictionaryCreatorMock] verify];
}

- (void)testCreatedErrorHasExpectedLocalizedDescription
{
    NSString *localizedDescription = @"desc";
    NSError *error;
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:[self userInfo]] mutableDictionaryWithCapacity:2];
    
    error = [[self errorCreator] errorWithDomain:@"" code:0 localizedDescription:localizedDescription underlyingError:nil];
    
    STAssertTrue([[error localizedDescription] isEqualToString:localizedDescription], @"Unexpected localized description");
    
    [[self mutableDictionaryCreatorMock] verify];
}

- (void)testCreatedErrorHasUnderlyingErrorIfUnderlyingErrorWasProvided
{
    NSError *underlyingError;
    NSError *error;
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:[self userInfo]] mutableDictionaryWithCapacity:2];
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:[self userInfo]] mutableDictionaryWithCapacity:2];
    
    underlyingError = [[self errorCreator] errorWithDomain:@"" code:0 localizedDescription:@"" underlyingError:nil];
    error = [[self errorCreator] errorWithDomain:@"" code:0 localizedDescription:@"" underlyingError:underlyingError];
      
    STAssertEqualObjects(underlyingError, [self underlyingErrorForError:error], @"Unexpected underlying error");
    
    [[self mutableDictionaryCreatorMock] verify];
}

- (void)testCreatedErrorDoesNotHaveUnderlyingErrorIfNoUnderlyingErrorWasProvided
{
    NSError *error;
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:[self userInfo]] mutableDictionaryWithCapacity:2];
    
    error = [[self errorCreator] errorWithDomain:@"" code:0 localizedDescription:@"" underlyingError:nil];
    
    STAssertNil([self underlyingErrorForError:error], @"Unexpected underyling error");
    
    [[self mutableDictionaryCreatorMock] verify];
}

- (NSError *)underlyingErrorForError:(NSError *)theError
{
    NSDictionary *userInfo = [theError userInfo];
    
    return [userInfo objectForKey:NSUnderlyingErrorKey];
}

@end
