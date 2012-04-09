//
//  LoginServiceFactory.m
//  SessionManager4
//
//  Created by Lei Cai on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMLoginServiceFactory.h"
#import "YSMLoginService.h"

@implementation YSMLoginServiceFactory
@synthesize tokenRequesterFactory = tokenRequesterFactory_;
@synthesize cookieCrumbRequesterFactory = cookieCrumbRequesterFactory_;

- (id<LoginService>)createWithLoginServiceDelegate:(id<LoginServiceDelegate>)aLoginServiceDelegate
{
    return [[YSMLoginService alloc] initWithTokenRequesterFactory:[self tokenRequesterFactory] 
                                      cookieCrumbRequesterFactory:[self cookieCrumbRequesterFactory]
                                                         delegate:aLoginServiceDelegate];
}

@end
