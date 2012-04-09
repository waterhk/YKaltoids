//
//  PullToRefreshView.h
//  altoids
//
//  Created by Xianzhe Ma on 3/2/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum 
{
    PullToRefreshViewStateNormal,
    PullToRefreshViewStatePulling,
    PullToRefreshViewStateLoading,
    PullToRefreshViewStateError,
} PullToRefreshViewState;

typedef enum 
{
    PullToRefreshViewErrorCodeNetwork,
    PullToRefreshViewErrorCodeDefault,
} PullToRefreshViewErrorCode;

@protocol PullToRefreshView <NSObject>

@property (nonatomic, assign) PullToRefreshViewState state;
- (void)setErrorStateWithCode:(PullToRefreshViewErrorCode)aErrorCode;
- (CGFloat) heightOfMessageArea;

- (void)setLastUpdateDateToCurrentDate;

- (UIView<PullToRefreshView> *) viewValue;

@end
