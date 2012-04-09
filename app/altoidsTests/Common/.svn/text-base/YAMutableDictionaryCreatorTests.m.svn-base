//
//  YAMutableDictionaryCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <objc/runtime.h>
#import "YAMutableDictionaryCreatorTests.h"
#import "YAMutableDictionaryCreator.h"

@interface YAMutableDictionaryCreatorTests()

@property (assign, nonatomic) Method dictionaryWithCapacityMethod;
@property (assign, nonatomic) Method standInDictionaryWithCapacityMethod;
@property (assign, nonatomic) Method dictionaryWithDictionaryMethod;
@property (assign, nonatomic) Method standInDictionaryWithDictionaryMethod;
@property (strong, nonatomic) NSDictionary *dictionary;
@property (strong, nonatomic) NSMutableDictionary *mutableDictionary;
@property (strong, nonatomic) NSNumber *capacity;
@property (strong, nonatomic) YAMutableDictionaryCreator *mutableDictionaryCreator;

- (id)dictionaryWithCapacity:(NSUInteger)numItems;
- (id)dictionaryWithDictionary:(NSDictionary *)dict;
- (void)prepNSMutableDictionary;
- (NSArray *)testDataCache;

@end

@implementation YAMutableDictionaryCreatorTests

@synthesize dictionaryWithCapacityMethod = dictionaryWithCapacityMethod_;
@synthesize standInDictionaryWithCapacityMethod = standInDictionaryWithCapacityMethod_;
@synthesize dictionaryWithDictionaryMethod = dictionaryWithDictionaryMethod_;
@synthesize standInDictionaryWithDictionaryMethod = standInDictionaryWithDictionaryMethod_;
@synthesize dictionary = dictionary_;
@synthesize mutableDictionary = mutableDictionary_;
@synthesize capacity = capacity_;
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;

- (void)setUp
{
    [super setUp];
    
    [self setCapacity:[NSNumber numberWithInt:43]];
    [self setMutableDictionary:[NSMutableDictionary dictionary]];
    [self setMutableDictionaryCreator:[[YAMutableDictionaryCreator alloc] init]];
}

- (void)tearDown
{
    method_exchangeImplementations([self standInDictionaryWithCapacityMethod], [self dictionaryWithCapacityMethod]);
    method_exchangeImplementations([self standInDictionaryWithDictionaryMethod], [self dictionaryWithDictionaryMethod]);
    
    [super tearDown];
}

- (void)testCanCreateMutableDictionaryWithGivenCapacity
{
    STAssertNotNil([[self mutableDictionaryCreator] mutableDictionaryWithCapacity:11], @"Unexpected nil mutable dictionary");
}

- (void)testCanCreateMutableDictionaryWithGivenDictionary
{
    STAssertNotNil([[self mutableDictionaryCreator] mutableDictionaryWithDictionary:[self dictionary]], @"Unexpected nil mutable dictionary");
}

- (id)dictionaryWithCapacity:(NSUInteger)numItems
{
    NSArray *testData = [self testDataCache];
    
    STAssertTrue([[testData objectAtIndex:0] intValue] == numItems, @"Unexpected numItems");
    
    return [testData objectAtIndex:1];
}

- (id)dictionaryWithDictionary:(NSDictionary *)dict
{
    NSArray *testData = [self testDataCache];
    
    STAssertEqualObjects(dict, [testData objectAtIndex:2], @"Unexpected dictionary");
    
    return [testData objectAtIndex:1];
}

- (void)prepNSMutableDictionary
{
    Class nsMutableDictionaryMetaClass = objc_getMetaClass("NSMutableDictionary");
    IMP testDataCacheImp = nil;
    SEL dictionaryWithCapacitySelector = @selector(dictionaryWithCapacity:);
    SEL dictionaryWithDictionarySelector = @selector(dictionaryWithDictionary:);
    
    [self setDictionaryWithCapacityMethod:class_getClassMethod([NSMutableDictionary class], dictionaryWithCapacitySelector)];
    [self setStandInDictionaryWithCapacityMethod:class_getInstanceMethod([self class], dictionaryWithCapacitySelector)];
    
    method_exchangeImplementations([self dictionaryWithCapacityMethod], [self standInDictionaryWithCapacityMethod]);
    
    [self setDictionaryWithDictionaryMethod:class_getClassMethod([NSMutableDictionary class], dictionaryWithDictionarySelector)];
    [self setStandInDictionaryWithDictionaryMethod:class_getInstanceMethod([self class], dictionaryWithDictionarySelector)];
    
    method_exchangeImplementations([self dictionaryWithDictionaryMethod], [self standInDictionaryWithDictionaryMethod]);
    
    testDataCacheImp = imp_implementationWithBlock((__bridge void *)[(^NSArray *() {
        return [NSArray arrayWithObjects:[self capacity], [self mutableDictionary], [self dictionary], nil];
    }) copy]);
    
    class_addMethod(nsMutableDictionaryMetaClass, @selector(testDataCache), testDataCacheImp, "");
}

- (NSArray *)testDataCache
{
    // never really called, but required to prep NSMutableDictionary
    return nil;
}

@end
