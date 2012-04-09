//
//  CommandErrorHandler.h
//  altoids
//
//  Created by Jon Herron on 11/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorHandler.h"

@protocol CommandErrorHandler <ErrorHandler>

#pragma mark -
#pragma mark @required
@required

- (BOOL)parsedJSONResponseHasError:(NSDictionary *)theParsedJSONResponse error:(NSError **)anError;
- (BOOL)urlRequestHasError:(NSURLRequest *)theURLRequest error:(NSError **)anError;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
