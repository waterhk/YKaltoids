//
//  YAParticipantCommandFactory.m
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/26/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantCommandFactory.h"
#import "TransportFactory.h"
#import "YAValidateParticipantsCommand.h"

// Private class extension
@interface YAParticipantCommandFactory ()

// @property definitions

// methods

@end

@implementation YAParticipantCommandFactory

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize transportFactory = transportFactory_;
@synthesize participantHandler = participantHandler_;
@synthesize participantRequestBuilderFactory = requestBuilderFactory_;
@synthesize participantResponseParserFactory = responseParserFactory_;

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// Overrides
#pragma mark -
#pragma mark Overrides
- (id<Command>)createValidateParticipantsCommandWithParticipants:(NSArray *)participants
{
    return [[YAValidateParticipantsCommand alloc] initWithParticipants:participants
                                                             transport:[[self transportFactory] inMemoryTransport]
                                                    participantHandler:[self participantHandler]
                                                 requestBuilderFactory:[self participantRequestBuilderFactory]
                                                 responseParserFactory:[self participantResponseParserFactory]];
}

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

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
#pragma mark YAParticipantCommandFactory ()

@end
