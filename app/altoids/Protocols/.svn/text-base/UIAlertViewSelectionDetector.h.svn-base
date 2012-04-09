//
//  UIAlertViewSelectionDetector.h
//  altoids
//
//  Created by Jon Herron on 9/6/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIAlertViewSelectionDetector <NSObject>

#pragma mark -
#pragma mark @required
@required

- (BOOL)clickedButtonIndex:(NSInteger)aClickedButtonIndex isCancelButtonIndexForUIAlertView:(UIAlertView *)aUIAlertView;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
