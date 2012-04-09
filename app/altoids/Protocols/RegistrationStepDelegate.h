//
//  RegistrationStepDelegate.h
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YARegistrationTransientState.h"

@protocol RegistrationStepDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)stepDidCompleteWithMutatedTransientState:(YARegistrationTransientState *)aRegistrationTransientState;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
