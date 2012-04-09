//
//  YAConversationListCommandErrorHandler.h
//  altoids
//
//  Created by Jon Herron on 11/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationListCommandErrorHandler.h"
#import "YAMMCConversationErrorDetector.h"
#import "YAMMCErrorCreator.h"
#import "ConversationErrorCreator.h"
#import "ConversationLocator.h"
#import "ConversationHandler.h"
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
@interface YAConversationListCommandErrorHandler : NSObject <ConversationListCommandErrorHandler>

#pragma mark @property declarations
@property (strong, nonatomic) id<MMCConversationErrorDetector> mmcConversationErrorDetector;
@property (strong, nonatomic) id<MMCErrorCreator> mmcErrorCreator;
@property (strong, nonatomic) id<ConversationErrorCreator> conversationErrorCreator;
@property (strong, nonatomic) id<ConversationLocator> conversationLocator;
@property (strong, nonatomic) id<ConversationHandler> conversationHandler;
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;

#pragma mark  Class methods

#pragma mark Instance methods

@end
