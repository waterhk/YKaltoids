//
//  YAConversationLocator.h
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationLocator.h"
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
@interface YAConversationLocator : NSObject <ConversationLocator>

#pragma mark @property declarations
@property (strong, nonatomic) id<ConversationFetchRequestCreator> conversationFetchRequestCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
