//
//  YARegistrationInfoURLWithURLParametersBuilder.h
//  altoids
//
//  Created by Venkatraman Sridharan on 1/25/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationInfoURLWithURLParametersBuilder.h"
#import "RegistrationRelativeURICreator.h"
#import "RegistrationURLCreator.h"

@interface YARegistrationInfoURLWithURLParametersBuilder : NSObject<RegistrationInfoURLWithURLParametersBuilder>

@property (strong, nonatomic) id<RegistrationURLCreator> registrationURLCreator;
@property (strong, nonatomic) id<RegistrationRelativeURICreator> registrationRelativeURICreator;

@end
