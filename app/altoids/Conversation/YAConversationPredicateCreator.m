//
//  YAConversationPredicateCreator.m
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationPredicateCreator.h"
#import "ConversationStatus.h"

static NSString * const kPredicateMatchingConversationByIDFormat = @"conversationID = %@";
static NSString * const kPredicateMatchingConversationsByIDFormat = @"conversationID in %@";
static NSString * const kPredicateMatchingConversationGapPlaceholders = @"status = %@";

@implementation YAConversationPredicateCreator

- (NSPredicate *)predicateMatchingConversationByID:(NSString *)theConversationID
{
    return [NSPredicate predicateWithFormat:kPredicateMatchingConversationByIDFormat, theConversationID];
}

- (NSPredicate *)predicateMatchingConversationsByID:(NSArray *)theConversationIDs
{
    return [NSPredicate predicateWithFormat:kPredicateMatchingConversationsByIDFormat, theConversationIDs];
}

- (NSPredicate *)predicateMatchingConversationGapPlaceholders
{
    return [NSPredicate predicateWithFormat:kPredicateMatchingConversationGapPlaceholders, [NSNumber numberWithInt:YAConversationStatusGapPlaceholder]];
}

@end
