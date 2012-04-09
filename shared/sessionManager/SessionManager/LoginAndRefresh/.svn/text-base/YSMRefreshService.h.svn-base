//
//  RefreshService.h
//  SessionManager4
//
//  Created by Lei Cai on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RefreshService.h"
#import "CookieCrumbRequesterFactory.h"

@interface YSMRefreshService : NSObject <RefreshService, CookieCrumbRequesterDelegate> {
    id<CookieCrumbRequesterFactory> cookieCrumbRequesterFactory_;
    NSString *currentUsername_;
    
    id<CookieCrumbRequester> cookieCrumbRequester;
}

@property (nonatomic, assign) id<RefreshServiceDelegate> delegate;
@property (nonatomic, copy) NSString *currentUsername;

- (id)initWithCookieCrumbRequesterFactory:(id<CookieCrumbRequesterFactory>)cookieCrumbRequesterFactory;

@end
