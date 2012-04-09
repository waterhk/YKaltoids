//
//  YAConversationFlagMessagesRequestDataBuilder.m
//  altoids
//
//  Created by Anand Biligiri on 12/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationFlagMessagesRequestDataBuilder.h"

#define kConversationFlagMessagesRequestContainerCount 2
#define kConversationMessageIDsKey @"mids"
#define kConversationMessageReadKey @"read"

// Private class extension
@interface YAConversationFlagMessagesRequestDataBuilder ()

// @property definitions

// methods

@end

@implementation YAConversationFlagMessagesRequestDataBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;

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
#pragma mark ConversationFlagMessagesRequestDataBuilder methods
- (NSDictionary *)requestDataToFlagMessagesAsRead:(NSArray *)messageIDs
{
    NSMutableDictionary *requestData = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:kConversationFlagMessagesRequestContainerCount];
    
    [requestData setObject:messageIDs forKey:kConversationMessageIDsKey];
    [requestData setObject:[NSNumber numberWithBool:YES] forKey:kConversationMessageReadKey];
    
    return requestData;
}

- (NSDictionary *)requestDataToFlagMessagesAsUnRead:(NSArray *)messageIDs
{
    return nil;
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
#pragma mark YAConversationFlagMessagesRequestDataBuilder ()

@end
