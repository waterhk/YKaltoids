//
//  UIAlertViewDismisser.h
//  altoids
//
//  Created by Anand Subba Rao on 9/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIAlertViewDismisser <NSObject>

#pragma mark -
#pragma mark @required
@required
- (void)dismissAlertView:(UIAlertView *)alertView clickButtonAtIndex:(NSInteger)buttonIndex;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
