//
//  YAPredicateCreator.m
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAPredicateCreator.h"
#import "MutableArrayCreator.h"

@implementation YAPredicateCreator

@synthesize mutableArrayCreator = mutableArrayCreator_;

- (NSPredicate *)predicateMatchingAddressMetaDataWithHandle:(NSString *)handle
{
    if (!handle) 
    {
        return nil;
    }
    
    return [NSPredicate predicateWithFormat:@"handle == %@", handle];
}

- (NSPredicate *)predicateMatchingAddressMetaDatasWithHandles:(NSArray *)handles
{
    if (!handles) 
    {
        return nil;
    }
    
    NSMutableArray *subPredicates = [[self mutableArrayCreator] mutableArrayWithCapacity:[handles count]];
    
    for (NSString *handle in handles) 
    {
        NSPredicate *subPredicate = [self predicateMatchingAddressMetaDataWithHandle:handle];
        
        if (subPredicate) 
        {
            [subPredicates addObject:subPredicate];
        }
    }
    
    return [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
}

@end
