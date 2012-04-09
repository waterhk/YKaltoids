//
//  ConversationListCommandDelegate.h
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConversationListCommandDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)conversationListRecieved:(NSArray *)aConversationsList conversationIDs:(NSArray *)anArrayOfConversationIDs moreConversationsPresentOnServer:(BOOL)aMoreConversationsPresentOnServer;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
