//
//  UIAlertViewFactory.h
//  altoids
//
//  Created by Jon Herron on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIAlertViewFactory <NSObject>

#pragma mark -
#pragma mark @required
@required

- (UIAlertView *)createWithTitle:(NSString *)title 
                         message:(NSString *)message 
                        delegate:(id<UIAlertViewDelegate>)delegate 
               cancelButtonTitle:(NSString *)cancelButtonTitle 
               otherButtonTitles:(NSArray *)otherButtonTitles;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
