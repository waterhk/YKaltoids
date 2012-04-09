//
//  YAConversation.h
//  altoids
//
//  Created by Jon Herron on 11/2/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YAConversationContext, YAMessage, YAParticipant;

@interface YAConversation : NSManagedObject

@property (nonatomic, retain) NSString * conversationID;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * topic;
@property (nonatomic, retain) NSNumber * totalMessages;
@property (nonatomic, retain) NSNumber * unreadMessages;
@property (nonatomic, retain) NSNumber * isMuted;
@property (nonatomic, retain) YAConversationContext *conversationContext;
@property (nonatomic, retain) NSSet *messages;
@property (nonatomic, retain) YAMessage *mostRecentMessage;
@property (nonatomic, retain) NSSet *participants;
@property (nonatomic, retain) YAParticipant *sender;
@property (nonatomic, assign, readonly) BOOL hasUser;
@end

@interface YAConversation (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(YAMessage *)value;
- (void)removeMessagesObject:(YAMessage *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;
- (void)addParticipantsObject:(YAParticipant *)value;
- (void)removeParticipantsObject:(YAParticipant *)value;
- (void)addParticipants:(NSSet *)values;
- (void)removeParticipants:(NSSet *)values;
@end
