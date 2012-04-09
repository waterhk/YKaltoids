//
//  DeactivationInfoURLRequestBuilderCreator.h
//  altoids
//
//  Created by Venkatraman Sridharan on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLRequestBuilder.h"

@protocol DeactivationInfoURLRequestBuilderCreator <NSObject>


- (id<URLRequestBuilder>)createRegistrationInfoCreateURLRequestBuilder;

@end
