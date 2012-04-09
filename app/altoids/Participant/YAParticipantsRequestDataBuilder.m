//
//  YAParticipantsRequestDataBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantsRequestDataBuilder.h"
#import "YAParticipant.h"

// Private class extension
@interface YAParticipantsRequestDataBuilder ()

// @property definitions

// methods

@end

@implementation YAParticipantsRequestDataBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize participantRequestDataBuilder = participantRequestDataBuilder_;
@synthesize mutableArrayCreator = mutableArrayCreator_;

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
#pragma mark ParticipantsRequestDataBuilder delegate methods

- (NSArray *)requestDataForParticipants:(NSSet *)theParticipants
{
    NSMutableArray *participantsRequestData = [[self mutableArrayCreator] mutableArrayWithCapacity:[theParticipants count]];
    
    for (YAParticipant *participant in theParticipants)
    {
        [participantsRequestData addObject:[[self participantRequestDataBuilder] requestDataForParticipant:participant]];
    }
    
    return participantsRequestData;
}

- (NSArray *)requestDataForSendingParticipantsByID:(NSArray *)theParticipants
{
    NSMutableArray *participantsRequestData = [[self mutableArrayCreator] mutableArrayWithCapacity:[theParticipants count]];
    
    for (YAParticipant *participant in theParticipants) 
    {
        [participantsRequestData addObject:[[self participantRequestDataBuilder] requestDataForSendingParticipantByPID:participant]];
    }
    
    return participantsRequestData;
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
#pragma mark YAParticipantsRequestDataBuilder ()

@end
