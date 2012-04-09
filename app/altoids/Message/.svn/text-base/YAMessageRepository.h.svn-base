//
//  YAMessageRepository.h
//  altoids
//
//  Created by Jon Herron on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageRepository.h"
#import "MessageHandler.h"
#import "MessageDeleter.h"
#import "ParticipantRepository.h"
#import "MessageErrorCreator.h"
#import "MessageUpdater.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMessageRepository : NSObject <MessageRepository>

#pragma mark @property declarations
@property (strong, nonatomic) id<MessageHandler> messageHandler;
@property (strong, nonatomic) id<MessageDeleter> messageDeleter;
@property (strong, nonatomic) id<ParticipantRepository> participantRepository;
@property (strong, nonatomic) id<MessageErrorCreator> messageErrorCreator;
@property (strong, nonatomic) id<MessageUpdater> messageUpdater;

#pragma mark  Class methods

#pragma mark Instance methods

@end
