//
//  NetworkActivityIndicatorOverlay.h
//  altoids
//
//  Created by Devin Doman on 2/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ActivityIndicatorOverlay <NSObject>

- (void)showActivityIndicatorOverylayWithUpdatingTextInParentView:(UIView*)view;
- (void)showActivityIndicatorOverylayWithSendingSMSTextInParentView:(UIView*)view;
- (void)hideActivityIndicatorOverlay;
- (void)indicateCurrentActivityHasCompleted;

@end