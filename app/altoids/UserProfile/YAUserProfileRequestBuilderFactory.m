//
//  YAUserProfileRequestBuilderFactory.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileRequestBuilderFactory.h"
#import <SBJson/SBJson.h>
#import "YAUser.h"

// Private class extension
@interface YAUserProfileRequestBuilderFactory ()

// @property definitions

// methods

@end

@implementation YAUserProfileRequestBuilderFactory

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize profileServerConfiguration = profileServerConfiguration_;
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
- (NSURLRequest *)buildFetchUserProfileRequestWithUser:(YAUser *)user {
    NSURL *requestUrl = [[self authInfoProvider] buildProfileURLWithScheme:@"http" server:[[self profileServerConfiguration] serverHostname]
                                                        relativeURI:@"v1/user/%@/profile;out=image,givenName,familyName,guid"
                                                                    params:[NSDictionary dictionaryWithObjectsAndKeys:@"128x128", @".imgsize",
                                                                                   @"json", @"format",nil]];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    
    [urlRequest setHTTPMethod:@"GET"];
    
    [[self authInfoProvider] addAuthenticationInfo:urlRequest];
    [[self authInfoProvider] addDefaultHTTPHeadersForRequest:urlRequest withServerInfo:[[self profileServerConfiguration] serverHostname]];
    [urlRequest setValue:@"test" forHTTPHeaderField:@"X-Yahoo-Cprop"];
    
    return urlRequest;
}

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

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
#pragma mark YAUserProfileRequestBuilderFactory ()

@end
