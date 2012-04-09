//
//  RequestManagerProtocol.h
//  SessionManager
//
//  Created by Lei Cai on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSMAccountInfo.h"

@class YSMSessionManager;
@protocol SessionManager;
@protocol LoginViewDelegate;

@protocol SessionManagerDelegate <NSObject>

- (void)sessionManagerDidSucceed:(id<SessionManager>)aSessionManager;
- (void)sessionManagerDidFail:(id<SessionManager>)aSessionManager withError:(NSError*)aError;

@end

@protocol SessionManager <NSObject>
@property (nonatomic, assign) id<SessionManagerDelegate> delegate;

@required
- (void)loginWithDelegate:(id<LoginViewDelegate>)loginDelegate username:(NSString*)aUsername andPassword:(NSString *)aPassword;
- (void)loginWithUsername:(NSString*)aUsername andPassword:(NSString *)aPassword;
- (void)logout;
@optional
- (void)login;
- (void)refresh;
- (YSMAccountInfo*)getAccountInfo;
- (BOOL)hasSession;
@end