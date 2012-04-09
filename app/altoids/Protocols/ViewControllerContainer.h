//
//  ViewControllerContainer.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewControllerContainer <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSArray*)createContainersForRootViewControllers:(NSArray*)viewControllers;
- (UINavigationController *)createContainerForRootViewController:(UIViewController *)rootViewController;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
