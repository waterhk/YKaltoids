//
//  YANetworkActivityIndicatorStatusBarSpawner.m
//  altoids
//
//  Created by Devin Doman on 2/22/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YANetworkActivityIndicatorStatusBarSpawner.h"

@interface YANetworkActivityIndicatorStatusBarSpawner ()
@property (assign, nonatomic) int accessCount;
@end

@implementation YANetworkActivityIndicatorStatusBarSpawner

@synthesize accessCount = accessCount_;
@synthesize networkActivityIndicatorStatusBar = networkActivityIndicatorStatusBar_;


- (void) networkActivityDidBegin
{
    @synchronized(self)
    {
        ++accessCount_; 
    }
    [networkActivityIndicatorStatusBar_ showNetworkActivityIndicatorStatusBar];
}

- (void) networkActivityDidEnd
{
    bool canHide = false;
    @synchronized(self)
    {
        --accessCount_;
        if (accessCount_ == 0)
        {
            canHide = true;
        }
    }
    
    if (canHide)
    {
        [networkActivityIndicatorStatusBar_ hideNetworkActivityIndicatorStatusBar];
    }
}

@end