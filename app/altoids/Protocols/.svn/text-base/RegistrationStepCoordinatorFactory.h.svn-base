//
//  RegistrationStepCoordinatorFactory.h
//  altoids
//
//  Created by Jon Herron on 9/6/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationStepCoordinator.h"
#import "RegistrationStepCoordinatorDelegate.h"

@protocol RegistrationStepCoordinatorFactory <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<RegistrationStepCoordinator>)registrationStepCoordinatorWithDelegate:(id<RegistrationStepCoordinatorDelegate>)aDelegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
