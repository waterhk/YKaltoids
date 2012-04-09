//
//  AccountInfoRepositoryProtocol.h
//  SessionManager2
//
//  Created by Lei Cai on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSMAccountInfo.h"

@protocol AccountInfoRepository <NSObject>
@required
- (YSMAccountInfo*)currentAccount;
- (void)setAccountInfo:(YSMAccountInfo*)aAccountInfo;
- (BOOL)saveToRepository;
- (BOOL)restoreFromRepository;
@optional
- (void)clearRepository;
@end
