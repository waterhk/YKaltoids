//
//  YAMessageInfo.m
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageInfo.h"

// Private class extension
@interface YAMessageInfo ()

// @property definitions
@property (copy,   nonatomic) NSString *messageID;
@property (copy,   nonatomic) NSString *body;
@property (assign, nonatomic) BOOL read;
@property (copy,   nonatomic) NSString *snippet;
@property (copy,   nonatomic) NSDate *timestamp;
@property (copy,   nonatomic) NSString *rawSenderString;
@property (strong, nonatomic) YAParticipantInfo *sender;
@property (copy,   nonatomic) NSString *recipients;
@property (assign, nonatomic) BOOL messageIdOnly;
@property (assign, nonatomic) BOOL isSystemMessage;
@property (copy, nonatomic) NSString *systemMessage;

// methods

@end

@implementation YAMessageInfo

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize messageID = messageID_;
@synthesize body = body_;
@synthesize read = read_;
@synthesize snippet = snippet_;
@synthesize timestamp = timestamp_;
@synthesize rawSenderString = rawSenderString_;
@synthesize sender = sender_;
@synthesize recipients = recipients_;
@synthesize messageIdOnly = messageIdOnly_;
@synthesize isSystemMessage = isSystemMessage_;
@synthesize systemMessage = systemMessage_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithMessageID:(NSString *)aMessageID 
                   body:(NSString *)aBody
                   read:(BOOL)aRead 
                snippet:(NSString *)aSnippet
              timestamp:(NSDate *)aTimestamp
        rawSenderString:(NSString *)aRawSenderString 
                 sender:(YAParticipantInfo *)aSender 
             recipients:(NSString *)aRecipients
        isSystemMessage:(BOOL)isSystemMessage
          systemMessage:(NSString *)aSystemMessage
{
  self = [super init];
    
  if (self) 
  {
      messageID_ = [aMessageID copy];
      body_ = [aBody copy];
      read_ = aRead;
      snippet_ = [aSnippet copy];
      timestamp_ = [aTimestamp copy];
      rawSenderString_ = [aRawSenderString copy];
      sender_ = aSender;
      recipients_ = [aRecipients copy];
      messageIdOnly_ = NO;
      isSystemMessage_ = isSystemMessage;
      systemMessage_ = [aSystemMessage copy];
  }
  
  return self;
}

- (id)initWithMessageID:(NSString *)aMessageID
{
    self = [self initWithMessageID:aMessageID body:nil read:NO snippet:nil timestamp:nil rawSenderString:nil sender:nil recipients:nil isSystemMessage:NO systemMessage:nil];
    
    if (self) {
        messageIdOnly_ = YES;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\t{\n\t\tmessageID:%@\n\t\tbody:%@\n\t\tread:%@\n\t\tsnippet:%@\n\t\ttimestamp:%@\n\t\trawSenderString:%@\n\t\tsender:%@\n\t\trecipients:%@\n\t\tmessageIdOnly:%@\n\t\tisSystemMessage:%@\n\t\tsystemMessage:%@\n}\n",
            messageID_,
            body_,
            (read_)?@"YES":@"NO",
            snippet_,
            timestamp_,
            rawSenderString_,
            sender_,
            recipients_,
            (isSystemMessage_)?@"YES":@"NO",
            systemMessage_];
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAMessageInfo ()

@end
