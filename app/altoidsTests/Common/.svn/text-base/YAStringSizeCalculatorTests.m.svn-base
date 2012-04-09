//
//  YAStringSizeCalculatorTests.m
//  altoids
//
//  Created by Jon Herron on 10/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAStringSizeCalculatorTests.h"
#import "YAStringSizeCalculator.h"

@interface YAStringSizeCalculatorTests()

@property (strong, nonatomic) id stringMock;
@property (strong, nonatomic) id uiFontMock;
@property (strong, nonatomic) YAStringSizeCalculator *stringSizeCalculator;

@end

@implementation YAStringSizeCalculatorTests

@synthesize stringMock = stringMock_;
@synthesize uiFontMock = uiFontMock_;
@synthesize stringSizeCalculator = stringSizeCalculator;

- (void)setUp
{
    [self setStringMock:[OCMockObject mockForClass:[NSString class]]];
    [self setUiFontMock:[OCMockObject mockForClass:[UIFont class]]];
    [self setStringSizeCalculator:[[YAStringSizeCalculator alloc] init]];
}

- (void)testCanCalculateStringSizeBasedOnGivenFont
{
    CGSize expectedSize = CGSizeMake(100, 200);
    CGSize size;
    
    [[[[self stringMock] expect] andReturnValue:OCMOCK_VALUE(expectedSize)] sizeWithFont:[self uiFontMock]];
    
    size = [[self stringSizeCalculator] sizeOfString:[self stringMock] withFont:[self uiFontMock]];
    
    STAssertTrue(expectedSize.width == size.width && expectedSize.height == size.height, @"Unexpected size");
    
    [[self uiFontMock] verify];
    [[self stringMock] verify];
}

@end
