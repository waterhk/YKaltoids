//
//  URLRequestCreator.h
//  altoids
//
//  Created by Jon Herron on 9/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientURLAndURLRequestHandling
//

#import <Foundation/Foundation.h>
#import "URLRequestBuilder.h"

@protocol URLRequestCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSURLRequest *)urlRequestFromURLRequestBuilder:(id<URLRequestBuilder>)aURLRequestBuilder withURLParameters:(NSDictionary *)theURLParameters requestData:(NSData *)theRequestData;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
