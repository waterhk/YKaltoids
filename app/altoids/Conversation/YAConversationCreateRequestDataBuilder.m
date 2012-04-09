//
//  YAConversationCreateRequestDataBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationCreateRequestDataBuilder.h"

#define kConversationCreatorInfoKey @"creatorInfo"
#define kConversationMessageKey @"message"
#define kConversationParticipantsKey @"participants"
#define kConversationCreateRequestDataDictionarySize 3

// Private class extension
@interface YAConversationCreateRequestDataBuilder ()

// @property definitions

// methods

@end

@implementation YAConversationCreateRequestDataBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize participantsRequestDataBuilder = participantsRequestDataBuilder_;
@synthesize conversationHandler = conversationHandler_;
@synthesize messageHandler = messageHandler_;
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;
@synthesize participantRequestDataBuilder = participantRequestDataBuilder_;

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
#pragma mark ConversationCreateRequestDataBuilder delegate methods

- (NSDictionary *)requestDataForConversation:(YAConversation *)theConversation
{
    NSArray *participantsRequestData = nil;
    NSDictionary *creatorInfo = nil;
    NSMutableDictionary *requestData;
    NSSet *participants;
    NSString *messageBody = nil;
    YAParticipant *sender = nil;
    
    requestData = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:kConversationCreateRequestDataDictionarySize];
    sender = [[self conversationHandler] senderForConversation:theConversation];
    participants = [[self conversationHandler] participantsForConversation:theConversation];
    messageBody = [[self messageHandler] bodyForMessage:[[[self conversationHandler] messagesForConversation:theConversation] anyObject]];
    
    creatorInfo = [[self participantRequestDataBuilder] requestDataForParticipant:sender];
    participantsRequestData = [[self participantsRequestDataBuilder] requestDataForParticipants:participants];
    
    [requestData setObject:creatorInfo forKey:kConversationCreatorInfoKey];
    [requestData setObject:messageBody forKey:kConversationMessageKey];
    [requestData setObject:participantsRequestData forKey:kConversationParticipantsKey];
    
    return requestData;
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
#pragma mark YAConversationCreateRequestDataBuilder ()

@end
