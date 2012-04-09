//
//  InvalidTokenSelectorViewController.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ViewControllerAccessor.h"

@protocol InvalidTokenSelectorViewController <ViewControllerAccessor>

#pragma mark -
#pragma mark @required
@required

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
