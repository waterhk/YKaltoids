//
//  YANetworkActivityIndicatorStatusBar.h
//  altoids
//
//  Created by Devin Doman on 02/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkActivityIndicatorStatusBar.h"

@interface YANetworkActivityIndicatorStatusBar : NSObject <NetworkActivityIndicatorStatusBar>
@property (strong, nonatomic) UIApplication* app;
@end