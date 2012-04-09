//
//  YAMessageFlagRequestDataBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageFlagRequestDataBuilder.h"
#import "MessageHandler.h"
#import "MutableArrayCreator.h"
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
@interface YAMessageFlagRequestDataBuilder : NSObject <MessageFlagRequestDataBuilder>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithMessageHandler:(id<MessageHandler>)theMessageHandler 
         mutableArrayCreator:(id<MutableArrayCreator>)theMutableArrayCreator 
    mutableDictionaryCreator:(id<MutableDictionaryCreator>)theMutableDictionaryCreator;

@end
