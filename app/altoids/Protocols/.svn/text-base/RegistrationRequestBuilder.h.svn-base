//
//  RegistrationRequestBuilder.h
//  altoids
//
//  Created by Lei Cai on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RegistrationRequestBuilder <NSObject>

#pragma mark -
#pragma mark @required
@required
- (NSURLRequest*)buildGetTokenRequestWithMCC:(NSString*)mcc andMNC:(NSString*)mnc andMSID:(NSString*)msid;
- (NSURLRequest*)buildVerifyTokenRequestWithBindToken:(NSString*)bindToken;
- (NSURLRequest*)buildRenewRequestWithNumber:(NSString*)number;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
