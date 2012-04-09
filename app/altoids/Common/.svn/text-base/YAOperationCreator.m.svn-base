//
//  YAOperationCreator.m
//  altoids
//
//  Created by Derrick Whittle on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAOperationCreator.h"
#import "Command.h"

@implementation YAOperationCreator

- (NSOperation*) createOperationWithCommand:(id<Command>)command
{
    return [[NSInvocationOperation alloc] initWithTarget:command selector:@selector(execute) object:nil];
}

@end
