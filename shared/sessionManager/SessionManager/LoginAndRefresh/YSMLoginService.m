//
//  LoginService.m
//  SessionManager4
//
//  Created by Lei Cai on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMLoginService.h"

@implementation YSMLoginService

@synthesize delegate = delegate_;
@synthesize currentUsername = currentUsername_;
@synthesize tokenRequester = tokenRequester_;
@synthesize cookieCrumbRequester = cookieCrumbRequester_;

- (id)initWithTokenRequesterFactory:(id<TokenRequesterFactory>)tokenRequesterFactory
     cookieCrumbRequesterFactory:(id<CookieCrumbRequesterFactory>)cookieCrumbRequesterFactory
                           delegate:(id<LoginServiceDelegate>)theDelegate
{
    self = [super init];
    if (self) {
        // Initialization code here.
        tokenRequesterFactory_ = tokenRequesterFactory;
        cookieCrumbRequesterFactory_ = cookieCrumbRequesterFactory;
        delegate_ = theDelegate;
    }
    
    return self;
}

- (void)loginWithUsername:(NSString*)aUsername andPassword:(NSString*)aPassword
{
    [self setCurrentUsername:aUsername];
    [self setTokenRequester:[tokenRequesterFactory_ createWithTokenRequesterDelegate:self]];
    [[self tokenRequester] requestTokenWithUsername:aUsername andPassword:aPassword];
}


- (void)tokenRequester:(id<TokenRequester>)aTokenRequester didSucceedWithToken:(NSString*)aToken
{
    [self setCookieCrumbRequester:[cookieCrumbRequesterFactory_ createWithCookieCrumbRequesterDelegate:self]];
    [[self cookieCrumbRequester] requestCookieCrumbWithToken:aToken];
}

- (void)tokenRequester:(id<TokenRequester>)aTokenRequester didFailWithError:(NSError*)aError
{
    [[self delegate] loginService:self didFailWithError:aError];
}

- (void)cookieCrumbRequester:(id<CookieCrumbRequester>)aCookieCrumbRequester
       didSucceedWithYCookie:(NSString*)aYCookie
                  andTCookie:(NSString*)aTCookie
                    andCrumb:(NSString*)aCrumb
           andExpirationDate:(NSDate*)aExpirationDate
{
    YSMAccountInfo *accountInfo = [[YSMAccountInfo alloc] init];
    [accountInfo setUserID:[self currentUsername]];
    [accountInfo setYCookie:aYCookie];
    [accountInfo setTCookie:aTCookie];
    [accountInfo setCrumb:aCrumb];
    [accountInfo setExpirationDate:aExpirationDate];
    
    [[self delegate] loginService:self didSucceedWithAccount:accountInfo];
}

- (void)cookieCrumbRequester:(id<CookieCrumbRequester>)aCookieCrumbRequester didFailWithError:(NSError*)aError
{
    [[self delegate] loginService:self didFailWithError:aError];
}

@end
