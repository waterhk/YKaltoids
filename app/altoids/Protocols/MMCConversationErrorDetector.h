//
//  MMCConversationErrorDetector.h
//  altoids
//
//  Created by Jon Herron on 11/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAMMCConversation.h"

@protocol MMCConversationErrorDetector <NSObject>

#pragma mark -
#pragma mark @required
@required

- (BOOL)mmcConversationHasErrors:(YAMMCConversation *)theMMCConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
