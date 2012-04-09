//
//  MessageGapPlaceholderClearer.h
//  altoids
//
//  Created by Anand Subba Rao on 11/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageGapPlaceholderClearer <NSObject>

#pragma mark -
#pragma mark @required
@required
- (NSSet *)messagesWithGapPlaceholderRemovedInMessages:(NSSet *)messages managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
