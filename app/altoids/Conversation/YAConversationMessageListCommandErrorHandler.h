//
//  YAConversationMessageListCommandErrorHandler.h
//  altoids
//
//  Created by Anand Biligiri on 11/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagedObjectContextFactory.h"
#import "YAMMCErrorHandler.h"
// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationMessageListCommandErrorHandler : YAMMCErrorHandler

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods
- (id)initWithConversationObjectID:(NSManagedObjectID *)conversationID managedObjectContextFactory:(id<ManagedObjectContextFactory>)managedObjectContextFactory;
@end
