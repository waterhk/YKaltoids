//
//  RegistrationStepSelector.h
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationStep.h"
#import "RegistrationStepDelegate.h"
#import "YARegistrationTransientState.h"

@protocol RegistrationStepSelector <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<RegistrationStep>)registrationStepBasedOnTransientState:(YARegistrationTransientState *)aTransientState delegate:(id<RegistrationStepDelegate>)aDelegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
