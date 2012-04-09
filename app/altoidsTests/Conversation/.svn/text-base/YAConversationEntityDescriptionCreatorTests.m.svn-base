//
//  YAConversationEntityDescriptionCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <objc/runtime.h>
#import <CoreData/CoreData.h>
#import <OCMock/OCMock.h>
#import "YAConversationEntityDescriptionCreatorTests.h"
#import "YAConversationEntityDescriptionCreator.h"

@interface YAConversationEntityDescriptionCreatorTests()

@property (assign, nonatomic) Method entityDescriptionEntityForNameMethod;
@property (assign, nonatomic) Method standInEntityDescriptionEntityForNameMethod;
@property (strong, nonatomic) id entityDescriptionMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) YAConversationEntityDescriptionCreator *converationEntityDescriptionCreator;

- (NSEntityDescription *)entityForName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)context;
- (void)prepNSEntityDescription;
- (NSArray *)testDataCache;

@end

@implementation YAConversationEntityDescriptionCreatorTests

@synthesize entityDescriptionEntityForNameMethod = entityDescriptionEntityForNameMethod_;
@synthesize standInEntityDescriptionEntityForNameMethod = standInEntityDescriptionEntityForNameMethod_;
@synthesize entityDescriptionMock = entityDescriptionMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize converationEntityDescriptionCreator = converationEntityDescriptionCreator_;

- (void)setUp
{
    [super setUp];
    
    [self setEntityDescriptionMock:[OCMockObject mockForClass:[NSEntityDescription class]]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setConverationEntityDescriptionCreator:[[YAConversationEntityDescriptionCreator alloc] init]];
    
    [self prepNSEntityDescription];
}

- (void)tearDown
{
    method_exchangeImplementations([self standInEntityDescriptionEntityForNameMethod], [self entityDescriptionEntityForNameMethod]);
    
    [super tearDown];
}

- (void)testCreatesAndReturnsEntityDescriptionUsingCorrectEntityNameAndGivenManagedObjectContext
{
    id entityDescription = [[self converationEntityDescriptionCreator] conversationEntityDescriptionInManagedObjectContext:[self managedObjectContextMock]];
    
    STAssertEqualObjects([self entityDescriptionMock], entityDescription, @"Unexpected entity description");
}

- (NSEntityDescription *)entityForName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSArray *testData = [self testDataCache];
    NSManagedObjectContext *expectedContext = [testData objectAtIndex:0];
    
    STAssertTrue([entityName isEqualToString:@"Conversation"], @"Unexpected entity name");
    STAssertEqualObjects(expectedContext, context, @"Unexpected context");
    
    return [testData objectAtIndex:1];
}

- (void)prepNSEntityDescription
{
    Class nsEntityDescriptionClass = [NSEntityDescription class];
    Class nsEntityDescriptionMetaClass = objc_getMetaClass("NSEntityDescription");
    IMP testDataCacheImp = nil;
    SEL selector = @selector(entityForName:inManagedObjectContext:);

    [self setEntityDescriptionEntityForNameMethod:class_getClassMethod(nsEntityDescriptionClass, selector)];
    [self setStandInEntityDescriptionEntityForNameMethod:class_getInstanceMethod([self class], selector)];
    
    method_exchangeImplementations([self entityDescriptionEntityForNameMethod], [self standInEntityDescriptionEntityForNameMethod]);
    
    testDataCacheImp = imp_implementationWithBlock((__bridge void *)[(^NSArray *() {
        return [NSArray arrayWithObjects:[self managedObjectContextMock], [self entityDescriptionMock], nil];
    }) copy]);
    
    if (!class_getMethodImplementation(nsEntityDescriptionMetaClass, @selector(testDataCache))) 
    {
        class_addMethod(nsEntityDescriptionMetaClass, @selector(testDataCache), testDataCacheImp, "");
    }
    else
    {
        class_replaceMethod(nsEntityDescriptionMetaClass, @selector(testDataCache), testDataCacheImp, "");
    }
}

- (NSArray *)testDataCache 
{ 
    // never really called, but required to prep NSEntityDescription
    return nil;
}

@end
