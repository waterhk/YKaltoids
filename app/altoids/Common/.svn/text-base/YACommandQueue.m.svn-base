//
//  YACommandQueue.m
//  altoids
//
//  Created by Derrick Whittle on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YACommandQueue.h"
#import "OperationCreator.h"

@implementation YACommandQueue

@synthesize operationCreator = operationCreator_,
            operationQueue = operationQueue_;


- (id) initWithOperationQueue:(NSOperationQueue*)operationQueue maxConcurrentOperationCount:(NSInteger)count
{
    self = [super init];
    if(self)
    {
        [operationQueue setMaxConcurrentOperationCount:count];
        operationQueue_ = operationQueue;
    }
    return self;
}

- (void) append:(id<Command>)command
{
    [operationQueue_ addOperation:[operationCreator_ createOperationWithCommand:command]];
}

- (NSUInteger)count
{
    return [operationQueue_ operationCount];
}

@end
