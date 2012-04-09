//
//  YASystemMessageDescriptionBuilder.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 11/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemMessageDescriptionBuilder.h"
#import "MMCParticipantToParticipantInfoTranslator.h"
#import "ParticipantNameFormatter.h"
#import "MutableArrayCreator.h"
#import "ParticipantDescriptionBuilder.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YASystemMessageDescriptionBuilder : NSObject<SystemMessageDescriptionBuilder>

#pragma mark @property declarations
@property (strong, nonatomic, readonly) NSString *systemMessage;

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithCanonicalMessageData:(NSDictionary *)theCanonicalMessageData 
mmcParticipantToParticipantInfoTranslator:(id<MMCParticipantToParticipantInfoTranslator>)anMMCParticipantToParticipantInfoTranslator
          participantNameFormatter:(id<ParticipantNameFormatter>)aParticipantNameFormatter
               mutableArrayCreator:(id<MutableArrayCreator>)aMutableArrayCreator
     participantDescriptionBuilder:(id<ParticipantDescriptionBuilder>)aParticipantDescriptionBuilder;

@end
