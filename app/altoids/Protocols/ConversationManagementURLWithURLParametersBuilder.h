//
//  ConversationManagementURLWithURLParametersBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLRequestURLWithURLParametersBuilder.h"

@protocol ConversationManagementURLWithURLParametersBuilder <URLRequestURLWithURLParametersBuilder>

#pragma mark -
#pragma mark @required
@required

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
