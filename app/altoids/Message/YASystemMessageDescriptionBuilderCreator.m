//
//  YASystemMessageDescriptionBuilderCreator.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 11/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YASystemMessageDescriptionBuilderCreator.h"
#import "YASystemMessageDescriptionBuilder.h"

// Private class extension
@interface YASystemMessageDescriptionBuilderCreator ()

// @property definitions

// methods

@end

@implementation YASystemMessageDescriptionBuilderCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize participantNameFormatter = participantNameFormatter_;
@synthesize mutableArrayCreator = mutableArrayCreator_;
@synthesize participantDescriptionBuilder = participantDescriptionBuilder_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

- (id<SystemMessageDescriptionBuilder>)createSystemMessageDescriptionBuilderWithCanonicalMessageData:(NSDictionary *)theCanonicalMessageData mmcParticipantToParticipantInfoTranslator:(id<MMCParticipantToParticipantInfoTranslator>)anMMCParticipantToParticipantInfoTranslator
{
    return [[YASystemMessageDescriptionBuilder alloc] initWithCanonicalMessageData:theCanonicalMessageData 
                                         mmcParticipantToParticipantInfoTranslator:anMMCParticipantToParticipantInfoTranslator 
                                                          participantNameFormatter:[self participantNameFormatter] 
                                                               mutableArrayCreator:[self mutableArrayCreator]
                                                     participantDescriptionBuilder:[self participantDescriptionBuilder]];
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
#pragma mark YASystemMessageDescriptionBuilderCreator ()

@end
