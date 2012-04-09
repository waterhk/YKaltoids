//
//  YAMMCParticipantToParticipantInfoTranslator.h
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressInfoCreator.h"
#import "MMCParticipantToParticipantInfoTranslator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMMCParticipantToParticipantInfoTranslator : NSObject <MMCParticipantToParticipantInfoTranslator>

#pragma mark @property declarations
@property (strong, nonatomic) id<AddressInfoCreator> addressInfoCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
