//
//  YAParticipantNameFormatter.h
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParticipantNameFormatter.h"
#import "ParticipantHandler.h"
#import "AddressHandler.h"
#import "ContactLocator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAParticipantNameFormatter : NSObject <ParticipantNameFormatter>

#pragma mark @property declarations
@property (strong, nonatomic) id<AddressHandler> addressHandler;
@property (strong, nonatomic) id<ParticipantHandler> participantHandler;
@property (strong, nonatomic) id<ContactLocator> contactLocator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
