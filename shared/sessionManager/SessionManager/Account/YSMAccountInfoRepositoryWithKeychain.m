//
//  AccountInfoRepositoryWithKeychain.m
//  SessionManager3
//
//  Created by Lei Cai on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMAccountInfoRepositoryWithKeychain.h"

@implementation YSMAccountInfoRepositoryWithKeychain

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (YSMAccountInfo*)currentAccount
{
    return nil;
}

// TBD, 
// if we need to store the username, cookie in keychain, we need to provide these methods
- (void)setAccountInfo:(YSMAccountInfo*)aAccountInfo
{
}

- (BOOL)saveToRepository
{
    return NO;
}

- (BOOL)restoreFromRepository
{
    return NO;
}

- (void)clearRepository
{
}

@end
