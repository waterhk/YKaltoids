//
//  URLRequestBuilderComposer.h
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLRequestBuilder.h"
#import "URLRequestURLWithURLParametersBuilder.h"
#import "URLRequestMethodBuilder.h"
#import "URLRequestHeadersBuilder.h"
#import "URLRequestBodyBuilder.h"

@protocol URLRequestBuilderComposer <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<URLRequestBuilder>)composeStandardGetRequestUsingURLWithURLParametersBuilder:(id<URLRequestURLWithURLParametersBuilder>)theURLRequestWithURLParamatersBuilder;

- (id<URLRequestBuilder>)composeStandardPostRequestWithJSONPayloadUsingURLWithURLParametersBuilder:(id<URLRequestURLWithURLParametersBuilder>)theURLRequestWithURLParamatersBuilder;

- (id<URLRequestBuilder>)composeStandardPutRequestWithJSONPayloadUsingURLWithURLParametersBuilder:(id<URLRequestURLWithURLParametersBuilder>)theURLRequestWithURLParamatersBuilder;

- (id<URLRequestBuilder>)composeMultipartPostRequestUsingURLWithURLParametersBuilder:(id<URLRequestURLWithURLParametersBuilder>)theURLRequestWithURLParametersBuilder;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
