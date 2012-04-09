//
//  YAAddressRepositoryTests.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAAddressRepositoryTests.h"
#import "AddressHandler.h"
#import "AddressErrorCreator.h"
#import "YAAddressRepository.h"
#import "YAAddressInfo.h"
#import "YAEmailAddressInfo.h"
#import "YAMMCAddressInfo.h"
#import "YASMSAddressInfo.h"
#import "YAAddress.h"

@interface YAAddressRepositoryTests()

@property (strong, nonatomic) id addressMock;
@property (strong, nonatomic) id addressInfoMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id addressHandlerMock;
@property (strong, nonatomic) id addressErrorCreatorMock;
@property (strong, nonatomic) YAAddressRepository *addressRepository;

@end

@implementation YAAddressRepositoryTests

@synthesize addressMock = addressMock_;
@synthesize addressInfoMock = addressInfoMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize addressHandlerMock = addressHandlerMock_;
@synthesize addressErrorCreatorMock = addressErrorCreatorMock_;
@synthesize addressRepository = addressRepository_;

- (void)setUp
{
    [self setAddressMock:[OCMockObject mockForClass:[YAAddress class]]];
    [self setAddressInfoMock:[OCMockObject mockForClass:[YAAddressInfo class]]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setAddressHandlerMock:[OCMockObject mockForProtocol:@protocol(AddressHandler)]];
    [self setAddressErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(AddressErrorCreator)]];

    [self setAddressRepository:[[YAAddressRepository alloc] init]];
    [[self addressRepository] setAddressHandler:[self addressHandlerMock]];
    [[self addressRepository] setAddressErrorCreator:[self addressErrorCreatorMock]];
}

- (void)testCreateAddressFromAddressInfoCreatesEmailAddressInManagedObjectContextIfGivenYAEmailAddressInfo
{
    BOOL isEmailAddressInfo = YES;
    BOOL isMMCAddressInfo = NO;
    BOOL isSMSAddressInfo = NO;
    NSError *error;
    NSString *handle = @"handle";
    
    [[[[self addressInfoMock] expect] andReturnValue:OCMOCK_VALUE(isEmailAddressInfo)] isKindOfClass:[YAEmailAddressInfo class]];
    [[[[self addressInfoMock] stub] andReturnValue:OCMOCK_VALUE(isMMCAddressInfo)] isKindOfClass:[YAMMCAddressInfo class]];
    [[[[self addressInfoMock] stub] andReturnValue:OCMOCK_VALUE(isSMSAddressInfo)] isKindOfClass:[YASMSAddressInfo class]];
    [[[[self addressInfoMock] expect] andReturn:handle] handle];
    
    [[[[self addressHandlerMock] expect] andReturn:[self addressMock]] createEmailAddressEntityInManagedObjectContext:[self managedObjectContextMock]];
    [[[self addressHandlerMock] expect] setHandle:handle forAddress:[self addressMock]];
    
    STAssertEqualObjects([self addressMock], [[self addressRepository] createAddressFromAddressInfo:[self addressInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected address returned");
    
    STAssertNil(error, @"Unexpected error");
    
    [[self addressInfoMock] verify];
    [[self addressMock] verify];
    [[self addressHandlerMock] verify];
    [[self addressErrorCreatorMock] verify];
}

- (void)testCreateAddressFromAddressInfoCreatesMMCAddressInManagedObjectContextIfGivenYAMMCAddressInfo
{
    BOOL isEmailAddressInfo = NO;
    BOOL isMMCAddressInfo = YES;
    BOOL isSMSAddressInfo = NO;
    NSError *error;
    NSString *handle = @"handle";
    
    [[[[self addressInfoMock] stub] andReturnValue:OCMOCK_VALUE(isEmailAddressInfo)] isKindOfClass:[YAEmailAddressInfo class]];
    [[[[self addressInfoMock] expect] andReturnValue:OCMOCK_VALUE(isMMCAddressInfo)] isKindOfClass:[YAMMCAddressInfo class]];
    [[[[self addressInfoMock] stub] andReturnValue:OCMOCK_VALUE(isSMSAddressInfo)] isKindOfClass:[YASMSAddressInfo class]];
    [[[[self addressInfoMock] expect] andReturn:handle] handle];
    
    [[[[self addressHandlerMock] expect] andReturn:[self addressMock]] createMMCAddressEntityInManagedObjectContext:[self managedObjectContextMock]];
    [[[self addressHandlerMock] expect] setHandle:handle forAddress:[self addressMock]];
    
    STAssertEqualObjects([self addressMock], [[self addressRepository] createAddressFromAddressInfo:[self addressInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected address returned");
    
    STAssertNil(error, @"Unexpected error");
    
    [[self addressInfoMock] verify];
    [[self addressMock] verify];
    [[self addressHandlerMock] verify];
    [[self addressErrorCreatorMock] verify];
}

- (void)testCreateAddressFromAddressInfoCreatesSMSAddressInManagedObjectContextIfGivenYASMSAddressInfo
{
    BOOL isEmailAddressInfo = NO;
    BOOL isMMCAddressInfo = NO;
    BOOL isSMSAddressInfo = YES;
    NSError *error;
    NSString *handle = @"handle";
    
    [[[[self addressInfoMock] stub] andReturnValue:OCMOCK_VALUE(isEmailAddressInfo)] isKindOfClass:[YAEmailAddressInfo class]];
    [[[[self addressInfoMock] stub] andReturnValue:OCMOCK_VALUE(isMMCAddressInfo)] isKindOfClass:[YAMMCAddressInfo class]];
    [[[[self addressInfoMock] expect] andReturnValue:OCMOCK_VALUE(isSMSAddressInfo)] isKindOfClass:[YASMSAddressInfo class]];
    [[[[self addressInfoMock] expect] andReturn:handle] handle];
    
    [[[[self addressHandlerMock] expect] andReturn:[self addressMock]] createSMSAddressEntityInManagedObjectContext:[self managedObjectContextMock]];
    [[[self addressHandlerMock] expect] setHandle:handle forAddress:[self addressMock]];
    
    STAssertEqualObjects([self addressMock], [[self addressRepository] createAddressFromAddressInfo:[self addressInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected address returned");
    
    STAssertNil(error, @"Unexpected error");
    
    [[self addressInfoMock] verify];
    [[self addressMock] verify];
    [[self addressHandlerMock] verify];
    [[self addressErrorCreatorMock] verify];
}

- (void)testCreateAddressFromAddressInfoReturnsNilAndSetsErrorIfGivenUnknownAddressType
{
    BOOL isEmailAddressInfo = NO;
    BOOL isMMCAddressInfo = NO;
    BOOL isSMSAddressInfo = NO;
    NSError *error;
    NSError *addressCreatorError = [NSError errorWithDomain:@"d" code:123 userInfo:nil];
    
    [[[[self addressInfoMock] expect] andReturnValue:OCMOCK_VALUE(isEmailAddressInfo)] isKindOfClass:[YAEmailAddressInfo class]];
    [[[[self addressInfoMock] expect] andReturnValue:OCMOCK_VALUE(isMMCAddressInfo)] isKindOfClass:[YAMMCAddressInfo class]];
    [[[[self addressInfoMock] expect] andReturnValue:OCMOCK_VALUE(isSMSAddressInfo)] isKindOfClass:[YASMSAddressInfo class]];
    
    [[[[self addressErrorCreatorMock] expect] andReturn:addressCreatorError] errorWithCode:YAAddressErrorCodeUnknownAddressType];
    
    STAssertNil([[self addressRepository] createAddressFromAddressInfo:[self addressInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected address returned");
    
    STAssertEqualObjects(addressCreatorError, error, @"Unexpected error");
    
    [[self addressInfoMock] verify];
    [[self addressMock] verify];
    [[self addressHandlerMock] verify];
    [[self addressErrorCreatorMock] verify];
}

@end
