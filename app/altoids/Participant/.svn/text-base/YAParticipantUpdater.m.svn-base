//
//  YAParticipantUpdater.m
//  altoids
//
//  Created by Jon Herron on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantUpdater.h"

// Private class extension
@interface YAParticipantUpdater ()

// @property definitions

// methods

@end

@implementation YAParticipantUpdater

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize participantTransientIDFormatter = participantTransientIDFormatter_;
@synthesize participantHandler = participantHandler_;

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
#pragma mark ParticipantUpdater delegate methods

- (void)updateParticipant:(YAParticipant *)theParticipant fromParticipantInfo:(YAParticipantInfo *)theParticipantInfo withAddress:(YAAddress *)theAddress
{
    NSParameterAssert(theParticipant);
    NSParameterAssert(theParticipantInfo);
    NSParameterAssert(theAddress);
    
    NSString *participantID;
    
    [[self participantHandler] setAddress:theAddress forParticipant:theParticipant];
    [[self participantHandler] setFirstName:[theParticipantInfo firstName] forParticipant:theParticipant];
    [[self participantHandler] setLastName:[theParticipantInfo lastName] forParticipant:theParticipant];
    [[self participantHandler] setTimestamp:[theParticipantInfo timestamp] forParticipant:theParticipant];
    [[self participantHandler] setPhotoURL:[theParticipantInfo imageURL] forParticipant:theParticipant];
    [[self participantHandler] setIsUser:[theParticipantInfo isUser] forParticipant:theParticipant];
    
    participantID = [theParticipantInfo participantID];
    
    if (!participantID) 
    {
        participantID = [[self participantTransientIDFormatter] transientIDForParticipant:theParticipant];
    }
    
    [[self participantHandler] setParticipantID:participantID forParticipant:theParticipant];
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
#pragma mark YAParticipantUpdater ()

@end
