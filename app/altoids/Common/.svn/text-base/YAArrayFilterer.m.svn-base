
//
//  YAArrayFilterer.m
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAArrayFilterer.h"
#import "MutableArrayCreator.h"

@implementation YAArrayFilterer

@synthesize mutableArrayCreator = mutableArrayCreator_;

- (NSArray *)filterArray:(NSArray *)theArray usingPredicate:(NSPredicate *)thePredicate
{
    return [theArray filteredArrayUsingPredicate:thePredicate];
}

- (NSArray*) arrayFromArray:(NSArray*)array excludingObjectsInSet:(NSSet*)set
{
    // does Cocoa not already have somethign to this?
    // I didn't see anything obvious for it in NSArray or NSSet, or how to accomplish it with an NSPredicate

    if(![set count])
    {
        return [array copy];
    }
    
    NSMutableArray* complement = [mutableArrayCreator_ mutableArrayWithCapacity:[array count]];
    for(id object in array)
    {
        if(![set containsObject:object])
        {
            [complement addObject:object];
        }
    }
    return complement;
}

@end
