//
//  YAValidateParticipantsCommand.h
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/25/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
#import "Transport.h"

@protocol ParticipantHandler;
@protocol ParticipantRequestBuilder;
@protocol ParticipantResponseParser;

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAValidateParticipantsCommand : NSObject<Command>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods
- (id)initWithParticipants:(NSArray *)participants
                 transport:(id<Transport>)transport
        participantHandler:(id<ParticipantHandler>)participantHandler
     requestBuilderFactory:(id<ParticipantRequestBuilder>)requestBuilderFactory
     responseParserFactory:(id<ParticipantResponseParser>)responseParserFactory;
@end
