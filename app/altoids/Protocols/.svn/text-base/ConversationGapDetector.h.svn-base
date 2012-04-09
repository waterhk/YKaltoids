//
//  ConversationGapDetector.h
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientConversationListGapHandling
//

#import <Foundation/Foundation.h>
#import "YAConversation.h"

@protocol ConversationGapDetector <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAConversation *)detectConversationImmediatelyBeforePossibleGapInConversationList:(NSArray *)theConversationList consideringExistingConversations:(NSDictionary *)theExistingConversationsByID realizingMoreConversationsExistOnTheServer:(BOOL)moreConversationsExistOnServer;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
