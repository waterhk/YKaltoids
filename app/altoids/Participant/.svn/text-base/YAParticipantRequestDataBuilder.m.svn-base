//
//  YAParticipantRequestDataBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantRequestDataBuilder.h"
#import "YAParticipant.h"

#define kParticipantRequestDataFirstNameKey @"firstname"
#define kParticipantRequestDataLastNameKey @"lastname"
#define kParticipantRequestDataParticipantIDKey @"pid"
#define kParticipantRequestDataTransientIDKey @"id"
#define kParticipantRequestDataSize 3
#define kParticipantByPIDRequestDataSize 1

// Private class extension
@interface YAParticipantRequestDataBuilder ()

// @property definitions

// methods

@end

@implementation YAParticipantRequestDataBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize participantHandler = participantHandler_;
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;
@synthesize participantTransientIDFormatter = participantTransientIDFormatter_;

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
#pragma mark ParticipantRequestDataBuilder delegate methods

- (NSDictionary *)requestDataForParticipant:(YAParticipant *)theParticipant
{
    NSMutableDictionary *requestData = nil;
    NSString *participantFirstName = nil;
    NSString *participantLastName = nil;
    NSString *participantID = nil;
    
    requestData = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:kParticipantRequestDataSize];
    
    participantFirstName = [[self participantHandler] firstNameForParticipant:theParticipant];
    
    if ([participantFirstName length] > 0)
    {
        [requestData setObject:participantFirstName forKey:kParticipantRequestDataFirstNameKey];
    }
    
    participantLastName = [[self participantHandler] lastNameForParticipant:theParticipant];
    
    if ([participantLastName length] > 0)
    {
        [requestData setObject:participantLastName forKey:kParticipantRequestDataLastNameKey];
    }
    
    participantID = [[self participantHandler] participantIDForParticipant:theParticipant];
    
    if (!participantID) 
    {
        participantID = [[self participantTransientIDFormatter] transientIDForParticipant:theParticipant];
    }
    
    if (participantID) 
    {
        [requestData setObject:participantID forKey:kParticipantRequestDataTransientIDKey];
    }
    
    return requestData;
}

- (NSDictionary *)requestDataForSendingParticipantByPID:(YAParticipant *)theParticipant
{
    NSMutableDictionary *requestData;
    NSString *participantID;

    requestData = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:kParticipantByPIDRequestDataSize];
    participantID = [[self participantHandler] participantIDForParticipant:theParticipant];
    
    [requestData setObject:participantID forKey:kParticipantRequestDataParticipantIDKey];
    
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
#pragma mark YAParticipantRequestDataBuilder ()

@end
