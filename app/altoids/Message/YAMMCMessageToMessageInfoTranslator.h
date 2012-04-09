//
//  YAMMCMessageToMessageInfoTranslator.h
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCMessageToMessageInfoTranslator.h"
#import "MMCParticipantToParticipantInfoTranslator.h"
#import "SystemMessageDescriptionBuilderCreator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMMCMessageToMessageInfoTranslator : NSObject <MMCMessageToMessageInfoTranslator>

#pragma mark @property declarations
@property (strong, nonatomic) id<MMCParticipantToParticipantInfoTranslator> mmcParticipantToParticipantInfoTranslator;
@property (strong, nonatomic) id<SystemMessageDescriptionBuilderCreator> systemMessageDescriptionBuilderCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
