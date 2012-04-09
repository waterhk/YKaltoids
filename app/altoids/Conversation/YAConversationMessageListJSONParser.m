//
//  YAConversationMessageListJSONParser.m
//  altoids
//
//  Created by Jon Herron on 10/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationMessageListJSONParser.h"

#define kMessagesKey @"conversation.messages"
#define kMessageDataKey @"data"
#define kMessageDataPartsKey @"message.data.parts"

// Private class extension
@interface YAConversationMessageListJSONParser ()

// @property definitions

// methods

@end

@implementation YAConversationMessageListJSONParser

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize jsonParserForMutableResult = jsonParserForMutableResult_;

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
#pragma mark ConversationMessageListJSONParser delegate methods

- (NSDictionary *)parseJSONData:(NSData *)theData
{
    NSMutableArray *messages = nil;
    NSMutableDictionary *messageData = nil;
    NSMutableDictionary *parsedJSONData = nil;
    NSMutableDictionary *parsedEmbeddedJSONData = nil;
    NSRange embeddedEscapedNewlineRange;
    NSString *embeddedEscapedNewline = @"\\\n";
    NSString *embeddedJSONStringLiteral = nil;
    
    if (!(parsedJSONData = [[self jsonParserForMutableResult] parseJSONDataForMutableResult:theData])) 
    {
        YALogError(@"Unable to parse data");
        
        return nil;
    }
    
    if (!(messages = [parsedJSONData valueForKeyPath:kMessagesKey])) 
    {
        YALogError(@"No messages for conversation");
        
        return parsedJSONData;
    }
    
    for (NSMutableDictionary *message in messages) 
    {
        if (!(messageData = [[message valueForKeyPath:kMessageDataPartsKey] objectAtIndex:0]))
        {
            YALogDebug(@"No data for message, skipping");
            
            continue;
        }
        
        if (![[messageData objectForKey:kMessageDataKey] isKindOfClass:[NSString class]]) 
        {
            YALogDebug(@"Data is not embedded json string literal, skipping reparse");
            
            continue;
        }
        
        embeddedJSONStringLiteral = [messageData objectForKey:kMessageDataKey];
        
        embeddedEscapedNewlineRange = [embeddedJSONStringLiteral rangeOfString:embeddedEscapedNewline];
        
        if (embeddedEscapedNewlineRange.length > 0) 
        {
            embeddedJSONStringLiteral = [embeddedJSONStringLiteral stringByReplacingOccurrencesOfString:embeddedEscapedNewline withString:@"\\n"];
        }

        parsedEmbeddedJSONData = [[self jsonParserForMutableResult] parseJSONStringForMutableResult:embeddedJSONStringLiteral];
        
        if (parsedEmbeddedJSONData) 
        {
            [messageData setObject:parsedEmbeddedJSONData forKey:kMessageDataKey];
        }
    }
    
    return parsedJSONData;
}

- (NSDictionary *)parseJSONString:(NSString *)theString
{
    return [self parseJSONData:[theString dataUsingEncoding:NSUTF8StringEncoding]];
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
#pragma mark YAConversationMessageListJSONParser ()

@end
