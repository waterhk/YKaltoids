//
//  YAMMCMessageToMessageInfoTranslator.m
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMMCMessageToMessageInfoTranslator.h"

// Private class extension
@interface YAMMCMessageToMessageInfoTranslator ()

// @property definitions

// methods

@end

@implementation YAMMCMessageToMessageInfoTranslator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize mmcParticipantToParticipantInfoTranslator = mmcParticipantToParticipantInfoTranslator_;
@synthesize systemMessageDescriptionBuilderCreator = systemMessageDescriptionBuilderCreator_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark MMCMessageToMessageInfoTranslator delegate methods

- (YAMessageInfo *)messageInfoFromMMCRecentMessage:(YAMMCRecentMessage *)anMMCRecentMessage
{
    return [self messageInfoFromMMCRecentMessage:anMMCRecentMessage withSender:nil];
}

- (YAMessageInfo *)messageInfoFromMMCRecentMessage:(YAMMCRecentMessage *)anMMCRecentMessage withSender:(YAParticipantInfo *)theSender
{
    return [[YAMessageInfo alloc] initWithMessageID:[anMMCRecentMessage messageID] 
                                               body:nil 
                                               read:NO 
                                            snippet:[anMMCRecentMessage snippet] 
                                          timestamp:[anMMCRecentMessage sent] 
                                    rawSenderString:[anMMCRecentMessage sender] 
                                             sender:theSender 
                                         recipients:[anMMCRecentMessage recipients]
                                    isSystemMessage:NO
                                      systemMessage:nil];
}

- (YAMessageInfo *)messageInfoFromMMCMessage:(YAMMCMessage *)anMMCMessage
{

    YAMessageInfo *messageInfo = nil;
    id<SystemMessageDescriptionBuilder> systemMessageDescriptionBuilder = [[self systemMessageDescriptionBuilderCreator] createSystemMessageDescriptionBuilderWithCanonicalMessageData:[anMMCMessage messageData] mmcParticipantToParticipantInfoTranslator:[self mmcParticipantToParticipantInfoTranslator]];    
    
    if (![anMMCMessage isMessageIdOnly]) {
        YAParticipantInfo *sender = [[self mmcParticipantToParticipantInfoTranslator] participantInfoFromMMCParticipant:[anMMCMessage sender] withTransientID:nil];
    
        messageInfo = [[YAMessageInfo alloc] initWithMessageID:[anMMCMessage messageID] 
                                                          body:[anMMCMessage body] 
                                                          read:[anMMCMessage read] 
                                                       snippet:nil 
                                                     timestamp:[anMMCMessage timestamp] 
                                               rawSenderString:nil 
                                                        sender:sender 
                                                    recipients:nil
                                               isSystemMessage:[systemMessageDescriptionBuilder isSystemMessage] 
                                                 systemMessage:[systemMessageDescriptionBuilder systemMessage]];
    } else {
        messageInfo = [[YAMessageInfo alloc] initWithMessageID:[anMMCMessage messageID]];
    }
    
    return messageInfo;
}

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
#pragma mark YAMMCMessageToMessageInfoTranslator ()

@end
