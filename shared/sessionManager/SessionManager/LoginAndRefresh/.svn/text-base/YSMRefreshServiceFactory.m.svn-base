//
//  RefreshServiceFactory.m
//  SessionManager4
//
//  Created by Lei Cai on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMRefreshServiceFactory.h"
#import "YSMRefreshService.h"

@implementation YSMRefreshServiceFactory
@synthesize cookieCrumbRequesterFactory = cookieCrumbRequesterFactory_;

- (id<RefreshService>)createWithRefreshServiceDelegate:(id<RefreshServiceDelegate>)aRefreshServiceDelegate
{
    YSMRefreshService *refreshService = [[YSMRefreshService alloc] initWithCookieCrumbRequesterFactory:[self cookieCrumbRequesterFactory]];
    refreshService.delegate = aRefreshServiceDelegate;
    return refreshService;
}

@end
