//
//  YARegistrationRepositoryTests.m
//  altoids
//
//  Created by Anand Subba Rao on 11/21/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "ManagedObjectContextFactory.h"
#import "RegistrationErrorCreator.h"
#import "RegistrationFetcher.h"
#import "RegistrationHandler.h"
#import "YARegistrationRepository.h"
#import "YARegistrationRepositoryTests.h"

@interface YARegistrationRepositoryTests ()
@property (strong, nonatomic) id registrationErrorCreatorMock;
@property (strong, nonatomic) id registrationFetcherMock;
@property (strong, nonatomic) id managedObjectContextFactoryMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id registrationHandlerMock;
@end

@implementation YARegistrationRepositoryTests

@synthesize registrationFetcherMock = registrationFetcherMock_;
@synthesize registrationErrorCreatorMock = registrationErrorCreatorMock_;
@synthesize managedObjectContextFactoryMock = managedObjectContextFactoryMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize registrationHandlerMock = registrationHandlerMock_;

// All code under test must be linked into the Unit Test bundle
- (void)setUp
{
    registrationFetcherMock_ = [OCMockObject mockForProtocol:@protocol(RegistrationFetcher)];
    registrationErrorCreatorMock_ = [OCMockObject mockForProtocol:@protocol(RegistrationErrorCreator)];
    managedObjectContextFactoryMock_  = [OCMockObject mockForProtocol:@protocol(ManagedObjectContextFactory)];
    managedObjectContextMock_ = [OCMockObject mockForClass:[NSManagedObjectContext class]];
    registrationHandlerMock_ = [OCMockObject mockForProtocol:@protocol(RegistrationHandler)];
    
}

- (void)testCreateWithNoExistingRegistration
{
    YARegistrationRepository *repo = [[YARegistrationRepository alloc] initWithManagedObjectContextFactory:[self managedObjectContextFactoryMock]
                                                                                       registrationFetcher:[self registrationFetcherMock]
                                                                                  registrationErrorCreator:[self registrationErrorCreatorMock]
                                                                                       registrationHandler:[self registrationHandlerMock]];
    
    
    [[[[self managedObjectContextFactoryMock] expect] andReturn:[self managedObjectContextMock]] create];
    
    NSError *error;
    [[[[self registrationFetcherMock] stub] andReturn:nil] fetchRegistrationInfoInManagedObjectContext:[self managedObjectContextMock] error:&error];
    
    id registrationMock = [OCMockObject mockForClass:[YARegistrationInfo class]];
    
    [[[[self registrationHandlerMock] expect] andReturn:registrationMock] createRegistrationInfoEntityInManagedObjectContext:[self managedObjectContextMock]];
    id info = [repo createRegistrationInfo];
    
    STAssertEquals(info, registrationMock, @"Expected createRegistrationInfo to return a valid registration Info");
}

@end
