//
//  YAProfileCommandErrorHandlerTests.m
//  altoids
//
//  Created by Anand Biligiri on 12/21/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAProfileCommandErrorHandlerTests.h"
#import "YAProfileCommandErrorHandler.h"

@interface YAProfileCommandErrorHandlerTests()
@property (strong, nonatomic) id errorHandlerMock;
@property (strong, nonatomic) id errorCreatorMock;
@property (strong, nonatomic) YAProfileCommandErrorHandler *profileCommandErrorHandler;
@end

@implementation YAProfileCommandErrorHandlerTests
@synthesize errorHandlerMock = errorHandlerMock_;
@synthesize errorCreatorMock = errorCreatorMock_;
@synthesize profileCommandErrorHandler = profileCommandErrorHandler_;

- (void)setUp
{
    [self setErrorHandlerMock:[OCMockObject mockForProtocol:@protocol(ErrorHandler)]];
    [self setErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(ProfileErrorCreator)]];
    
    profileCommandErrorHandler_ = [[YAProfileCommandErrorHandler alloc] initWithErrorHandler:[self errorHandlerMock] profileErrorCreator:[self errorCreatorMock]];
}
// All code under test must be linked into the Unit Test bundle
- (void)testCanParseErrorCode
{
    id dictionaryMock = [OCMockObject mockForClass:[NSDictionary class]];
    id errorObjectMock = [OCMockObject mockForClass:[NSDictionary class]];
    
    [[[dictionaryMock expect] andReturn:errorObjectMock] valueForKey:@"error"];
    
    //BOOL yes = YES;
    //[[[errorObjectMock expect] andReturnValue:OCMOCK_VALUE(yes)] respondsToSelector:@selector(objectForKey:)];
    
    id detailStringMock = [OCMockObject mockForClass:[NSString class]];    
    [[[errorObjectMock expect] andReturn:detailStringMock] objectForKey:@"detail"];
    
    //[[[detailStringMock expect] andReturnValue:OCMOCK_VALUE(yes)] respondsToSelector:@selector(characterAtIndex:)];
    
    unichar equalTo = '=';
    NSUInteger detailLength = 10;
    
    [[[detailStringMock expect] andReturnValue:OCMOCK_VALUE(detailLength)] length];
    [[[detailStringMock expect] andReturnValue:OCMOCK_VALUE(equalTo)] characterAtIndex:0];
    
    unichar code[] = {'2', '0', '0' , '0', '1'};
    [[[detailStringMock expect] andReturnValue:OCMOCK_VALUE(code[0])] characterAtIndex:1];
    [[[detailStringMock expect] andReturnValue:OCMOCK_VALUE(code[1])] characterAtIndex:2];
    [[[detailStringMock expect] andReturnValue:OCMOCK_VALUE(code[2])] characterAtIndex:3];
    [[[detailStringMock expect] andReturnValue:OCMOCK_VALUE(code[3])] characterAtIndex:4];
    [[[detailStringMock expect] andReturnValue:OCMOCK_VALUE(code[4])] characterAtIndex:5];
    [[[detailStringMock expect] andReturnValue:OCMOCK_VALUE(equalTo)] characterAtIndex:6];
    
    [[[detailStringMock expect] andReturn:@"20001"] substringWithRange:NSMakeRange(1, 5)];
    id errorMock = [OCMockObject mockForClass:[NSError class]];
    [[[[self errorCreatorMock] expect] andReturn:errorMock] errorWithCode:20001];

    NSError *returnError = nil;
    BOOL ret = [[self profileCommandErrorHandler] parsedJSONResponseHasError:dictionaryMock error:&returnError];
    
    STAssertTrue(ret, @"Expecting return value to be YES");
    STAssertEqualObjects(returnError, errorMock, @"Error object returned not the same as one sent as errorMock");    
    
    [dictionaryMock verify];
    [errorObjectMock verify];
    [detailStringMock verify];
}

- (void)tearDown
{
    [[self errorCreatorMock] verify];
    [[self errorHandlerMock] verify];    
}
@end
