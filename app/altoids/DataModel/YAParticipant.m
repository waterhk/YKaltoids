//
//  YAParticipant.m
//  altoids
//
//  Created by Jon Herron on 11/2/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import "YAParticipant.h"
#import "YAAddress.h"
#import "YAConversation.h"
#import "YAMessage.h"
#import "YAParticipant.h"


@implementation YAParticipant

@dynamic participantID;
@dynamic isUser;
@dynamic address;
@dynamic conversation;
@dynamic conversationSender;
@dynamic creator;
@dynamic messages;

- (NSString *)debugDescription
{
    return [super description];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\tparticipantID:%@\n\tfirstName:%@\n\tlastName:%@\n\tphotoURL:%@\n\tisUser:%@\n\taddress:%@\n",
            [self participantID],
            [self firstName],
            [self lastName],
            [self photoUrl],
            ([[self isUser] boolValue] ? @"YES":@"NO"),
            [[self address] handle]];    
}

@end
