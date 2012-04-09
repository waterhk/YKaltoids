//
//  YACompositeCommand.m
//  altoids
//
//  Created by Jon Herron on 1/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YACompositeCommand.h"

@interface YACompositeCommand ()

@property (strong, nonatomic) NSArray *commands;

@end

@implementation YACompositeCommand

@synthesize commands = commands_;

- (id)initWithCommands:(NSArray *)theCommands
{
    self = [super init];
    
    if (self) 
    {
        commands_ = theCommands;
    }
    
    return self;
}

- (NSError*)execute
{
    for (id<Command> command in [self commands]) 
    {
        NSError* error = [command execute];
        if(error)
        {
            return error;
        }
    }
    
    return nil;
}

@end
