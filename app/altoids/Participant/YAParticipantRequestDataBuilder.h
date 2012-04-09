//
//  YAParticipantRequestDataBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParticipantRequestDataBuilder.h"
#import "ParticipantTransientIDFormatter.h"
#import "ParticipantHandler.h"
#import "MutableDictionaryCreator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAParticipantRequestDataBuilder : NSObject <ParticipantRequestDataBuilder>

#pragma mark @property declarations
@property (strong, nonatomic) id<ParticipantHandler> participantHandler;
@property (strong, nonatomic) id<MutableDictionaryCreator> mutableDictionaryCreator;
@property (strong, nonatomic) id<ParticipantTransientIDFormatter> participantTransientIDFormatter;

#pragma mark  Class methods

#pragma mark Instance methods

@end
