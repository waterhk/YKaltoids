//
//  ConversationReplyParsedJSONResponseHandler.h
//  altoids
//
//  Created by Jon Herron on 10/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParsedJSONResponseHandler.h"

@protocol ConversationReplyParsedJSONResponseHandler <ParsedJSONResponseHandler>

#pragma mark -
#pragma mark @required
@required

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
