//
//  YADeactivationInfoURLWithURLParametersBuilder.h
//  altoids
//
//  Created by Venkatraman Sridharan on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeactivationInfoURLWithURLParametersBuilder.h"
#import "DeactivationRelativeURICreator.h"
#import "RegistrationURLCreator.h"

@interface YADeactivationInfoURLWithURLParametersBuilder : NSObject <DeactivationInfoURLWithURLParametersBuilder>

@property (nonatomic, strong) id<RegistrationURLCreator> registrationURLCreator;
@property (nonatomic, strong) id<DeactivationRelativeURICreator> deactivationRelativeURICreator;

@end
