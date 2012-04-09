//
//  ConversationFetchRequestCreator.h
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@protocol ConversationFetchRequestCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSFetchRequest *)fetchRequestForAllConversationsInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

- (NSFetchRequest *)fetchRequestForConversationWithID:(NSString *)theConversationID inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

- (NSFetchRequest *)fetchRequestForConversationsWithIDs:(NSArray *)theConversationIDs inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
