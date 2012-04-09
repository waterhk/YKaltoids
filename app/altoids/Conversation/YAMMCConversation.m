//
//  YAConversationFacade.m
//  altoids
//
//  Created by Jon Herron on 9/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientServerResponseFacades
//

#import "YAMMCConversation.h"
#import "YAMMCParticipant.h"
#import "YAMMCMessage.h"

#define kConversationIDKey @"cid"
#define kConversationKey @"conversation"
#define kErrorKey @"error"
#define kErrorsKey @"errors"
#define kErrorCodeKey @"code"
#define kErrorDomainKey @"ns"
#define kErrorLocalizedDescriptionKey @"message"
#define KParticipantsKey @"mgrData.participants"
#define kRecentMessageKey @"recentMsg"
#define kServerTopicKey @"mgrData.sTopic"
#define kTopicKey @"mgrData.topic"
#define kTotalMessagesKey @"summary.totalMsgs"
#define kUnreadMessagesKey @"summary.unreadMsgs"
#define kUserIsParticipantKey @"mgrData.isParticipant"
#define kParticipantIDToTransientIDMap @"participants"
#define kMessagesKey @"messages"

// Private class extension
@interface YAMMCConversation ()

// @property definitions
@property (strong, nonatomic) NSArray *errorsCache;
@property (strong, nonatomic) NSArray *participantFacadeCache;
@property (strong, nonatomic) NSDictionary *participantIDToTransientIDMapCache;
@property (copy,   nonatomic) NSDictionary *parsedConversationResponse;
@property (copy,   nonatomic) NSArray *parsedParticipantIDToTransientIDMap;
@property (strong, nonatomic) YAMMCRecentMessage *recentMessageFacadeCache;
@property (strong, nonatomic) NSArray *messagesCache;

// methods

@end

@implementation YAMMCConversation

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize errorsCache = errorsCache_;
@synthesize participantFacadeCache = participantFacadeCache_;
@synthesize participantIDToTransientIDMapCache = participantIDToTransientIDMapCache_;
@synthesize parsedConversationResponse = parsedConversationResponse_;
@synthesize parsedParticipantIDToTransientIDMap = parsedParticipantIDToTransientIDMap_;
@synthesize recentMessageFacadeCache = recentMessageFacadeCache_;
@synthesize messagesCache = messagesCache_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithParsedJSONConversationResponse:(NSDictionary *)aParsedJSONConversationResponse
{
  self = [super init];
    
  if (self) 
  {
      parsedConversationResponse_ = [[aParsedJSONConversationResponse objectForKey:kConversationKey] copy];
      parsedParticipantIDToTransientIDMap_ = [[aParsedJSONConversationResponse objectForKey:kParticipantIDToTransientIDMap] copy];
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

- (NSString *)conversationID
{
    return [[self parsedConversationResponse] objectForKey:kConversationIDKey];
}

- (NSString *)topic
{
    NSString *topic = nil;
    
    if ([(topic = [[self parsedConversationResponse] valueForKeyPath:kTopicKey]) length] > 0)
    {
        return topic;
    }
    
    return [[self parsedConversationResponse] valueForKeyPath:kServerTopicKey];
}

- (NSNumber *)totalMessages
{
    return [[self parsedConversationResponse] valueForKeyPath:kTotalMessagesKey];
}

- (NSNumber *)unreadMessages
{
    return [[self parsedConversationResponse] valueForKeyPath:kUnreadMessagesKey];
}

- (BOOL)userIsParticipant
{
    NSNumber *userIsParticipant = nil;
    
    if (!(userIsParticipant = [[self parsedConversationResponse] valueForKeyPath:kUserIsParticipantKey])) 
    {
        return YES;
    }
    
    return [userIsParticipant boolValue];
}

- (NSArray *)participants
{
    if ([self participantFacadeCache]) 
    {
        return [self participantFacadeCache];
    }
        
    NSArray *rawParticipants = nil;
    NSMutableArray *facades = nil;
    
    if (!(rawParticipants = [[self parsedConversationResponse] valueForKeyPath:KParticipantsKey])) 
    {
        return nil;
    }
    
    facades = [NSMutableArray arrayWithCapacity:[rawParticipants count]];
    
    for (NSDictionary *rawParticipant in rawParticipants) 
    {
        [facades addObject:[[YAMMCParticipant alloc] initWithParsedJSONParticipantResponse:rawParticipant]];
    }
    
    [self setParticipantFacadeCache:facades];
    
    return facades;
}

- (NSDictionary *)participantIDToTransientIDMap
{
    if ([self participantIDToTransientIDMapCache]) 
    {
        return [self participantIDToTransientIDMapCache];
    }
    
    if (![self parsedParticipantIDToTransientIDMap]) 
    {   
        return nil;
    }

    NSArray *participantIDMap = [self parsedParticipantIDToTransientIDMap];
    NSMutableDictionary *participantIDToTransientIDMap = nil;
    NSString *participantID = nil;
    NSString *transientID = nil;
    YAMMCParticipant *mmcParticipant = nil;
    
    participantIDToTransientIDMap = [NSMutableDictionary dictionaryWithCapacity:[participantIDMap count]];
    
    for (NSDictionary *participantIDMapping in participantIDMap) 
    {
        mmcParticipant = [[YAMMCParticipant alloc] initWithParsedJSONParticipantResponse:participantIDMapping];
        
        if (!(participantID = [mmcParticipant participantID]) || !(transientID = [mmcParticipant transientID])) 
        {   
            continue;
        }
                
        [participantIDToTransientIDMap setObject:transientID forKey:participantID];
    }
    
    [self setParticipantIDToTransientIDMapCache:participantIDToTransientIDMap];
    
    return participantIDToTransientIDMap;
}

- (YAMMCRecentMessage *)recentMessage
{
    if ([self recentMessageFacadeCache]) 
    {
        return [self recentMessageFacadeCache];
    }
    
    NSDictionary *rawRecentMessage = nil;
    YAMMCRecentMessage *facade = nil;
    
    if (!(rawRecentMessage = [[self parsedConversationResponse] objectForKey:kRecentMessageKey])) 
    {
        return nil;
    }
    
    facade = [[YAMMCRecentMessage alloc] initWithParsedJSONRecentMessageResponse:rawRecentMessage];
    
    [self setRecentMessageFacadeCache:facade];
    
    return facade;
}

- (NSArray *)messages
{
    if ([self messagesCache]) 
    {
        return [self messagesCache];
    }
    
    NSArray *rawMessages = nil;
    NSMutableArray *messages = nil;
    
    if (!(rawMessages = [[self parsedConversationResponse] objectForKey:kMessagesKey])) 
    {
        return nil;
    }
    
    messages = [NSMutableArray arrayWithCapacity:[rawMessages count]];
    
    for (NSDictionary *rawMessage in rawMessages) 
    {
        [messages addObject:[[YAMMCMessage alloc] initWithParsedJSONMessageResponse:rawMessage]];
    }
    
    [self setMessagesCache:messages];
    
    return messages;
}

- (NSArray *)errors
{
    if ([self errorsCache]) 
    {
        return [self errorsCache];
    }
    
    NSArray *rawErrors = nil;
    NSDictionary *rawError = nil;
    NSMutableArray *errors = nil;
    
    if (!(rawErrors = [[self parsedConversationResponse] objectForKey:kErrorsKey])) 
    {
        return nil;
    }
    
    errors = [NSMutableArray arrayWithCapacity:[rawErrors count]];
    
    for (NSDictionary *rawErrorWrapper in rawErrors) 
    {
        rawError = [rawErrorWrapper objectForKey:kErrorKey];
        
        [errors addObject:[NSError errorWithDomain:[rawError objectForKey:kErrorDomainKey] 
                                              code:[[rawError objectForKey:kErrorCodeKey] intValue] 
                                          userInfo:[NSDictionary dictionaryWithObject:[rawError objectForKey:kErrorLocalizedDescriptionKey] forKey:NSLocalizedDescriptionKey]]];
    }
    
    [self setErrorsCache:errors];
    
    return errors;
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAConversationFacade ()

@end
