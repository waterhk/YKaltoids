//
//  ConversationDetailsViewControllerCreator.h
//  altoids
//
//  Created by Jon Herron on 10/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerAccessor.h"
#import "YAConversation.h"

@protocol ConversationDetailsViewControllerCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<ViewControllerAccessor>)createWithConversation:(YAConversation *)theConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
