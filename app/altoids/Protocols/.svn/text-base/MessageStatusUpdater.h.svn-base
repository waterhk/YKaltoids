//
//  MessageStatusUpdater.h
//  altoids
//
//  Created by Jon Herron on 12/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAConversation.h"

@protocol MessageStatusUpdater <NSObject>

#pragma mark -
#pragma mark @required
@required

- (BOOL)markMesssageAsRead:(NSArray *)theUnreadMessages forConversation:(YAConversation *)theConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
