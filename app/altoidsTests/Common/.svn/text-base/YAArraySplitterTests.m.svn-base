//
//  YAArraySplitterTests.m
//  altoids
//
//  Created by Jon Herron on 12/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAArraySplitterTests.h"
#import "YAMutableArrayCreator.h"
#import "YAArraySplitter.h"

@interface YAArraySplitterTests()

@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;
@property (strong, nonatomic) YAArraySplitter *arraySplitter;

- (NSArray *)arrayWithNumberOfItems:(NSUInteger)theNumberOfItems;
- (void)validateArray:(NSArray *)theArray withRange:(NSRange)theRange;

@end

@implementation YAArraySplitterTests

@synthesize mutableArrayCreator = mutableArrayCreator_;
@synthesize arraySplitter = arraySplitter_;

- (void)setUp
{
    [self setMutableArrayCreator:[[YAMutableArrayCreator alloc] init]];
    [self setArraySplitter:[[YAArraySplitter alloc] initWithMutableArrayCreator:[self mutableArrayCreator]]];
}

- (void)testIfGroupSizeIsLessThanOneNilIsReturned
{
    STAssertNil([[self arraySplitter] splitArray:[self arrayWithNumberOfItems:12] intoGroupsOfSize:0], @"Expected nil return");
}

- (void)testIfArrayCountIsLessThenOrEqualToGroupSizeOriginalArrayIsReturned
{
    NSArray *array = [self arrayWithNumberOfItems:8];
    
    STAssertEqualObjects(array, [[self arraySplitter] splitArray:array intoGroupsOfSize:10], @"Expected original array");
    
    STAssertEqualObjects(array, [[self arraySplitter] splitArray:array intoGroupsOfSize:8], @"Expected original array");
}

- (void)testWillSplitArrayIntoGroupsOfUpToGroupSize
{
    NSArray *array = [self arrayWithNumberOfItems:30];
    NSArray *splitArray;
    NSUInteger expectedSplitArrayCount = 3;
    NSRange expectedSegment1Range = NSMakeRange(0, 9);
    NSRange expectedSegment2Range = NSMakeRange(10, 19);
    NSRange expectedSegment3Range = NSMakeRange(20, 29);
    
    splitArray = [[self arraySplitter] splitArray:array intoGroupsOfSize:10];
    
    STAssertEquals(expectedSplitArrayCount, [splitArray count], @"Expected 3 items in the split array");
    
    [self validateArray:[splitArray objectAtIndex:0] withRange:expectedSegment1Range]; 
    [self validateArray:[splitArray objectAtIndex:1] withRange:expectedSegment2Range]; 
    [self validateArray:[splitArray objectAtIndex:2] withRange:expectedSegment3Range];
}

- (void)testIfArraySizeDoesNotDivideEvenlyByGroupSizeLastGroupWillHaveLessThenGroupSizeItems
{
    NSArray *array = [self arrayWithNumberOfItems:23];
    NSArray *splitArray;
    NSUInteger expectedSplitArrayCount = 3;
    NSRange expectedSegment1Range = NSMakeRange(0, 9);
    NSRange expectedSegment2Range = NSMakeRange(10, 19);
    NSRange expectedSegment3Range = NSMakeRange(20, 22);
    
    splitArray = [[self arraySplitter] splitArray:array intoGroupsOfSize:10];
    
    STAssertEquals(expectedSplitArrayCount, [splitArray count], @"Expected 3 items in the split array");
    
    [self validateArray:[splitArray objectAtIndex:0] withRange:expectedSegment1Range]; 
    [self validateArray:[splitArray objectAtIndex:1] withRange:expectedSegment2Range]; 
    [self validateArray:[splitArray objectAtIndex:2] withRange:expectedSegment3Range];
}

- (void)testIsAbleToSplitArrayIntoGroupsOfSizeOtherThanTen
{
    NSArray *array = [self arrayWithNumberOfItems:8];
    NSArray *splitArray;
    NSUInteger expectedSplitArrayCount = 2;
    NSRange expectedSegment1Range = NSMakeRange(0, 3);
    NSRange expectedSegment2Range = NSMakeRange(4, 7);
    
    splitArray = [[self arraySplitter] splitArray:array intoGroupsOfSize:4];
    
    STAssertEquals(expectedSplitArrayCount, [splitArray count], @"Expected 2 items in the split array");
    
    [self validateArray:[splitArray objectAtIndex:0] withRange:expectedSegment1Range]; 
    [self validateArray:[splitArray objectAtIndex:1] withRange:expectedSegment2Range]; 
}

- (NSArray *)arrayWithNumberOfItems:(NSUInteger)theNumberOfItems
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:theNumberOfItems];
    
    for (int i = 0; i < theNumberOfItems; ++i) 
    {
        [array addObject:[NSNumber numberWithInt:i]];
    }
    
    return array;
}

- (void)validateArray:(NSArray *)theArray withRange:(NSRange)theRange
{
    NSUInteger arraySize = [theArray count];
    NSUInteger arrayValue;
    NSUInteger rangeSize = (theRange.length - theRange.location) + 1;
    
    for (int i = 0; i < rangeSize; ++i) 
    {
        arrayValue = [[theArray objectAtIndex:i] intValue];
        
        STAssertEquals(arrayValue, theRange.location + i, @"Unexpected array value");
    }
    
    STAssertEquals(arraySize, rangeSize, @"Unexpected array size");
}

@end
