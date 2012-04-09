//
//  YAMMCRelativeURICreator.m
//  altoids
//
//  Created by Jon Herron on 10/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMMCRelativeURICreator.h"

#define kConversationManagerRelativeURI @"mmc/manager/v1/conversation"
#define kConversationServicesRelativeURI @"mmc/services/v1/conversation"
#define kConversationsRelativeURI @"mmc/services/v1/conversations"
#define kConversationMessagesRelativeURIFormat @"%@/%@/messages"
#define kConverationManagerRelativeURIFormat @"%@/%@"
#define kConversationReplyRelativeURIFormat @"%@/%@"

// Private class extension
@interface YAMMCRelativeURICreator ()

// @property definitions

// methods
- (NSString *)doubleEncodedConversationIDForConversation:(YAConversation *)theConversation;

@end

@implementation YAMMCRelativeURICreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize conversationHandler = conversationHandler_;
@synthesize mmcURLParameterEncoder = mmcURLParameterEncoder_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark MMCRelativeURICreator delegate methods

- (NSString *)createRelativeURIToCreateConversation
{
    return kConversationServicesRelativeURI;
}

- (NSString *)createRelativeURIToRetrieveConversations
{
    return kConversationsRelativeURI;
}

- (NSString *)createRelativeURIToRetrieveMessagesInConversation:(YAConversation *)theConversation
{
    NSString *conversationID = [self doubleEncodedConversationIDForConversation:theConversation];
    
    return [NSString stringWithFormat:kConversationMessagesRelativeURIFormat, kConversationServicesRelativeURI, conversationID];
}

- (NSString *)createRelativeURIToManageConversation:(YAConversation *)theConversation
{
    NSString *conversationID = [self doubleEncodedConversationIDForConversation:theConversation];
    
    return [NSString stringWithFormat:kConverationManagerRelativeURIFormat, kConversationManagerRelativeURI, conversationID];
}

- (NSString *)createRelativeURIToReplyToConversation:(YAConversation *)theConversation
{
    NSString *conversationID = [self doubleEncodedConversationIDForConversation:theConversation];
    
    return [NSString stringWithFormat:kConversationReplyRelativeURIFormat, kConversationServicesRelativeURI, conversationID];
}

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
#pragma mark YAMMCRelativeURICreator ()

- (NSString *)doubleEncodedConversationIDForConversation:(YAConversation *)theConversation
{
    NSString *conversationID = [[self conversationHandler] conversationIDForConversation:theConversation];
    
    conversationID = [[self mmcURLParameterEncoder] doubleEncodeURLParameterForMMC:conversationID];
    
    return conversationID;
}

@end
