//
//  ErrorResponseParser.h
//  altoids
//
//  Created by Anand Subba Rao on 9/9/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPURLResponse.h"

@protocol ErrorResponseParser <NSObject>

#pragma mark -
#pragma mark @required
@required
- (NSError *)errorWithHTTPURLResponse:(id<HTTPURLResponse>)urlResponse jsonDict:(NSDictionary *)jsonDict;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
