//
//  RegistrationResponseHandler.h
//  altoids
//
//  Created by Anand Subba Rao on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YARegistrationGetTokenResponse;
@class YARegistrationVerifyTokenResponse;
@class YARegistrationRenewResponse;

@protocol RegistrationResponseHandler <NSObject>

#pragma mark -
#pragma mark @required
@required
- (void)handleGetTokenResponse:(YARegistrationGetTokenResponse *)response context:(id)context;
- (void)handleVerifyTokenResponse:(YARegistrationVerifyTokenResponse *)response context:(id)context;
- (void)handleRenewResponse:(YARegistrationRenewResponse *)response context:(id)context;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
