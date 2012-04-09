//
//  RegistrationStepCoordinator.h
//  altoids
//
//  Created by Jon Herron on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationStepCoordinatorDelegate.h"
#import "ViewControllerAccessor.h"

@protocol RegistrationStepCoordinator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)performRegistrationFromCurrentViewController:(id<ViewControllerAccessor>)aViewControllerAccessor;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
