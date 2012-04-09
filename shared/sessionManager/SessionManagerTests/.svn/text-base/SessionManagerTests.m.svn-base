//
//  SessionManager4Tests.m
//  SessionManager4Tests
//
//  Created by Lei Cai on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SessionManagerTests.h"

#import "YSMErrorDescriptionGenerator.h"
#import "YSMConnectionWrapperFactory.h"
#import "YSMCookieCrumbRequesterFactory.h"
#import "YSMTokenRequesterFactory.h"
#import "YSMLoginServiceFactory.h"
#import "YSMAccountInfoRepositoryFactory.h"
#import "YSMSessionManager.h"
#import "YSMRefreshServiceFactory.h"

@implementation SessionManagerTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    id<ErrorDescriptionGenerator> smErrorDescriptionGenerator = [[YSMErrorDescriptionGenerator alloc] init];
    id<ConnectionWrapperFactory> connectionWrapperFactory = [[YSMConnectionWrapperFactory alloc] init];
    
    
    id<CookieCrumbRequesterFactory> cookieCrumbRequesterFactory = [[YSMCookieCrumbRequesterFactory alloc] initWithConnectionWrapperFactory:connectionWrapperFactory errorDescriptionGenerator:smErrorDescriptionGenerator];
    
    id<TokenRequesterFactory> tokenRequesterFactory = [[YSMTokenRequesterFactory alloc] initWithConnectionWrapperFactory:connectionWrapperFactory 
                                                                                               errorDescriptionGenerator:smErrorDescriptionGenerator];
    
    id<LoginServiceFactory> loginServiceFactory = [[YSMLoginServiceFactory alloc] initWithTokenRequesterFactory:tokenRequesterFactory cookieCrumbRequesterFactory:cookieCrumbRequesterFactory];
    
    id<AccountInfoRepositoryFactory> accountInfoRepositoryFactory = [[YSMAccountInfoRepositoryFactory alloc] initWithRepositoryTypes:RepoWithFilesystem];
    
    id<RefreshServiceFactory> refreshServiceFactory = [[YSMRefreshServiceFactory alloc] initWithCookieCrumbRequesterFactory:cookieCrumbRequesterFactory];
    
    id<SessionManager> sessionManager = [[YSMSessionManager alloc] initWithAccountInfoRepositoryFactory:accountInfoRepositoryFactory loginServiceFactory:loginServiceFactory refreshServiceFactory:refreshServiceFactory];
    
    [sessionManager login];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:60]];
}

@end
