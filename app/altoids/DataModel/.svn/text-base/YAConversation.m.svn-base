//
//  YAConversation.m
//  altoids
//
//  Created by Jon Herron on 11/2/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import "YAConversation.h"
#import "YAConversationContext.h"
#import "YAMessage.h"
#import "YAParticipant.h"


@implementation YAConversation

@dynamic conversationID;
@dynamic status;
@dynamic timestamp;
@dynamic topic;
@dynamic totalMessages;
@dynamic unreadMessages;
@dynamic isMuted;
@dynamic conversationContext;
@dynamic messages;
@dynamic mostRecentMessage;
@dynamic participants;
@dynamic sender;
@dynamic hasUser;

- (BOOL)hasUser
{
    NSArray *participants = [[self participants] allObjects];
    
    for (YAParticipant *participant in participants) {
        if ([participant isUser]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSString *)debugDescription
{
    return [super description];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"conversationID:%@\nmessage:%@\nparticipants:[(\n%@)]\nsender:{\n%@}\ntimestamp:%@",
            [self conversationID],
            [self valueForKeyPath:@"messages.body"],
            [[[self participants] allObjects] componentsJoinedByString:@"\n"],
            [self sender],
            [self timestamp]];
}

@end
