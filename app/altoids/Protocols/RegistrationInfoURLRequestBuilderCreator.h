//
//  RegistrationInfoURLRequestBuilderCreator.h
//  altoids
//
//  Created by Venkatraman Sridharan on 1/25/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLRequestBuilder.h"


@protocol RegistrationInfoURLRequestBuilderCreator <NSObject>

- (id<URLRequestBuilder>)createRegistrationInfoCreateURLRequestBuilder;

@end
