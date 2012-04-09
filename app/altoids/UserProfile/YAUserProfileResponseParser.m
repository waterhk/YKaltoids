//
//  YAUserProfileResponseParser.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileResponseParser.h"
#import "YAFetchUserProfileResponse.h"
#import "JSONParser.h"

@implementation YAUserProfileResponseParser

@synthesize jsonParser = jsonParser_;


- (YAFetchUserProfileResponse *)parseFetchUserProfileResponse:(NSData *)response error:(NSError *)error
{
    YAFetchUserProfileResponse *userProfileResponse = [[YAFetchUserProfileResponse alloc] init];
    [userProfileResponse setBody:[jsonParser_ parseJSONData:response]];
    
    return userProfileResponse;    
}

@end
