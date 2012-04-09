//
//  ConversationEntityDescriptionCreator.h
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@protocol ConversationEntityDescriptionCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSEntityDescription *)conversationEntityDescriptionInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
