//
//  YADeactivationInfoURLWithURLParametersBuilder.m
//  altoids
//
//  Created by Venkatraman Sridharan on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YADeactivationInfoURLWithURLParametersBuilder.h"

@implementation YADeactivationInfoURLWithURLParametersBuilder
@synthesize registrationURLCreator = registrationURLCreator_;
@synthesize deactivationRelativeURICreator = deactivationRelativeURICreator_;



- (NSMutableURLRequest *)buildRequestURLWithURLParameters:(NSDictionary *)aURLParameters
{

    return [NSMutableURLRequest requestWithURL:[[self registrationURLCreator] createRegistrationURLWithRelativeURI:[[self deactivationRelativeURICreator] createRelativeURIToRetreiveRegistrationInfo] params:aURLParameters]];

}

@end
