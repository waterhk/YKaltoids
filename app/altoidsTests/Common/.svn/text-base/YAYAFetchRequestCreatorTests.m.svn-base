//
//  YAYAFetchRequestCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <objc/runtime.h>
#import <CoreData/CoreData.h>
#import <OCMock/OCMock.h>
#import "YAYAFetchRequestCreatorTests.h"
#import "YAFetchRequestCreator.h"


// define the declared fopen and fwrite $UNIX2003 that Apple seems to have left out in the SDKs that ship with Xcode 4.3
// see: http://www.infinite-loop.dk/blog/2012/02/code-coverage-and-fopen-unix2003-problems/
FILE *fopen$UNIX2003(const char *filename, const char *mode);
size_t fwrite$UNIX2003(const void *ptr, size_t size, size_t nitems, FILE *stream);
FILE *fopen$UNIX2003(const char *filename, const char *mode) {
    return fopen(filename, mode);
}
size_t fwrite$UNIX2003(const void *ptr, size_t size, size_t nitems, FILE *stream) {
    return fwrite(ptr, size, nitems, stream);
}


@interface YAYAFetchRequestCreatorTests()

@property (strong, nonatomic) id entityDescriptionMock;
@property (strong, nonatomic) id predicateMock;
@property (strong, nonatomic) YAFetchRequestCreator *fetchRequestCreator;

@end

@implementation YAYAFetchRequestCreatorTests

@synthesize entityDescriptionMock = entityDescriptionMock_;
@synthesize predicateMock = predicateMock_;
@synthesize fetchRequestCreator = fetchRequestCreator_;

- (void)setUp
{
    [self setEntityDescriptionMock:[OCMockObject mockForClass:[NSEntityDescription class]]];
    [self setPredicateMock:[OCMockObject mockForClass:[NSPredicate class]]];
    [self setFetchRequestCreator:[[YAFetchRequestCreator alloc] init]];
    
    [super setUp];
}

- (void)testCanCreateFetchRequestForEntity
{
    NSFetchRequest *fetchRequest = [[self fetchRequestCreator] fetchRequestForEntity:[self entityDescriptionMock]];
    
    STAssertEqualObjects([self entityDescriptionMock], [fetchRequest entity], @"Unexpected entity");
}

- (void)testCanCreateFetchRequestForEntityWithSortDescriptors
{
    NSArray *sortDescriptors = [NSArray array];
    NSFetchRequest *fetchRequest = [[self fetchRequestCreator] fetchRequestForEntity:[self entityDescriptionMock] withSortDescriptors:sortDescriptors];
    
    STAssertEqualObjects([self entityDescriptionMock], [fetchRequest entity], @"Unexpected entity");
    STAssertEqualObjects(sortDescriptors, [fetchRequest sortDescriptors], @"Unexpected sort descriptors");
}

- (void)testCanCreateFetchRequestForEntityWithPredicate
{
    NSFetchRequest *fetchRequest = [[self fetchRequestCreator] fetchRequestForEntity:[self entityDescriptionMock] withPredicate:[self predicateMock]];
    
    STAssertEqualObjects([self entityDescriptionMock], [fetchRequest entity], @"Unexpected entity");
    STAssertEqualObjects([self predicateMock], [fetchRequest predicate], @"Unexpected predicate");
}

- (void)testCanCreateFetchRequestForEntityWithPredicateSortDescriptors
{
    NSArray *sortDescriptors = [NSArray array];
    NSFetchRequest *fetchRequest = [[self fetchRequestCreator] fetchRequestForEntity:[self entityDescriptionMock] withPredicate:[self predicateMock] sortDescriptors:sortDescriptors];
    
    STAssertEqualObjects([self entityDescriptionMock], [fetchRequest entity], @"Unexpected entity");
    STAssertEqualObjects([self predicateMock], [fetchRequest predicate], @"Unexpected predicate");
    STAssertEqualObjects(sortDescriptors, [fetchRequest sortDescriptors], @"Unexpected sort descriptors");
}

@end
