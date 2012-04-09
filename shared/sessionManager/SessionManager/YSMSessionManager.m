//
//  RequestManager.m
//  SessionManager
//
//  Created by Lei Cai on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMSessionManager.h"
#import "AccountInfoRepository.h"
#import "LoginViewDelegate.h"

@interface YSMSessionManager() {
}

@property (nonatomic, strong) YSMAccountInfo* currentAccount;

@property (nonatomic, strong) id<LoginService> loginService;
@property (nonatomic, strong) id<RefreshService> refreshService;

@property (assign, nonatomic, getter = isBusy) BOOL busy;

@property (assign, nonatomic) id<LoginViewDelegate> loginDelegate;

@end

@implementation YSMSessionManager
@synthesize delegate = delegate_;
@synthesize currentAccount = currentAccount_;
@synthesize accountInfoRepositoryFactory = accountInfoRepositoryFactory_;
@synthesize loginServiceFactory = loginServiceFactory_;
@synthesize refreshServiceFactory = refreshServiceFactory_;

@synthesize loginService = loginService_;
@synthesize refreshService = refreshService_;

@synthesize busy = busy_;

@synthesize loginDelegate = loginDelegate_;

#pragma mark -
#pragma mark SessionManager Protocol

- (void)loginWithDelegate:(id<LoginViewDelegate>)theLoginDelegate username:(NSString*)aUsername andPassword:(NSString *)aPassword
{
    loginDelegate_ = theLoginDelegate;    
    [self loginWithUsername:aUsername andPassword:aPassword];
}

- (void)loginWithUsername:(NSString*)aUsername andPassword:(NSString *)aPassword
{
    if ([self isBusy]) {
        return;
    }
    
    [[self loginDelegate] loginDidBegin];
    
    self.loginService = [self.loginServiceFactory createWithLoginServiceDelegate:self];
    [self.loginService loginWithUsername:aUsername andPassword:aPassword];
    [self setBusy:YES];
}

- (void)login
{
    //LoginService *loginService;
    self.loginService = [self.loginServiceFactory createWithLoginServiceDelegate:self];
    [self.loginService loginWithUsername:@"cailei_flickrtest01" andPassword:@"agileapps"];
}

- (void)logout
{
    //AccountInfoRepositoryWithFilesystem *accountInfoRepository;
    id<AccountInfoRepository> accountInfoRepository;
    accountInfoRepository = [self.accountInfoRepositoryFactory create];
    [accountInfoRepository clearRepository];
    self.currentAccount = nil;
}

- (void)refresh

{
    if ((!self.currentAccount) || (!self.currentAccount.token)) return;

    self.refreshService = [self.refreshServiceFactory createWithRefreshServiceDelegate:self];
    [self.refreshService refreshCookiesForUser:self.currentAccount.userID usingToken:self.currentAccount.token];
}

#pragma mark -
#pragma mark LoginServiceDelegate

- (void)loginService:(id<LoginService>)aLoginService didSucceedWithAccount:(YSMAccountInfo*)aAccountInfo
{
    [self setBusy:NO];
    self.currentAccount = aAccountInfo;
    id<AccountInfoRepository> accountInfoRepository = [self.accountInfoRepositoryFactory create];
    [accountInfoRepository setAccountInfo:aAccountInfo];
    [accountInfoRepository saveToRepository];
    [self.delegate sessionManagerDidSucceed:self];
    [[self loginDelegate] loginDidEnd];
}

- (void)loginService:(id<LoginService>)aLoginService didFailWithError:(NSError*)aError
{
    [self setBusy:NO];
    [self.delegate sessionManagerDidFail:self withError:aError];
    [[self loginDelegate] loginDidEnd];
}

#pragma mark -
#pragma mark RefreshServiceDelegate

- (void)refreshService:(id<RefreshService>)aRefreshService didSucceedWithAccount:(YSMAccountInfo*)aAccountInfo
{
    self.currentAccount = aAccountInfo;
    id<AccountInfoRepository> accountInfoRepository = [self.accountInfoRepositoryFactory create];
    [accountInfoRepository setAccountInfo:aAccountInfo];
    [accountInfoRepository saveToRepository];
    [self.delegate sessionManagerDidSucceed:self];
}

- (void)refreshService:(id<RefreshService>)aRefreshService didFailWithError:(NSError*)aError
{
    [self.delegate sessionManagerDidFail:self withError:aError];
}

#pragma mark -
// return nil if not login yet
- (YSMAccountInfo*)getAccountInfo
{
    return self.currentAccount;
}

- (BOOL)hasSession
{
    id<AccountInfoRepository> accountInfoRepository = [self.accountInfoRepositoryFactory create];
    BOOL hasAccountInfo = [accountInfoRepository restoreFromRepository];
    
    if (hasAccountInfo) {
        [self setCurrentAccount:[accountInfoRepository currentAccount]];
    }
    
    return hasAccountInfo;
}

@end
