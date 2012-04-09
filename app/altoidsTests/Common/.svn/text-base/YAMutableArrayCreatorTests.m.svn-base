//
//  YAMutableArrayCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <objc/runtime.h>
#import "YAMutableArrayCreatorTests.h"
#import "YAMutableArrayCreator.h"

@interface YAMutableArrayCreatorTests()

@property (assign, nonatomic) Method arrayWithCapacityMethod;
@property (assign, nonatomic) Method standInArrayWithCapacityMethod;
@property (strong, nonatomic) NSMutableArray *mutableArray;
@property (strong, nonatomic) NSNumber *capacity;
@property (strong, nonatomic) YAMutableArrayCreator *mutableArrayCreator;

- (id)arrayWithCapacity:(NSUInteger)numItems;
- (void)prepNSMutableArray;
- (NSArray *)testDataCache;

@end

@implementation YAMutableArrayCreatorTests

@synthesize arrayWithCapacityMethod = arrayWithCapacityMethod_;
@synthesize standInArrayWithCapacityMethod = standInArrayWithCapacityMethod_;
@synthesize mutableArray = mutableArrayMock;
@synthesize capacity = capacity_;
@synthesize mutableArrayCreator = mutableArrayCreator_;

- (void)setUp
{
    [super setUp];
    
    [self setCapacity:[NSNumber numberWithInt:123]];
    [self setMutableArray:[NSMutableArray array]];
    [self setMutableArrayCreator:[[YAMutableArrayCreator alloc] init]];
}

- (void)tearDown
{
    method_exchangeImplementations([self standInArrayWithCapacityMethod], [self arrayWithCapacityMethod]);
    
    [super tearDown];
}

- (void)testCanCreateMutableArrayWithGivenCapacity
{
    STAssertEqualObjects([self mutableArray], [[self mutableArrayCreator] mutableArrayWithCapacity:[[self capacity] intValue]], @"Unexpected mutable array returned");
}

- (id)arrayWithCapacity:(NSUInteger)numItems
{
    NSArray *testData = [self testDataCache];
    
    STAssertTrue([[testData objectAtIndex:0] intValue] == numItems, @"Unexpected numItems");
    
    return [testData objectAtIndex:1];
}

- (void)prepNSMutableArray
{
    Class nsMutableArrayMetaClass = objc_getMetaClass("NSMutableArray");
    IMP testDataCacheImp = nil;
    SEL selector = @selector(arrayWithCapacity:);
    
    [self setArrayWithCapacityMethod:class_getClassMethod([NSMutableArray class], selector)];
    [self setStandInArrayWithCapacityMethod:class_getInstanceMethod([self class], selector)];
    
    method_exchangeImplementations([self arrayWithCapacityMethod], [self standInArrayWithCapacityMethod]);
    
    testDataCacheImp = imp_implementationWithBlock((__bridge void *)[(^NSArray *() {
        return [NSArray arrayWithObjects:[self capacity], [self mutableArray], nil];
    }) copy]);
    
    class_addMethod(nsMutableArrayMetaClass, @selector(testDataCache), testDataCacheImp, "");
}

- (NSArray *)testDataCache
{
    // never really called, but required to prep NSMutableArray
    return nil;
}

@end
