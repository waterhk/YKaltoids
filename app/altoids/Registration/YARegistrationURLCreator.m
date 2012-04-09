//
//  YARegistrationURLCreator.m
//  altoids
//
//  Created by Venkatraman Sridharan on 1/25/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YARegistrationURLCreator.h"
#define kRegistrationCrumbParamKey @"c"


@implementation YARegistrationURLCreator

@synthesize authInfoProvider = authInfoProvider_;
@synthesize serverConfiguration = serverConfiguration_;
@synthesize urlCreator = urlCreator_;


- (NSURL *)createRegistrationURLWithRelativeURI:(NSString *)aRelativeURI
{
    return [self createRegistrationURLWithRelativeURI:aRelativeURI params:nil];
}

- (NSURL *)createRegistrationURLWithRelativeURI:(NSString *)aRelativeURI params:(NSDictionary *)aParams
{
    NSMutableDictionary *registrationParams = [NSMutableDictionary dictionaryWithDictionary:aParams];
    NSString *scheme = @"http";
    NSString *server = [[self serverConfiguration] registrationServer];
    
    [registrationParams setObject:[[self authInfoProvider] crumb] forKey:kRegistrationCrumbParamKey];
    
    return [[self urlCreator] createWithScheme:scheme server:server relativeURI:aRelativeURI params:registrationParams];
}




@end
