//
//  YAParticipantCommandFactory.h
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/26/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParticipantCommandFactory.h"

@protocol TransportFactory;
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
@interface YAParticipantCommandFactory : NSObject<ParticipantCommandFactory>

#pragma mark @property declarations
@property (nonatomic, strong) id<TransportFactory> transportFactory;
@property (nonatomic, strong) id<ParticipantHandler> participantHandler;
@property (nonatomic, strong) id<ParticipantRequestBuilder> participantRequestBuilderFactory;
@property (nonatomic, strong) id<ParticipantResponseParser> participantResponseParserFactory;

#pragma mark  Class methods

#pragma mark Instance methods

@end
