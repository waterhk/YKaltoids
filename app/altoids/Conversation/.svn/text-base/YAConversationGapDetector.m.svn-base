//
//  YAConversationGapDetector.m
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientConversationListGapHandling
//

#import "YAConversationGapDetector.h"

@implementation YAConversationGapDetector

@synthesize conversationHandler = conversationHandler_;

- (YAConversation *)detectConversationImmediatelyBeforePossibleGapInConversationList:(NSArray *)theConversationList consideringExistingConversations:(NSDictionary *)theExistingConversationsByID realizingMoreConversationsExistOnTheServer:(BOOL)moreConversationsExistOnServer
{
    if (!moreConversationsExistOnServer) 
    {
        return nil;
    }
    
    if (![theConversationList count]) 
    {
        return nil;
    }
    
    YAConversation *lastConversationInList = [theConversationList lastObject];
    NSString *lastConversationID = [[self conversationHandler] conversationIDForConversation:lastConversationInList];
    
    YAConversation *existingConversationWithSameIDAsLastConversation = [theExistingConversationsByID objectForKey:lastConversationID];
    
    if (!existingConversationWithSameIDAsLastConversation) 
    {
        return lastConversationInList;
    }
    
    NSDate *lastConversationTimestamp = [[self conversationHandler] timestampForConversation:lastConversationInList];
    NSDate *existingConversationWithSameIDAsLastConversationTimestamp = [[self conversationHandler] timestampForConversation:existingConversationWithSameIDAsLastConversation];
    
    if (![lastConversationTimestamp isEqualToDate:existingConversationWithSameIDAsLastConversationTimestamp]) 
    {
        return lastConversationInList;
    }
    
    return nil;
}

@end
