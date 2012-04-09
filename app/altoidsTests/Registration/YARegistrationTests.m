//
//  RegistrationTests.m
//  altoids
//
//  Created by Anand Subba Rao on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YARegistrationTests.h"
#import "YARegistrationService.h"
#import "RegistrationTokenRetrieverDelegate.h"
#import "RegistrationRenewDelegate.h"
#import "RegistrationVerifyTokenDelegate.h"

@interface YARegistrationTests()
@property (nonatomic, strong) YARegistrationService *service;
@property (nonatomic, strong) id repository;
@property (nonatomic, strong) id commandFactory;
@property (nonatomic, strong) id mmcCommandQueue;

@property (nonatomic, strong) id mockTokenRetrieverDelegate;
@property (nonatomic, strong) id mockVerifyTokenDelegate;
@property (nonatomic, strong) id mockRenewDelegate;
@property (nonatomic, strong) id mockResponseHandler;
@end

@implementation YARegistrationTests
@synthesize service = service_;
@synthesize repository = repository_;
@synthesize mmcCommandQueue = mmcCommandQueue_;
@synthesize commandFactory = commandFactory_;

@synthesize mockTokenRetrieverDelegate = mockTokenRetrieverDelegate_;
@synthesize mockVerifyTokenDelegate = mockVerifyTokenDelegate_;
@synthesize mockRenewDelegate = mockRenewDelegate_;
@synthesize mockResponseHandler = mockResponseHandler_;

- (void)setUp {
    repository_ = [OCMockObject mockForProtocol:@protocol(RegistrationRepository)];
    mmcCommandQueue_ = [OCMockObject mockForProtocol:@protocol(CommandQueue)];
    commandFactory_ = [OCMockObject mockForProtocol:@protocol(RegistrationCommandFactory)];
    
    mockTokenRetrieverDelegate_ = [OCMockObject mockForProtocol:@protocol(RegistrationTokenRetrieverDelegate)];
    mockVerifyTokenDelegate_ = [OCMockObject mockForProtocol:@protocol(RegistrationVerifyTokenDelegate)];
    mockRenewDelegate_ = [OCMockObject mockForProtocol:@protocol(RegistrationRenewDelegate)];
    
    mockResponseHandler_ = [OCMockObject mockForProtocol:@protocol(RegistrationResponseHandler)];
    
    service_ = [[YARegistrationService alloc] init];
    [service_ setRegistrationCommandFactory:commandFactory_];
    [service_ setMmcCommandQueue:mmcCommandQueue_];
}

// All code under test must be linked into the Unit Test bundle
- (void)testGetToken
{
    [[[self mockTokenRetrieverDelegate] expect] didSendGetToken];
    id mockCommand = [OCMockObject mockForProtocol:@protocol(Command)];
    [[[[self commandFactory] expect] andReturn:mockCommand] createGetTokenCommandWithCountryCode:@"310" networkCode:@"11" subscriberID:@"foo"
                                                                                 responseHandler:[self service] context:[self mockTokenRetrieverDelegate]];
    [[[self mmcCommandQueue] expect] append:mockCommand];
    
    [[self service] getTokenWithCountryCode:@"310" networkCode:@"11" subscriberID:@"foo" delegate:[self mockTokenRetrieverDelegate]];
    [[self mockTokenRetrieverDelegate] verify];
    [[self commandFactory] verify];
    [[self mmcCommandQueue] verify];
}

- (void)testVerifyToken
{
    [[[self mockVerifyTokenDelegate] expect] didSendVerifyToken];
    id mockCommand = [OCMockObject mockForProtocol:@protocol(Command)];
    [[[[self commandFactory] expect] andReturn:mockCommand] createVerifyTokenCommandWithToken:@"foobar"
                                                                              responseHandler:[self service] context:[self mockVerifyTokenDelegate]];
    [[[self mmcCommandQueue] expect] append:mockCommand];
    
    [[self service] verifyToken:@"foobar" delegate:[self mockVerifyTokenDelegate]];
    [[self mockVerifyTokenDelegate] verify];
    [[self commandFactory] verify];
    [[self mmcCommandQueue] verify];
}

- (void)testRenewRegistration
{
    [[[self mockRenewDelegate] expect] didSendRenewRegistration];
    id mockCommand = [OCMockObject mockForProtocol:@protocol(Command)];
    [[[[self commandFactory] expect] andReturn:mockCommand] createRenewCommandWithPhoneNumber:@"4081234567"
                                                                              responseHandler:[self service] context:[self mockRenewDelegate]];
    [[[self mmcCommandQueue] expect] append:mockCommand];
    
    [[self service] renewRegistrationWithPhoneNumber:@"4081234567" delegate:[self mockRenewDelegate]];
    [[self mockRenewDelegate] verify];
    [[self commandFactory] verify];
    [[self mmcCommandQueue] verify];
}

@end
