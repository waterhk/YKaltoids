//
//  MessageRepository.h
//  altoids
//
//  Created by Jon Herron on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "YAConversation.h"
#import "YAMessage.h"
#import "YAMessageInfo.h"
#import "YAParticipant.h"

@protocol MessageRepository <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAMessage *)createMessageFromMessageInfo:(YAMessageInfo *)aMessageInfo inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError;

- (BOOL)deleteAllMessagesInConversationWithID:(NSString *)theConversationID inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext error:(NSError **)anError;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
