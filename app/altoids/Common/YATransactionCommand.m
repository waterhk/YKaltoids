//
//  YATransactionCommand.m
//  altoids
//
//  Created by Derrick Whittle on 3/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATransactionCommand.h"
#import "TransactionCommandDelegate.h"
#import "CommandErrorCreator.h"

@implementation YATransactionCommand

@synthesize commandErrorCreator = commandErrorCreator_,
            command = command_,
            delegate = delegate_;


- (id) initWithCommand:(id<Command>)command delegate:(id<TransactionCommandDelegate>)delegate
{
    NSAssert(command, @"Need an underlying command to execute.");

    self = [super init];
    if(self)
    {
        command_ = command;
        delegate_ = delegate;
    }
    return self;
}

- (NSError*) execute
{
    NSError* error = nil;

    @try
    {
        error = [command_ execute];
    }
    @catch(id exception)
    {
        error = [commandErrorCreator_ errorWithCode:YACommandErrorCodeException underlyingError:error];
    }
    @finally
    {
        @try
        {
            if(!error)
            {
                [delegate_ commandTransactionDidSucceed:self];
            }
            else
            {
                [delegate_ commandTransaction:self didFailWithError:error];
            }
        }
        @finally
        {
            // prevent a reference cycle between the command and its transaction delegate;
            // the nested finally clauses here ensure we break this cycle whether there's an exception executing, creating an error object, or while notifying the delegate
            delegate_ = nil;
        }
    }

    return error;
}

- (id<CommandTransaction>) transaction
{
    return self;    // we might as well use ourself as the transaction token, but we do so with a protocol that doesn't expose any methods
}

@end
