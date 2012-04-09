//
//  YASetFilterer.m
//  altoids
//
//  Created by Derrick Whittle on 3/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YASetFilterer.h"
#import "MutableSetCreator.h"

@implementation YASetFilterer

@synthesize mutableSetCreator = mutableSetCreator_;


- (NSSet*) setFromSet:(NSSet*)set filteredWithPredicate:(NSPredicate*)predicate
{
    NSMutableSet* filteredSet = [mutableSetCreator_ mutableSetWithCapacity:[set count]];

    for(id object in set)
    {
        if([predicate evaluateWithObject:object])
        {
            [filteredSet addObject:object];
        }
    }
    
    return filteredSet;
}

@end
