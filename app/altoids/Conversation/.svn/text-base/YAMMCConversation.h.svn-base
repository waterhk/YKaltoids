//
//  YAConversationFacade.h
//  altoids
//
//  Created by Jon Herron on 9/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientServerResponseFacades
//

#import <Foundation/Foundation.h>
#import "YAMMCRecentMessage.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMMCConversation : NSObject

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithParsedJSONConversationResponse:(NSDictionary *)aParsedJSONConversationResponse;

- (NSString *)conversationID;
- (NSString *)topic;
- (NSNumber *)totalMessages;
- (NSNumber *)unreadMessages;
- (BOOL)userIsParticipant;

- (NSArray *)participants;
- (NSDictionary *)participantIDToTransientIDMap;

- (YAMMCRecentMessage *)recentMessage;
- (NSArray *)messages;

- (NSArray *)errors;

@end
