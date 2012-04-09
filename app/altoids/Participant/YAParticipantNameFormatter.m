//
//  YAParticipantNameFormatter.m
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantNameFormatter.h"
#import "YAContact.h"
#import "YAContactPhoneNumberAddress.h"
#import "YAContactEndpoint.h"

#define kDisplayNameFirtLastNameFormat @"%@ %@"

// Private class extension
@interface YAParticipantNameFormatter ()

// @property definitions

// methods
- (NSString *)formattedDisplayNameFromFirstName:(NSString *)theFirstName lastName:(NSString *)theLastName addressHandle:(NSString *)theAddressHandle;
- (NSString *)formattedShortNameFromFirstName:(NSString *)theFirstName lastName:(NSString *)theLastName addressHandle:(NSString *)theAddressHandle;

@end

@implementation YAParticipantNameFormatter

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize participantHandler = participantHandler_;
@synthesize addressHandler = addressHandler_;
@synthesize contactLocator = contactLocator_;

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
#pragma mark ParticipantNameFormatter delegate methods

- (NSString *)formatDisplayNameForParticipant:(YAParticipant *)theParticipant
{
    if ([[self participantHandler] participantIsUser:theParticipant]) {
        return kUserAsOnlyParticipant;
    }
    
    YAContact* contact = [[contactLocator_ contactEndpointMatchingParticipant:theParticipant] contact];
    NSString* firstName = [contact givenName];
    NSString* lastName = [contact familyName];
    
    if ((!firstName || [firstName isEqualToString:@""]) ||
        (!lastName || [lastName isEqualToString:@""])) 
    {
        firstName = [[self participantHandler] firstNameForParticipant:theParticipant];
        lastName = [[self participantHandler] lastNameForParticipant:theParticipant];
    }
    
    NSString* addressHandle = [[self addressHandler] handleForAddress:[[self participantHandler] addressForParticipant:theParticipant]];
    
    return [self formattedDisplayNameFromFirstName:firstName lastName:lastName addressHandle:addressHandle];
}

- (NSString *)formatDisplayNameForParticipantInfo:(YAParticipantInfo *)theParticipantInfo
{
    return [self formattedDisplayNameFromFirstName:[theParticipantInfo firstName] lastName:[theParticipantInfo lastName] addressHandle:[[theParticipantInfo addressInfo] handle]];
}

- (NSString *)formatShortNameForParticipant:(YAParticipant *)theParticipant
{
    if ([[self participantHandler] participantIsUser:theParticipant]) {
        return kUserAsOnlyParticipant;
    }

    YAContact* contact = [[contactLocator_ contactEndpointMatchingParticipant:theParticipant] contact];
    NSString* firstName = [contact givenName];
    NSString* lastName = [contact familyName];
    
    if ((!firstName || [firstName isEqualToString:@""]) ||
        (!lastName || [lastName isEqualToString:@""])) 
    {
        firstName = [[self participantHandler] firstNameForParticipant:theParticipant];
        lastName = [[self participantHandler] lastNameForParticipant:theParticipant];
    }
    
    NSString* addressHandle = [[self addressHandler] handleForAddress:[[self participantHandler] addressForParticipant:theParticipant]];
    
    return [self formattedShortNameFromFirstName:firstName lastName:lastName addressHandle:addressHandle];
}

- (NSString *)formatShortNameForParticipantInfo:(YAParticipantInfo *)theParticipantInfo
{
    return [self formattedShortNameFromFirstName:[theParticipantInfo firstName] lastName:[theParticipantInfo lastName] addressHandle:[[theParticipantInfo addressInfo] handle]];
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
#pragma mark YAParticipantNameFormatter ()

- (NSString *)formattedDisplayNameFromFirstName:(NSString *)theFirstName lastName:(NSString *)theLastName addressHandle:(NSString *)theAddressHandle
{
    if (theFirstName && theLastName) 
    {
        return [NSString stringWithFormat:kDisplayNameFirtLastNameFormat, theFirstName, theLastName];
    }
    
    return [self formattedShortNameFromFirstName:theFirstName lastName:theLastName addressHandle:theAddressHandle];
}

- (NSString *)formattedShortNameFromFirstName:(NSString *)theFirstName lastName:(NSString *)theLastName addressHandle:(NSString *)theAddressHandle
{
    if (theFirstName) 
    {
        return theFirstName;
    }
    
    if (theLastName) 
    {
        return theLastName;
    }
    
    return theAddressHandle;
}

@end
