//
//  YAMMCConversationsFacade.m
//  altoids
//
//  Created by Jon Herron on 9/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientServerResponseFacades
//

#import "YAMMCConversations.h"
#import "YAMMCConversation.h"

#define kConversationsKey @"conversations"
#define kMoreConversationsAvailableOnServerKey @"moreConvPresent"

// Private class extension
@interface YAMMCConversations ()

// @property definitions
@property (strong, nonatomic) NSArray *conversationFacadeCache;
@property (strong, nonatomic) NSArray *conversationIDCache;
@property (copy,   nonatomic) NSDictionary *parsedJSONConversationsResponse;

// methods
- (void)loadConversations;

@end

@implementation YAMMCConversations

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize conversationFacadeCache = conversationFacadeCache_;
@synthesize conversationIDCache = conversationIDCache_;
@synthesize parsedJSONConversationsResponse = parsedJSONConversationsResponse_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithParsedJSONConversationsResponse:(NSDictionary *)aParsedJSONConversationsResponse
{
  self = [super init];
    
  if (self) 
  {
      parsedJSONConversationsResponse_ = [aParsedJSONConversationsResponse copy];
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

- (NSArray *)conversations
{    
    if ([self conversationFacadeCache]) 
    {
        return [self conversationFacadeCache];
    }

    [self loadConversations];
    
    return [self conversationFacadeCache];
}

- (NSArray *)conversationIDs
{
    if ([self conversationIDCache]) 
    {
        return [self conversationIDCache];
    }
    
    [self loadConversations];
    
    return [self conversationIDCache];
}

- (BOOL)moreConversationsAvailableOnServer
{
    return [[[self parsedJSONConversationsResponse] objectForKey:kMoreConversationsAvailableOnServerKey] boolValue];
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAMMCConversationsFacade ()

- (void)loadConversations
{    
    NSArray *rawConversations = nil;
    NSMutableArray *conversationIDs = nil;
    NSMutableArray *facades = nil;
    NSUInteger conversationsCount = 0;
    YAMMCConversation *conversationFacade = nil;
    
    if (!(rawConversations = [[self parsedJSONConversationsResponse] objectForKey:kConversationsKey])) 
    {
        return;
    }
    
    conversationsCount = [rawConversations count];
    
    conversationIDs = [NSMutableArray arrayWithCapacity:conversationsCount];
    facades = [NSMutableArray arrayWithCapacity:conversationsCount];
    
    for (NSDictionary *rawConversation in rawConversations)
    {
        conversationFacade = [[YAMMCConversation alloc] initWithParsedJSONConversationResponse:rawConversation];
        
        [facades addObject:conversationFacade];
        
        if ([conversationFacade conversationID]) 
        {
            [conversationIDs addObject:[conversationFacade conversationID]];
        }
    }
    
    [self setConversationFacadeCache:facades];
    [self setConversationIDCache:conversationIDs];
}

@end
