//
//  YAMessageInfo.h
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAParticipantInfo.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMessageInfo : NSObject

#pragma mark @property declarations
@property (copy,   nonatomic, readonly) NSString *messageID;
@property (copy,   nonatomic, readonly) NSString *body;
@property (assign, nonatomic, readonly) BOOL read;
@property (copy,   nonatomic, readonly) NSString *snippet;
@property (copy,   nonatomic, readonly) NSDate *timestamp;
@property (copy,   nonatomic, readonly) NSString *rawSenderString;
@property (strong, nonatomic, readonly) YAParticipantInfo *sender;
@property (copy,   nonatomic, readonly) NSString *recipients;
@property (assign, nonatomic, readonly, getter=isMessageIdOnly) BOOL messageIdOnly;
@property (assign, nonatomic, readonly) BOOL isSystemMessage;
@property (copy, nonatomic, readonly) NSString *systemMessage;

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithMessageID:(NSString *)aMessageID 
                   body:(NSString *)aBody
                   read:(BOOL)aRead 
                snippet:(NSString *)aSnippet
              timestamp:(NSDate *)aTimestamp
        rawSenderString:(NSString *)aRawSenderString 
                 sender:(YAParticipantInfo *)aSender 
             recipients:(NSString *)aRecipients
        isSystemMessage:(BOOL)isSystemMessage
          systemMessage:(NSString *)aSystemMessage;

- (id)initWithMessageID:(NSString *)aMessageID;

@end
