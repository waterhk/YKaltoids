//
//  CrumbServiceFactory.h
//  altoids
//
//  Created by Anand Subba Rao on 9/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CrumbServiceDelegate.h"
#import "CrumbService.h"

@protocol CrumbServiceFactory <NSObject>

#pragma mark -
#pragma mark @required
@required
- (id<CrumbService>)createWithDelegate:(id<CrumbServiceDelegate>)delegate;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
