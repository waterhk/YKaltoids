//
//  URLBuilder.h
//  altoids
//
//  Created by Jon Herron on 9/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientURLAndURLRequestHandling
//

#import <Foundation/Foundation.h>
#import "URLRequestURLWithURLParametersBuilder.h"
#import "URLRequestMethodBuilder.h"
#import "URLRequestHeadersBuilder.h"
#import "URLRequestBodyBuilder.h"

@protocol URLRequestBuilder <URLRequestURLWithURLParametersBuilder, URLRequestMethodBuilder, URLRequestHeadersBuilder, URLRequestBodyBuilder>

#pragma mark -
#pragma mark @required
@required

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
