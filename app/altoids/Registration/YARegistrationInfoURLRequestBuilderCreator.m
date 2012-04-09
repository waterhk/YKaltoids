//
//  YARegistrationInfoURLRequestBuilder.m
//  altoids
//
//  Created by Venkatraman Sridharan on 1/25/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YARegistrationInfoURLRequestBuilderCreator.h"

@implementation YARegistrationInfoURLRequestBuilderCreator

@synthesize urlRequestBuilderComposer = urlRequestBuilderComposer_;
@synthesize registrationInfoURLWithURLParametersBuilder = registrationInfoURLWithURLParametersBuilder_;

- (id<URLRequestBuilder>)createRegistrationInfoCreateURLRequestBuilder 
{
      return [[self urlRequestBuilderComposer] composeStandardPostRequestWithJSONPayloadUsingURLWithURLParametersBuilder:[self registrationInfoURLWithURLParametersBuilder]];
}

@end
