//
//  LoginServiceFactory.h
//  SessionManager4
//
//  Created by Lei Cai on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginServiceFactory.h"
#import "TokenRequesterFactory.h"
#import "CookieCrumbRequesterFactory.h"

@interface YSMLoginServiceFactory : NSObject <LoginServiceFactory> {
}
@property (nonatomic, strong) id<TokenRequesterFactory> tokenRequesterFactory;
@property (nonatomic, strong) id<CookieCrumbRequesterFactory> cookieCrumbRequesterFactory;

@end
