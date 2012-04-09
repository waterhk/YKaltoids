//
//  YAMMCMessage.m
//  altoids
//
//  Created by Jon Herron on 10/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMMCMessage.h"

#define kMessageKey @"message"
#define kMessageIDKey @"mid"
#define kReadFlagKey @"flags.isRead"
#define kMessageInfoKey @"info"
#define kSubjectKey @"info.subj"
#define kDateKey @"info.date"
#define kMessageDataKey @"data"
#define kMessageDataPartsKey @"data.parts"
#define kParticipantsKey @"conversation.mgrData.participants"
#define kBodyKey @"message.content"
#define kSenderPIDKey @"sender.pid"
#define kPIDKey @"pid"

// Private class extension
@interface YAMMCMessage ()

// @property definitions
@property (copy,   nonatomic) NSDictionary *parsedJSONMessageResponse;
@property (strong, nonatomic) NSDictionary *messageData;
@property (strong, nonatomic) YAMMCParticipant *senderCache;

// methods

@end

@implementation YAMMCMessage

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize parsedJSONMessageResponse = parsedJSONMessageResponse_;
@synthesize messageData = messageData_;
@synthesize senderCache = senderCache_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithParsedJSONMessageResponse:(NSDictionary *)theParsedJSONMessageResponse
{
  self = [super init];
    
  if (self) 
  {
      parsedJSONMessageResponse_ = [[theParsedJSONMessageResponse objectForKey:kMessageKey] copy];
      messageData_ = [[[parsedJSONMessageResponse_ valueForKeyPath:kMessageDataPartsKey] objectAtIndex:0] objectForKey:kMessageDataKey];
  }
  
  return self;
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

- (NSString *)messageID
{
    return [[self parsedJSONMessageResponse] objectForKey:kMessageIDKey];
}

- (BOOL)read
{
    return [[[self parsedJSONMessageResponse] valueForKeyPath:kReadFlagKey] boolValue];
}

- (NSString *)subject
{
    return [[self parsedJSONMessageResponse] valueForKeyPath:kSubjectKey];
}

- (NSDate *)timestamp
{
    return [NSDate dateWithTimeIntervalSince1970:[[[self parsedJSONMessageResponse] valueForKeyPath:kDateKey] doubleValue]];
}

- (YAMMCParticipant *)sender
{
    if ([self senderCache]) 
    {
        return [self senderCache];
    }
    
    NSArray *participants = nil;
    NSString *participantPID = nil;
    NSString *senderPID = nil;
    YAMMCParticipant *sender = nil;
    
    senderPID = [[self messageData] valueForKeyPath:kSenderPIDKey];
    participants = [[self messageData] valueForKeyPath:kParticipantsKey];
    
    for (NSDictionary *participant in participants) 
    {
        if (!(participantPID = [participant objectForKey:kPIDKey])) 
        {
            continue;
        }
        
        if ([participantPID isEqualToString:senderPID]) 
        {
            sender = [[YAMMCParticipant alloc] initWithParsedJSONParticipantResponse:participant];
            
            break;
        }
    }
    
    [self setSenderCache:sender];
    
    return sender;
}

- (NSString *)body
{
    return [[self messageData] valueForKeyPath:kBodyKey];
}

- (BOOL) isMessageIdOnly
{
    if ([[self messageID] length] && ![[self parsedJSONMessageResponse] valueForKey:kMessageDataKey]
        && ![[self parsedJSONMessageResponse] valueForKey:kMessageInfoKey])
        return YES;
    
    return NO;
}

- (NSDictionary *)messageData
{
    return messageData_;
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAMMCMessage ()

@end
