//
//  BarButtonItemCreator.h
//  altoids
//
//  Created by Derrick Whittle on 1/19/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BarButtonItemCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (UIBarButtonItem*)createBarButtonItemWithCustomView:(UIView*)view;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
