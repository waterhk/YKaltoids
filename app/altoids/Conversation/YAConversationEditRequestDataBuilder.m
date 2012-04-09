//
//  YAConversationEditRequestDataBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationEditRequestDataBuilder.h"

#define kConversationEditParticipantsKey @"participants"
#define kConversationEditAddParticipantsKey @"add"
#define kConversationEditRemoveParticipantsKey @"delete"

#define kConversationEditParticipantsContainerCount 1

// Private class extension
@interface YAConversationEditRequestDataBuilder ()

// @property definitions

// methods

@end

@implementation YAConversationEditRequestDataBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;
@synthesize participantsRequestDataBuilder = participantsRequestDataBuilder_;

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
#pragma mark ConversationEditRequestDataBuilder delegate methods

- (NSDictionary *)requestDataForEditingConversationWithAdditionalParticipants:(NSArray *)theAdditionalParticipants removedParticipants:(NSArray *)theRemovedParticipants
{
    BOOL participantsToAdd;
    BOOL participantsToRemove;
    NSArray *participantsToAddRequestData;
    NSArray *participantsToRemoveRequestData;
    NSMutableDictionary *participantManagementRequestData;
    NSMutableDictionary *requestData;
    NSUInteger participantManagementDictionaryCapacity;
    NSUInteger participantsToAddCount;
    NSUInteger participantsToRemoveCount;
    
    participantManagementDictionaryCapacity = 0;
    
    participantsToAddCount = [theAdditionalParticipants count];
    participantsToAdd = participantsToAddCount > 0;
    
    if (participantsToAdd) 
    {
        ++participantManagementDictionaryCapacity;
    }
    
    participantsToRemoveCount = [theRemovedParticipants count];
    participantsToRemove = participantsToRemoveCount > 0;
    
    if (participantsToRemove) 
    {
        ++participantManagementDictionaryCapacity;
    }
    
    requestData = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:kConversationEditParticipantsContainerCount];
    
    participantManagementRequestData = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:participantManagementDictionaryCapacity];
    
    if (participantsToAdd) 
    {
        participantsToAddRequestData = [[self participantsRequestDataBuilder] requestDataForParticipants:[NSSet setWithArray:theAdditionalParticipants]];
        
        [participantManagementRequestData setObject:participantsToAddRequestData forKey:kConversationEditAddParticipantsKey];
    }
    
    if (participantsToRemove) 
    {
        participantsToRemoveRequestData = [[self participantsRequestDataBuilder] requestDataForSendingParticipantsByID:theRemovedParticipants];
        
        [participantManagementRequestData setObject:participantsToRemoveRequestData forKey:kConversationEditRemoveParticipantsKey];
    }
    
    [requestData setObject:participantManagementRequestData forKey:kConversationEditParticipantsKey];
    
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
#pragma mark YAConversationEditRequestDataBuilder ()

@end
