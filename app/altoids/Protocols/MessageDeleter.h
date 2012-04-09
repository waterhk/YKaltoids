//
//  MessageDeleter.h
//  altoids
//
//  Created by Jon Herron on 10/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YAMessage;

@protocol MessageDeleter <NSObject>

@required

- (BOOL)deleteAllMessagesInConversationWithID:(NSString *)theConversationID inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext error:(NSError **)anError;

- (BOOL)deleteMessage:(YAMessage *)aMessage inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)aError;

@end
