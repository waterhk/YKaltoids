//
//  LoginServiceProtocol.h
//  SessionManager4
//
//  Created by Lei Cai on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSMAccountInfo.h"

@protocol LoginService <NSObject>
- (void)loginWithUsername:(NSString*)aUsername andPassword:(NSString*)aPassword;
@end

@protocol LoginServiceDelegate <NSObject>
- (void)loginService:(id<LoginService>)aLoginService didSucceedWithAccount:(YSMAccountInfo*)aAccountInfo;
- (void)loginService:(id<LoginService>)aLoginService didFailWithError:(NSError*)aError;
@end