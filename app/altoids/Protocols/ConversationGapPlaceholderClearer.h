//
//  ConversationGapPlaceholderClearer.h
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientConversationListGapHandling
//

#import <Foundation/Foundation.h>

@protocol ConversationGapPlaceholderClearer <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSArray *)clearConversationGapPlaceholdersInListOfConversations:(NSArray *)theListOfConversations inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext moreConversationsPresentOnServer:(BOOL)theMoreConversationsPresentOnServer;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
