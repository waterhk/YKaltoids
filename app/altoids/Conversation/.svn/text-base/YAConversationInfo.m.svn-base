//
//  YAConversationInfo.m
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationInfo.h"

// Private class extension
@interface YAConversationInfo ()

// @property definitions
@property (copy,   nonatomic) NSString *conversationID;
@property (assign, nonatomic) YAConversationStatus status;
@property (copy,   nonatomic) NSDate *timestamp;
@property (copy,   nonatomic) NSString *topic;
@property (strong, nonatomic) NSNumber *totalMessages;
@property (strong, nonatomic) NSNumber *unreadMessages;
@property (strong, nonatomic) YAConversationContextInfo *conversationContextInfo;
@property (copy,   nonatomic) NSArray *messageInfos;
@property (copy,   nonatomic) NSArray *participantInfos;
@property (copy,   nonatomic) NSDictionary *participantInfosByTransientID;
@property (strong, nonatomic) YAParticipantInfo *sender;
@property (strong, nonatomic) YAMessageInfo *mostRecentMessageInfo;
@property (assign, nonatomic) BOOL userIsParticipant;

// methods

@end

@implementation YAConversationInfo

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize conversationID = conversationID_;
@synthesize status = status_;
@synthesize timestamp = timestamp_;
@synthesize topic = topic_;
@synthesize totalMessages = totalMessages_;
@synthesize unreadMessages = unreadMessages_;
@synthesize conversationContextInfo = conversationContextInfo_;
@synthesize messageInfos = messageInfos_;
@synthesize participantInfos = particpantInfos_;
@synthesize participantInfosByTransientID = participantInfosByTransientID_;
@synthesize sender = sender_;
@synthesize mostRecentMessageInfo = mostRecentMessageInfo_;
@synthesize userIsParticipant = userIsParticipant_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

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
           userIsParticipant:(BOOL)aUserIsParticipant
{
  self = [super init];
    
  if (self) 
  {
      conversationID_ = [aConversationID copy];
      status_ = aStatus;
      timestamp_ = [aTimestamp copy];
      topic_ = [aTopic copy];
      totalMessages_ = aTotalMessages;
      unreadMessages_ = anUnreadMessages;
      conversationContextInfo_ = aConversationContextInfo;
      messageInfos_ = [aMessageInfos copy];
      particpantInfos_ = [aParticipantInfos copy];
      participantInfosByTransientID_ = [aParticipantInfosByTransientID copy];
      sender_ = aSender;
      mostRecentMessageInfo_ = aMostRecentMessageInfo;
      userIsParticipant_ = aUserIsParticipant;
  }
  
  return self;
}

- (NSString *)debugDescription
{
    return [self description];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"{\n\tconversationID:%@\n\tmessage:%@\n\tparticipants:[(\n%@\t)]\n\tsender:\n%@\n\ttimestamp:%@\n}",
            [self conversationID],
            [[self messageInfos] componentsJoinedByString:@"\n"],
            [[self participantInfos] componentsJoinedByString:@"\n"],
            [self sender],
            [self timestamp]];
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAConversationInfo ()

@end
