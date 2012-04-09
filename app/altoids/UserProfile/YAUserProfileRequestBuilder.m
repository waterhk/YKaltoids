//
//  YAUserProfileRequestBuilder.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileRequestBuilder.h"
#import <SBJson/SBJson.h>
#import "YAUser.h"

@implementation YAUserProfileRequestBuilder

@synthesize profileServerConfiguration = profileServerConfiguration_;
@synthesize authInfoProvider = authInfoProvider_;

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


@end
