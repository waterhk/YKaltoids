//
//  YAMessageUpdater.h
//  altoids
//
//  Created by Jon Herron on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageUpdater.h"
#import "MessageHandler.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMessageUpdater : NSObject <MessageUpdater>

#pragma mark @property declarations
@property (strong, nonatomic) id<MessageHandler> messageHandler;

#pragma mark  Class methods

#pragma mark Instance methods

@end
