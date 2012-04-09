//
//  YAServerTransport.h
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/23/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transport.h"

@protocol NetworkActivityIndicatorStatusBarSpawner;

@interface YAServerTransport : NSObject <Transport>

@property (strong, nonatomic) id<NetworkActivityIndicatorStatusBarSpawner> networkActivityIndicatorStatusBarSpawner;

@end
