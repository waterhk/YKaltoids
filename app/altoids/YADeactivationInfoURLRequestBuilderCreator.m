//
//  YADeactivationInfoURLRequestBuilderCreator.m
//  altoids
//
//  Created by Venkatraman Sridharan on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YADeactivationInfoURLRequestBuilderCreator.h"

@implementation YADeactivationInfoURLRequestBuilderCreator
@synthesize urlRequestBuilderComposer = urlRequestBuilderComposer_;
@synthesize deactivationInfoURLWithURLParametersBuilder = deactivationInfoURLWithURLParametersBuilder_;


- (id<URLRequestBuilder>)createRegistrationInfoCreateURLRequestBuilder 
{
    return [[self urlRequestBuilderComposer] composeStandardPostRequestWithJSONPayloadUsingURLWithURLParametersBuilder:[self deactivationInfoURLWithURLParametersBuilder]];
}


@end
