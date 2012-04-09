//
//  YAURLRequestAuthenticationHeadersBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAURLRequestStandardHeadersBuilder.h"

#define kHeaderFieldAccept @"Accept"
#define kHeaderFieldCookie @"Cookie"
#define kHeaderFieldHost @"Host"

#define kHeaderValueAccept @"*/*"
#define kHeaderValueCookieFormat @"Y=%@; T=%@"

// Private class extension
@interface YAURLRequestStandardHeadersBuilder ()

// @property definitions

// methods

@end

@implementation YAURLRequestStandardHeadersBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize authInfoProvider = authInfoProvider_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark URLRequestHeadersBuilder delegate methods

- (NSMutableURLRequest *)buildRequestHeadersForURLRequest:(NSMutableURLRequest *)aURLRequest
{
    NSString *yCookie = [[self authInfoProvider] yCookie];
    NSString *tCookie = [[self authInfoProvider] tCookie];
    NSString *cookie = [NSString stringWithFormat:kHeaderValueCookieFormat, yCookie, tCookie];
    NSString *host = [[aURLRequest URL] host];
    
    [aURLRequest setValue:kHeaderValueAccept forHTTPHeaderField:kHeaderFieldAccept];
    [aURLRequest setValue:cookie forHTTPHeaderField:kHeaderFieldCookie];
    [aURLRequest setValue:host forHTTPHeaderField:kHeaderFieldHost];
    
    return aURLRequest;
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
#pragma mark YAURLRequestAuthenticationHeadersBuilder ()

@end
