//
//  YAConversationEditErrorHandler.h
//  altoids
//
//  Created by Jon Herron on 11/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationHandler.h"
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
@interface YAConversationEditErrorHandler : YAMMCErrorHandler

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithConversationHandler:(id<ConversationHandler>)theConversationHandler 
      managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory 
             conversationObjectID:(NSManagedObjectID *)theConversationObjectID;

@end
