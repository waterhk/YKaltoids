//
//  YACommandErrorHandlerTests.m
//  altoids
//
//  Created by Anand Biligiri on 12/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YACommandErrorHandlerTests.h"
#import "ErrorHandler.h"
#import "ErrorCreator.h"
#import "YACommandErrorHandler.h"

@interface YACommandErrorHandlerTests ()
@property (strong, nonatomic) id errorHandlerMock;
@property (strong, nonatomic) id errorCreatorMock;
@property (strong, nonatomic) YACommandErrorHandler *commandErrorHandler;
@end

@implementation YACommandErrorHandlerTests
@synthesize errorHandlerMock = errorHandlerMock_;
@synthesize errorCreatorMock = errorCreatorMock_;
@synthesize commandErrorHandler = commandErrorHandler_;

- (void)setUp
{
    errorHandlerMock_ = [OCMockObject mockForProtocol:@protocol(ErrorHandler)];
    errorCreatorMock_ = [OCMockObject mockForProtocol:@protocol(ErrorCreator)];
    commandErrorHandler_ = [[YACommandErrorHandler alloc] initWithErrorHandler:[self errorHandlerMock] commandErrorCreator:[self errorCreatorMock]];    
    
}

// All code under test must be linked into the Unit Test bundle
- (void)testCanParseErrorsInResponse
{
    NSDictionary *errorDetail = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:4], @"code",
                                 @"mgr", @"ns",
                                 @"This is a message", @"message",
                                 [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"1", @"2", @"3", nil], @"mids", nil], @"detail",
                                 nil];
    NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:errorDetail, @"error",nil];
    NSDictionary *response = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:errorDict], @"errors",nil];
    
    NSError *error = nil;
    STAssertTrue([[self commandErrorHandler] parsedJSONResponseHasError:response error:&error], @"Unexpected return value");
    
    STAssertNotNil(error, @"Unexpected value for error");
    
    STAssertEquals([error domain], @"mgr", @"Unexpected domain for error");
    STAssertEquals([error code], 4, @"Unexpected error code");
    
    NSDictionary *userInfo = [error userInfo];
    
    STAssertNotNil(userInfo, @"Unexpected value for userInfo");
    
    NSDictionary *detail = [userInfo valueForKey:kMMCErrorDetailKey];
    STAssertNotNil(detail, @"Unexpected value for detail in userInfo");
    
    NSArray *mids = [detail valueForKey:@"mids"];
    STAssertNotNil(mids, @"Unexpected value for mids in error userInfo detail");
    STAssertEquals([mids count], 3u, @"Unexpected number of elements in mids");
    
    NSArray *expectedMids = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    STAssertEqualObjects(mids, expectedMids, @"Unexpected values in mids");
    
}
@end
