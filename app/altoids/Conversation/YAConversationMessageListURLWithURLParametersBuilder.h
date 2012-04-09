//
//  YAConversationMessageListURLWithURLParametersBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationMessageListURLWithURLParametersBuilder.h"
#import "MMCRelativeURICreator.h"
#import "MMCURLCreator.h"
#import "YAConversation.h"
#import "ManagedObjectContextFactory.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationMessageListURLWithURLParametersBuilder : NSObject <ConversationMessageListURLWithURLParametersBuilder>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithMMCURLCreator:(id<MMCURLCreator>)theMMCURLCreator 
      mmcRelativeURICreator:(id<MMCRelativeURICreator>)theMMCRelativeURICreator 
               conversation:(YAConversation *)theConversation
managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory;

@end
