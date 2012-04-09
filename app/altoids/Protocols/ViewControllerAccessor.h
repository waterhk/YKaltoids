//
//  ViewControllerAccessor.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewControllerAccessor <NSObject>

#pragma mark -
#pragma mark @required
@required

- (UIViewController *)viewController;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
