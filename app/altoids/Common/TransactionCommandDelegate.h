//
//  TransactionCommandDelegate.h
//  altoids
//
//  Created by Derrick Whittle on 3/21/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol CommandTransaction;


@protocol TransactionCommandDelegate <NSObject>

- (void) commandTransactionDidSucceed:(id<CommandTransaction>)commandTransaction;
- (void) commandTransaction:(id<CommandTransaction>)commandTransaction didFailWithError:(NSError*)error;

@end
