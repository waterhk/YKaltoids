//
//  AppConfiguration.h
//  altoids
//
//  Created by Anand Biligiri on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppConfiguration <NSObject>

#pragma mark -
#pragma mark @required
@required
@property (nonatomic, assign) BOOL resetOnLaunch;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
