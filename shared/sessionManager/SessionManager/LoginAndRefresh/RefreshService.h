//
//  RefreshServiceProtocol.h
//  SessionManager4
//
//  Created by Lei Cai on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSMAccountInfo.h"

@protocol RefreshService <NSObject>
- (void)refreshCookiesForUser:(NSString*)aUsername usingToken:(NSString*)aToken;
@end

@protocol RefreshServiceDelegate <NSObject>
- (void)refreshService:(id<RefreshService>)aRefreshService didSucceedWithAccount:(YSMAccountInfo*)aAccountInfo;
- (void)refreshService:(id<RefreshService>)aRefreshService didFailWithError:(NSError*)aError;
@end
