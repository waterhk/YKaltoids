//
//  RequestManager.h
//  SessionManager
//
//  Created by Lei Cai on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionManager.h"
#import "LoginServiceFactory.h"
#import "RefreshServiceFactory.h"
#import "AccountInfoRepositoryFactory.h"
#import "YSMAccountInfo.h"

@protocol LoginViewDelegate;

@interface YSMSessionManager : NSObject <SessionManager, LoginServiceDelegate, RefreshServiceDelegate> {
    id<AccountInfoRepositoryFactory> accountInfoRepositoryFactory_;
    id<LoginServiceFactory> loginServiceFactory_;
    id<RefreshServiceFactory> refreshServiceFactory_;
}

@property (nonatomic, strong) id<AccountInfoRepositoryFactory> accountInfoRepositoryFactory;
@property (nonatomic, strong) id<LoginServiceFactory> loginServiceFactory;
@property (nonatomic, strong) id<RefreshServiceFactory> refreshServiceFactory;

@property (nonatomic, strong, readonly) YSMAccountInfo* currentAccount;

@end
