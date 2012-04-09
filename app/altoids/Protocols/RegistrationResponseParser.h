//
//  RegistrationResponseParser.h
//  altoids
//
//  Created by Lei Cai on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPURLResponse.h"

@protocol RegistrationResponseParser <NSObject>

#pragma mark -
#pragma mark @required
@required
- (id)parseRegistrationGetTokenResponse:(id<HTTPURLResponse>)response data:(NSData *)data error:(NSError *)error;
- (id)parseRegistrationVerifyResponse:(id<HTTPURLResponse>)response data:(NSData *)data error:(NSError *)error;
- (id)parseRegistrationRenewResponse:(NSData *)response error:(NSError *)error;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
