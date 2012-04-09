//
//  YAArraySplitter.m
//  altoids
//
//  Created by Jon Herron on 12/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAArraySplitter.h"

// Private class extension
@interface YAArraySplitter ()

// @property definitions

// methods

@end

@implementation YAArraySplitter

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize mutableArrayCreator = mutableArrayCreator_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark ArraySplitter delegate methods

- (NSArray *)splitArray:(NSArray *)theArray intoGroupsOfSize:(NSUInteger)theGroupSize
{
    NSUInteger arraySize = [theArray count];
    
    if (theGroupSize < 1)
    {
        return nil;
    }
    
    if (arraySize <= theGroupSize) 
    {
        return [NSArray arrayWithObject:theArray];
    }
    
    NSArray *segment;
    NSRange segmentRange;
    NSUInteger capacity = arraySize / theGroupSize + 1;
    NSUInteger currentGroup = 0;
    NSUInteger offset = 0;
    NSUInteger segmentLocation;
    NSUInteger segmentLength;
    NSUInteger segmentEnd;
    NSMutableArray *splitArrays = [[self mutableArrayCreator] mutableArrayWithCapacity:capacity];
    
    while (offset < arraySize) 
    {
        segmentLocation = currentGroup * theGroupSize;
        segmentLength = theGroupSize;
        segmentEnd = segmentLocation + segmentLength;
        
        if (segmentEnd > arraySize) 
        {
            segmentLength = arraySize - segmentLocation;
            segmentEnd = arraySize;
        }
        
        segmentRange = NSMakeRange(segmentLocation, segmentLength);
        segment = [theArray subarrayWithRange:segmentRange];
        
        [splitArrays addObject:segment];
        
        offset = segmentEnd;
        ++currentGroup;
    }
    
    return splitArrays;
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAArraySplitter ()

@end
