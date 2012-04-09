//
//  ConversationLocator.h
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "YAConversation.h"

@protocol ConversationLocator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAConversation *)conversationWithID:(NSString *)theConversationID inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

- (NSArray *)conversationsWithIDs:(NSArray *)theConversationIDs inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
