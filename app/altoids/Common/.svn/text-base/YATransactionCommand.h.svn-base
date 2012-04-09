//
//  YATransactionCommand.h
//  altoids
//
//  Created by Derrick Whittle on 3/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionCommand.h"
#import "CommandTransaction.h"
@protocol TransactionCommandDelegate, CommandErrorCreator;


@interface YATransactionCommand : NSObject <TransactionCommand, CommandTransaction>

// injected dependencies
@property (nonatomic, strong) id<CommandErrorCreator> commandErrorCreator;

// operational parameters
@property (nonatomic, strong) id<Command> command;
// We can hold a strong reference to the transaction delegate because the transaction has a closed lifecycle:
// The transaction will always complete, at which point we release the delegate, avoiding a leak.
@property (nonatomic, strong) id<TransactionCommandDelegate> delegate;

- (id) initWithCommand:(id<Command>)command delegate:(id<TransactionCommandDelegate>)delegate;

@end
