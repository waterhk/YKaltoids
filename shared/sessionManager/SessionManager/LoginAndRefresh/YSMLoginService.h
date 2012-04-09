//
//  LoginService.h
//  SessionManager4
//
//  Created by Lei Cai on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginService.h"
#import "TokenRequesterFactory.h"
#import "CookieCrumbRequesterFactory.h"

@interface YSMLoginService : NSObject <LoginService, TokenRequesterDelegate, CookieCrumbRequesterDelegate> {
    id<TokenRequesterFactory> tokenRequesterFactory_;
    id<CookieCrumbRequesterFactory> cookieCrumbRequesterFactory_;
    NSString *currentUsername_;
    
    id<TokenRequester> tokenRequester;
    id<CookieCrumbRequester> cookieCrumbRequester;
}

@property (nonatomic, assign) id<LoginServiceDelegate> delegate;
@property (nonatomic, copy) NSString *currentUsername;
@property (nonatomic, strong) id<TokenRequester> tokenRequester;
@property (nonatomic, strong) id<CookieCrumbRequester> cookieCrumbRequester;

- (id)initWithTokenRequesterFactory:(id<TokenRequesterFactory>)tokenRequesterFactory
     cookieCrumbRequesterFactory:(id<CookieCrumbRequesterFactory>)cookieCrumbRequesterFactory
                           delegate:(id<LoginServiceDelegate>)theDelegate;

@end
