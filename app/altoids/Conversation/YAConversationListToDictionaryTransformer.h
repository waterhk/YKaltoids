//
//  YAConversationListToDictionaryTransformer.h
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationListToDictionaryTransformer.h"
#import "ConversationHandler.h"
#import "MutableDictionaryCreator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationListToDictionaryTransformer : NSObject <ConversationListToDictionaryTransformer>

#pragma mark @property declarations
@property (strong, nonatomic) id<ConversationHandler> conversationHandler;
@property (strong, nonatomic) id<MutableDictionaryCreator> mutableDictionaryCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
