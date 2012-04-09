//
//  YARegistrationInfoURLWithURLParametersBuilder.m
//  altoids
//
//  Created by Venkatraman Sridharan on 1/25/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YARegistrationInfoURLWithURLParametersBuilder.h"

@implementation YARegistrationInfoURLWithURLParametersBuilder


@synthesize registrationURLCreator = registrationURLCreator_;
@synthesize registrationRelativeURICreator = registrationRelativeURICreator_;


- (NSMutableURLRequest *)buildRequestURLWithURLParameters:(NSDictionary *)aURLParameters
{
    return [NSMutableURLRequest requestWithURL:[[self registrationURLCreator] createRegistrationURLWithRelativeURI:[[self registrationRelativeURICreator] createRelativeURIToRetreiveRegistrationInfo] params:aURLParameters]];
}




@end
