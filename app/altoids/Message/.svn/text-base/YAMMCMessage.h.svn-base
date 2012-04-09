//
//  YAMMCMessage.h
//  altoids
//
//  Created by Jon Herron on 10/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAMMCParticipant.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMMCMessage : NSObject

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithParsedJSONMessageResponse:(NSDictionary *)theParsedJSONMessageResponse;

@property (nonatomic, readonly) NSString *messageID;
@property (nonatomic, readonly) BOOL read;
@property (nonatomic, readonly) NSString *subject;
@property (nonatomic, readonly) NSDate *timestamp;
@property (nonatomic, readonly) YAMMCParticipant *sender;
@property (nonatomic, readonly) NSString *body;
@property (nonatomic, readonly, getter = isMessageIdOnly) BOOL messageIdOnly;
@property (strong, nonatomic, readonly) NSDictionary *messageData;

@end
