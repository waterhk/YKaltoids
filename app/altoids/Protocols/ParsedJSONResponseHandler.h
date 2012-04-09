//
//  JSONResponseHandler.h
//  altoids
//
//  Created by Jon Herron on 9/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParsedJSONResponseHandler <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)handleParsedJSONResponse:(NSDictionary *)aParsedJSONResponse;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
