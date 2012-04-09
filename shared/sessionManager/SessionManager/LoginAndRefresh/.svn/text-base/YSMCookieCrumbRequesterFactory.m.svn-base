//
//  CookieCrumbRequesterFactory.m
//  SessionManager4
//
//  Created by Lei Cai on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMCookieCrumbRequesterFactory.h"
#import "YSMCookieCrumbRequester.h"

@implementation YSMCookieCrumbRequesterFactory
@synthesize connectionWrapperFactory = connectionWrapperFactory_;
@synthesize errorDescriptionGenerator = errorDescriptionGenerator_;

- (id<CookieCrumbRequester>)createWithCookieCrumbRequesterDelegate:(id<CookieCrumbRequesterDelegate>)aCookieCrumbRequesterDelegate
{
    YSMCookieCrumbRequester *cookieCrumbRequester = [[YSMCookieCrumbRequester alloc] initWithConnectionWrapperFactory:[self connectionWrapperFactory] errorDescriptionGenerator:[self errorDescriptionGenerator]];
    cookieCrumbRequester.delegate = aCookieCrumbRequesterDelegate;
    return cookieCrumbRequester;
}

@end
