//
//  CrumbServiceDelegate.h
//  altoids
//
//  Created by Anand Subba Rao on 9/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CrumbService.h"

@protocol CrumbServiceDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required
- (void)crumbService:(id<CrumbService>)crumbService didReceiveCrumb:(NSString *)crumb guid:(NSString *)guid;
- (void)crumbService:(id<CrumbService>)crumbService didFailWithError:(NSError *)error;

- (void)crumbService:(id<CrumbService>)crumbService didReceiveProfileCrumb:(NSString *)crumb;
- (void)crumbService:(id<CrumbService>)crumbService didFailProfileCrumbWithError:(NSError *)error;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
