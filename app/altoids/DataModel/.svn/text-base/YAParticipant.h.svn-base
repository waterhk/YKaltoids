//
//  YAParticipant.h
//  altoids
//
//  Created by Jon Herron on 11/2/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "YAPerson.h"

@class YAAddress, YAConversation, YAMessage, YAParticipant;

@interface YAParticipant : YAPerson

@property (nonatomic, retain) NSString * participantID;
@property (nonatomic, retain) NSNumber * isUser;
@property (nonatomic, retain) YAAddress *address;
@property (nonatomic, retain) YAConversation *conversation;
@property (nonatomic, retain) YAConversation *conversationSender;
@property (nonatomic, retain) YAParticipant *creator;
@property (nonatomic, retain) NSSet *messages;
@end

@interface YAParticipant (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(YAMessage *)value;
- (void)removeMessagesObject:(YAMessage *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;
@end
