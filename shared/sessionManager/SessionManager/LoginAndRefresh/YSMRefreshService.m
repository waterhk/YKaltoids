//
//  RefreshService.m
//  SessionManager4
//
//  Created by Lei Cai on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMRefreshService.h"

@implementation YSMRefreshService

- (id)initWithCookieCrumbRequesterFactory:(id<CookieCrumbRequesterFactory>)cookieCrumbRequesterFactory
{
    self = [super init];
    if (self) {
        // Initialization code here.
        cookieCrumbRequesterFactory_ = cookieCrumbRequesterFactory;
    }
    
    return self;
}

- (void)refreshCookiesForUser:(NSString*)aUsername usingToken:(NSString*)aToken
{
    self.currentUsername = aUsername;
    cookieCrumbRequester = [cookieCrumbRequesterFactory_ createWithCookieCrumbRequesterDelegate:self];
    //id<CookieCrumbRequesterProtocol> cookieCrumbRequester = [cookieCrumbRequesterFactory_ createWithCookieCrumbRequesterDelegate:self];
    [cookieCrumbRequester requestCookieCrumbWithToken:aToken];
}

- (void)cookieCrumbRequester:(id<CookieCrumbRequester>)aCookieCrumbRequester
       didSucceedWithYCookie:(NSString*)aYCookie
                  andTCookie:(NSString*)aTCookie
                    andCrumb:(NSString*)aCrumb
           andExpirationDate:(NSDate*)aExpirationDate
{
    YSMAccountInfo *accountInfo = [[YSMAccountInfo alloc] init];
    accountInfo.userID = self.currentUsername;
    accountInfo.yCookie = aYCookie;
    accountInfo.tCookie = aTCookie;
    accountInfo.crumb = aCrumb;
    accountInfo.expirationDate = aExpirationDate;
    [self.delegate refreshService:self didSucceedWithAccount:accountInfo];
}

- (void)cookieCrumbRequester:(id<CookieCrumbRequester>)aCookieCrumbRequester didFailWithError:(NSError*)aError
{
    [self.delegate refreshService:self didFailWithError:aError];
}

@synthesize delegate = delegate_;
@synthesize currentUsername = currentUsername_;
@end
