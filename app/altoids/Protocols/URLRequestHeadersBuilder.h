//
//  URLRequestHeadersBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol URLRequestHeadersBuilder <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSMutableURLRequest *)buildRequestHeadersForURLRequest:(NSMutableURLRequest *)aURLRequest;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
