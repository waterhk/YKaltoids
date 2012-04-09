//
//  TransactionCommand.h
//  altoids
//
//  Created by Derrick Whittle on 3/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
@protocol CommandTransaction;


// See docs/design/Command_Transactions.md

@protocol TransactionCommand <Command>

@property (nonatomic, readonly) id<CommandTransaction> transaction;

@end
