//
//  ConversationEditParsedJSONResponseHandler.h
//  altoids
//
//  Created by Jon Herron on 10/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParsedJSONResponseHandler.h"

@protocol ConversationEditParsedJSONResponseHandler <ParsedJSONResponseHandler>

#pragma mark -
#pragma mark @required
@required

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
