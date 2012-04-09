//
//  YATestThrowingCommand.m
//  altoids
//
//  Created by Derrick Whittle on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestThrowingCommand.h"

@implementation YATestThrowingCommand

@synthesize threw;


- (NSError*) execute
{
    threw = YES;
    [NSException raise:@"some exception" format:@"with some details"];
    return nil;
}

@end
