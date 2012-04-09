//
//  Delegater.h
//  altoids
//
//  Created by Derrick Whittle on 1/10/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Delegater <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)clearDelegate:(id)delegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
