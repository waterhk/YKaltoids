//
//  ConversationDeleter.h
//  altoids
//
//  Created by Jon Herron on 9/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConversationDeleter <NSObject>

#pragma mark -
#pragma mark @required
@required

- (BOOL)deleteAllConversationsInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext error:(NSError **)anError;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
