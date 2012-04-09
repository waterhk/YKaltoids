//
//  TokenRequesterProtocol.h
//  SessionManager4
//
//  Created by Lei Cai on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TokenRequester <NSObject>

- (void)requestTokenWithUsername:(NSString*)aUsername andPassword:(NSString*)aPassword;

@end

@protocol TokenRequesterDelegate <NSObject>
- (void)tokenRequester:(id<TokenRequester>)aTokenRequester didSucceedWithToken:(NSString*)aToken;
- (void)tokenRequester:(id<TokenRequester>)aTokenRequester didFailWithError:(NSError*)aError;
@end