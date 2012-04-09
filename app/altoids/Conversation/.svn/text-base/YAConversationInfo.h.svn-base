//
//  YAConversationInfo.h
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationStatus.h"
#import "YAConversationContextInfo.h"
#import "YAMessageInfo.h"
#import "YAParticipantInfo.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationInfo : NSObject

#pragma mark @property declarations
@property (copy,   nonatomic, readonly) NSString *conversationID;
@property (assign, nonatomic, readonly) YAConversationStatus status;
@property (copy,   nonatomic, readonly) NSDate *timestamp;
@property (copy,   nonatomic, readonly) NSString *topic;
@property (strong, nonatomic, readonly) NSNumber *totalMessages;
@property (strong, nonatomic, readonly) NSNumber *unreadMessages;
@property (strong, nonatomic, readonly) YAConversationContextInfo *conversationContextInfo;
@property (copy,   nonatomic, readonly) NSArray *messageInfos;
@property (copy,   nonatomic, readonly) NSArray *participantInfos;
@property (copy,   nonatomic, readonly) NSDictionary *participantInfosByTransientID;
@property (strong, nonatomic, readonly) YAParticipantInfo *sender;
@property (strong, nonatomic, readonly) YAMessageInfo *mostRecentMessageInfo;
@property (assign, nonatomic, readonly) BOOL userIsParticipant;

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithConversationID:(NSString *)aConversationID
                      status:(YAConversationStatus)aStatus
                   timestamp:(NSDate *)aTimestamp
                       topic:(NSString *)aTopic
               totalMessages:(NSNumber *)aTotalMessages
              unreadMessages:(NSNumber *)anUnreadMessages
     conversationContextInfo:(YAConversationContextInfo *)aConversationContextInfo
                messageInfos:(NSArray *)aMessageInfos
            participantInfos:(NSArray *)aParticipantInfos
participantInfosByTransientID:(NSDictionary *)aParticipantInfosByTransientID 
                      sender:(YAParticipantInfo *)aSender
       mostRecentMessageInfo:(YAMessageInfo *)aMostRecentMessageInfo
           userIsParticipant:(BOOL)aUserIsParticipant;

@end
