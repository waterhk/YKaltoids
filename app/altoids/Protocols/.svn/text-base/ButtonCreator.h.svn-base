//
//  ButtonCreator.h
//  altoids
//
//  Created by Derrick Whittle on 1/19/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ButtonCreator <NSObject>

#pragma mark -
#pragma mark @required
@required


- (UIButton*)autosizingNavigationBarButtonWithTitle:(NSString*)title normalBackgroundImageName:(NSString*)normalBackgroundImageName pressedBackgroundImageName:(NSString*)pressedBackgroundImageName target:(id)target action:(SEL)action;

- (UIButton*)autosizingNavigationBarButtonWithImageNamed:(NSString*)imageName normalBackgroundImageName:(NSString*)normalBackgroundImageName pressedBackgroundImageName:(NSString*)pressedBackgroundImageName target:(id)target action:(SEL)action;


/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
