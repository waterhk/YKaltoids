//
//  YAAccountInfoProvider.m
//  altoids
//
//  Created by Anand Subba Rao on 8/26/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAAuthInfoProvider.h"
#import "YSMAccountInfo.h"

// Private class extension
@interface YAAuthInfoProvider ()

// @property definitions
@property (nonatomic, strong) YSMAccountInfo *accountInfo;
@property (nonatomic, copy) NSString *applicationCrumb;
@property (nonatomic, copy) NSString *userGuid;
@property (nonatomic, copy) NSString *profileCrumb;
// methods

@end

@implementation YAAuthInfoProvider

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize accountInfo = accountInfo_;
@synthesize applicationCrumb = applicationCrumb_;
@synthesize profileCrumb = profileCrumb_;
@synthesize userGuid = userGuid_;

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <AuthInfoProvider> methods
- (void)updateAuthenticationInfo:(YSMAccountInfo *)accountInfo
{
    [self setAccountInfo:accountInfo];
}

- (void)updateApplicationCrumb:(NSString *)crumb
{
    [self setApplicationCrumb:crumb];
}

- (void)updateUserGuid:(NSString *)guid
{
    [self setUserGuid:guid];
}

- (void)updateProfileCrumb:(NSString *)crumb
{
    [self setProfileCrumb:crumb];
}

- (NSString *)crumb
{
    if ([self applicationCrumb]) {
        return [self applicationCrumb];
    }
    
    return [self crumbFromMembership];
}

- (NSString *)yCookie
{
    return [[self accountInfo] yCookie];
}

- (NSString *)tCookie
{
    return [[self accountInfo] tCookie];
}

- (NSString *)crumbFromMembership
{
    return [[[self accountInfo] crumb] stringByReplacingOccurrencesOfString:@"\r" withString:@""];
}

- (NSString *)crumbFromProfile
{
    return [self profileCrumb];
}

- (NSURL *)buildURLWithScheme:(NSString *)scheme server:(NSString *)server relativeURI:(NSString *)relativeURI params:(NSDictionary *)params {
    
    __block NSMutableString *paramString = [NSMutableString stringWithFormat:@"c=%@", [self crumb]];
    
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
     {
         [paramString appendFormat:@"&%@=%@", key, obj];
     }
     ];
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/%@?%@", scheme, server, relativeURI, paramString]];
}

- (NSURL *)buildProfileURLWithScheme:(NSString *)scheme server:(NSString *)server relativeURI:(NSString *)relativeURI params:(NSDictionary *)params {
    
    __block NSMutableString *paramString = [NSMutableString stringWithFormat:@".crumb=%@", [self profileCrumb]];
    
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
     {
         [paramString appendFormat:@"&%@=%@", key, obj];
     }
     ];
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/%@?%@", scheme, server, [NSString stringWithFormat:relativeURI,[self userGuid]], paramString]];
}

- (void)addAuthenticationInfo:(NSMutableURLRequest *)request {
    [request setValue:[NSString stringWithFormat:@"Y=%@; T=%@", [[self accountInfo] yCookie], [[self accountInfo] tCookie]] forHTTPHeaderField:@"Cookie"];
}

- (void)addDefaultHTTPHeadersForRequest:(NSMutableURLRequest *)request withServerInfo:(NSString*)serverInfo {
    [request setValue:serverInfo forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-type"];
    [request setValue:[NSString stringWithFormat:@"%d",[[request HTTPBody] length]] forHTTPHeaderField:@"Content-Length"];
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAAccountInfoProvider ()

@end
