//
//  ConversationComposeDelegate.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    YAComposeResultCancelled,
    YAComposeResultSent,
    YAComposeResultFailed
}YAComposeResult;

@class YAConversation;

@protocol ConversationComposeDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)conversationComposeViewController:(id<ViewControllerAccessor>)conversationComposeViewController didFinishWithResult:(YAComposeResult)result conversation:(YAConversation*)conversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
