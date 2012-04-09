//
//  ConversationCreateURLWithURLParametersBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/10/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLRequestURLWithURLParametersBuilder.h"

@protocol ConversationCreateURLWithURLParametersBuilder <URLRequestURLWithURLParametersBuilder>

#pragma mark -
#pragma mark @required
@required

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
