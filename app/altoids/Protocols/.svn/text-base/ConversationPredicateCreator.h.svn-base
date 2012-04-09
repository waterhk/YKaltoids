//
//  ConversationPredicateCreator.h
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConversationPredicateCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSPredicate *)predicateMatchingConversationByID:(NSString *)theConversationID;
- (NSPredicate *)predicateMatchingConversationsByID:(NSArray *)theConversationIDs;
- (NSPredicate *)predicateMatchingConversationGapPlaceholders;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
