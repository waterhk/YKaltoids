//
//  MessagePredicateCreator.h
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessagePredicateCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSPredicate *)predicateMatchingMessagesByID:(NSArray *)theMessageIDs;
- (NSPredicate *)predicateMatchingMessageGapPlaceholders;
- (NSPredicate *)predicateMatchingMessagesInConversationWithID:(NSString *)theConversationID;
- (NSPredicate *)predicateMatchingUnreadMessages;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
