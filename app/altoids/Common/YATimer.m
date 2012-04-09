//
//  YATimer.m
//  altoids
//
//  Created by Derrick Whittle on 2/18/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATimer.h"
#import "DateCreator.h"


@implementation YATimer
@synthesize dateCreator = dateCreator_,
            accumulators = accumulators_;


- (void) beginAccumulatingForTag:(NSString*)tag
{
    YATimeAccumulator* accumulator = [accumulators_ objectForKey:tag];
    if(!accumulator)
    {
        accumulator = [[YATimeAccumulator alloc] init];
        [accumulators_ setObject:accumulator forKey:tag];
    }
    else
    {
        NSAssert(![accumulator startDate], @"unexpected repeated begin for tag without interleaving stop; did you call stopAccumulatingForTag:?");
    }

    [accumulator setStartDate:[dateCreator_ dateForNow]];
}

- (void) stopAccumulatingForTag:(NSString*)tag
{
    NSDate* now = [dateCreator_ dateForNow];

    YATimeAccumulator* accumulator = [accumulators_ objectForKey:tag];
    NSAssert([accumulator startDate], @"expected accumulator for tag to have been started; did you call beginAccumulatingForTag:?");

    [accumulator setAccumulatedSeconds:[accumulator accumulatedSeconds] + [now timeIntervalSinceDate:[accumulator startDate]]];
    [accumulator setStartDate:nil];
}

- (NSTimeInterval) accumulatedSecondsForTag:(NSString*)tag
{
    YATimeAccumulator* accumulator = [accumulators_ objectForKey:tag];
    NSAssert(accumulator, @"expected accumulator for tag; did you call beginAccumulatingForTag:?");

    NSDate* runningStartDate = [accumulator startDate];
    if(runningStartDate)
    {
        NSDate* now = [dateCreator_ dateForNow];
        return [accumulator accumulatedSeconds] + [now timeIntervalSinceDate:runningStartDate];
    }
    
    return [accumulator accumulatedSeconds];
}

- (NSString*) descriptionOfAccumulatedSecondsForAllTags
{
    return [accumulators_ description];
}


@end


@implementation YATimeAccumulator
@synthesize startDate, accumulatedSeconds;

- (NSString*) description
{
    return [[NSNumber numberWithDouble:accumulatedSeconds] description];
}

@end
