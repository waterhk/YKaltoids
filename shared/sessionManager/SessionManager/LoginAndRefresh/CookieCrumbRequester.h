//
//  CookieRequesterProtocol.h
//  SessionManager4
//
//  Created by Lei Cai on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CookieCrumbRequester <NSObject>
- (void)requestCookieCrumbWithToken:(NSString*)aToken;
@end

@protocol CookieCrumbRequesterDelegate <NSObject>
- (void)cookieCrumbRequester:(id<CookieCrumbRequester>)aCookieCrumbRequester
       didSucceedWithYCookie:(NSString*)aYCookie
                  andTCookie:(NSString*)aTCookie
                    andCrumb:(NSString*)aCrumb
               andExpirationDate:(NSDate*)aExpirationDate;
- (void)cookieCrumbRequester:(id<CookieCrumbRequester>)aCookieCrumbRequester didFailWithError:(NSError*)aError;
@end