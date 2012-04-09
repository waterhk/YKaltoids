//
//  YAMMCErrorHandlerTests.m
//  altoids
//
//  Created by Jon Herron on 11/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMMCErrorHandlerTests.h"
#import "YAMMCErrorHandler.h"

@interface YAMMCErrorHandlerTests()

@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id managedObjectContextFactoryMock;
@property (strong, nonatomic) id managedObjectIDMock;
@property (strong, nonatomic) id managedObjectMock;
@property (strong, nonatomic) YAMMCErrorHandler *mmcErrorHandler;

@end

@implementation YAMMCErrorHandlerTests

@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize managedObjectContextFactoryMock = managedObjectContextFactoryMock_;
@synthesize managedObjectIDMock = managedObjectIDMock_;
@synthesize managedObjectMock = managedObjectMock_;
@synthesize mmcErrorHandler = mmcErrorHandler_;

- (void)setUp
{
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setManagedObjectContextFactoryMock:[OCMockObject mockForProtocol:@protocol(ManagedObjectContextFactory)]];
    [self setManagedObjectIDMock:[OCMockObject mockForClass:[NSManagedObjectID class]]];
    [self setManagedObjectMock:[OCMockObject mockForClass:[NSManagedObject class]]];
    
    [self setMmcErrorHandler:[[YAMMCErrorHandler alloc] initWithManagedObjectContextFactory:[self managedObjectContextFactoryMock]]];
}

- (void)testCanCreateManagedObjectContext
{
    [[[[self managedObjectContextFactoryMock] expect] andReturn:[self managedObjectContextMock]] create];
    
    STAssertEqualObjects([self managedObjectContextMock], [[self mmcErrorHandler] managedObjectContext], @"Unexpected managed object context return");
    
    [[self managedObjectContextFactoryMock] verify];
}

- (void)testCanFindManagedObjectByIDInManagedObjectContext
{
    [[[[self managedObjectContextFactoryMock] stub] andReturn:[self managedObjectContextMock]] create];
    
    [[[[self managedObjectContextMock] expect] andReturn:[self managedObjectMock]] objectWithID:[self managedObjectIDMock]];
    
    STAssertEqualObjects([self managedObjectMock], [[self mmcErrorHandler] managedObjectWithID:[self managedObjectIDMock]], @"Unexpected managed object returned");
    
    [[self managedObjectContextMock] verify];
    [[self managedObjectIDMock] verify];
    [[self managedObjectMock] verify];
}

@end
