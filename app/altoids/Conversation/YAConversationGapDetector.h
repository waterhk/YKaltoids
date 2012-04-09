//
//  YAConversationGapDetector.h
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientConversationListGapHandling
//

#import <Foundation/Foundation.h>
#import "ConversationGapDetector.h"
#import "ConversationHandler.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationGapDetector : NSObject <ConversationGapDetector>

#pragma mark @property declarations
@property (strong, nonatomic) id<ConversationHandler> conversationHandler;

#pragma mark  Class methods

#pragma mark Instance methods

@end
