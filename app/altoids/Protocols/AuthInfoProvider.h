//
//  AccountInfo.h
//  altoids
//
//  Created by Anand Subba Rao on 8/26/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YSMAccountInfo;
@protocol AuthInfoProvider <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSString *)crumb;
- (NSString *)crumbFromMembership;
- (NSString *)crumbFromProfile;
- (NSString *)yCookie;
- (NSString *)tCookie;

- (void)updateAuthenticationInfo:(YSMAccountInfo *)accountinfo;
- (NSURL *)buildURLWithScheme:(NSString *)scheme server:(NSString *)server relativeURI:(NSString *)string params:(NSDictionary *)params;
- (NSURL *)buildProfileURLWithScheme:(NSString *)scheme server:(NSString *)server relativeURI:(NSString *)string params:(NSDictionary *)params;
- (void)addAuthenticationInfo:(NSMutableURLRequest *)request;
- (void)addDefaultHTTPHeadersForRequest:(NSMutableURLRequest *)request withServerInfo:(NSString*)serverInfo;
- (void)updateApplicationCrumb:(NSString *)crumb;
- (void)updateUserGuid:(NSString *)guid;
- (void)updateProfileCrumb:(NSString *)crumb;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
