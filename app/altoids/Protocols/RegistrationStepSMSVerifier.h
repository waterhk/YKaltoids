//
//  RegistrationStepSMSVerifier.h
//  altoids
//
//  Created by Jon Herron on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationStep.h"

@protocol RegistrationStepSMSVerifier <RegistrationStep>

#pragma mark -
#pragma mark @required
@required

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
