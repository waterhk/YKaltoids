//
//  MessageFetchRequestCreator.h
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageFetchRequestCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSFetchRequest *)fetchRequestForAllMessagesInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

- (NSFetchRequest *)fetchRequestForMessagesMatchingIDs:(NSArray *)theMessageIDs inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

- (NSFetchRequest *)fetchRequestForMessagesInConversationWithID:(NSString *)theConversationID inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
