//
//  MyClass.h
//  altoids
//
//  Created by Jon Herron on 9/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationDeleter.h"
#import "ConversationHandler.h"
#import "ConversationFetchRequestCreator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationDeleter : NSObject <ConversationDeleter>

#pragma mark @property declarations
@property (strong, nonatomic) id<ConversationFetchRequestCreator> conversationFetchRequestCreator;
@property (strong, nonatomic) id<ConversationHandler> conversationHandler;

#pragma mark  Class methods

#pragma mark Instance methods

@end
