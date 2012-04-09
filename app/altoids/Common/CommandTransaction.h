//
//  CommandTransaction.h
//  altoids
//
//  Created by Derrick Whittle on 3/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>


// CommandTransaction serves ONLY to identify a particular transaction;
// the only valid things to do with a CommandTransaction are to store references and
// test for equality with another CommandTransaction.
//
// See docs/design/Command_Transactions.md

@protocol CommandTransaction <NSObject>

// this page intentionally blank

@end
