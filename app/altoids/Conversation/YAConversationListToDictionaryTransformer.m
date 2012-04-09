//
//  YAConversationListToDictionaryTransformer.m
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationListToDictionaryTransformer.h"
#import "YAConversation.h"

// Private class extension
@interface YAConversationListToDictionaryTransformer ()

// @property definitions

// methods

@end

@implementation YAConversationListToDictionaryTransformer

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize conversationHandler = conversationHandler_;
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
#pragma mark ConversationListToDictionaryTransformer delegate methods

- (NSDictionary *)transformConversationListToDictionary:(NSArray *)theConversationList
{
    NSUInteger capacity = [theConversationList count];
    NSMutableDictionary *conversationDictionary = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:capacity];
    
    for (YAConversation *conversation in theConversationList) 
    {
        [conversationDictionary setObject:conversation forKey:[[self conversationHandler] conversationIDForConversation:conversation]];
    }
    
    return conversationDictionary;
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
#pragma mark YAConversationListToDictionaryTransformer ()

@end
