//
//  YAParticipantCreator.m
//  altoids
//
//  Created by Jon Herron on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantCreator.h"

// Private class extension
@interface YAParticipantCreator ()

// @property definitions

// methods

@end

@implementation YAParticipantCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize addressRepository = addressRepository_;
@synthesize participantHandler = participantHandler_;
@synthesize participantErrorCreator = participantErrorCreator_;
@synthesize participantUpdater = participantUpdater_;

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
#pragma mark ParticipantCreator delegate methods

- (YAParticipant *)participantFromParticipantInfo:(YAParticipantInfo *)theParticipantInfo inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext error:(NSError **)anError
{
    NSParameterAssert(theParticipantInfo);
    NSParameterAssert(theManagedObjectContext);
    NSParameterAssert(anError);
    
    NSError *error;
    YAAddress *address;
    YAParticipant *participant;
    
    participant = [[self participantHandler] createParticipantEntityInManagedObjectContext:theManagedObjectContext];
    
    address = [[self addressRepository] createAddressFromAddressInfo:[theParticipantInfo addressInfo] inManagedObjectContext:theManagedObjectContext error:&error];
    
    if (!address) 
    {
        *anError = [[self participantErrorCreator] errorWithCode:YAParticipantErrorCodeFailedToCreateParticipantLocally underlyingError:error];
        
        return nil;
    }
    
    [[self participantUpdater] updateParticipant:participant fromParticipantInfo:theParticipantInfo withAddress:address];
    
    return participant;
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
#pragma mark YAParticipantCreator ()

@end
