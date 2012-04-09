//
//  URLRequestMethodBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol URLRequestMethodBuilder <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSMutableURLRequest *)buildRequestMethodForURLRequest:(NSMutableURLRequest *)aURLRequest;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
