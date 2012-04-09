//
//  YAMessageGapDetector.m
//  altoids
//
//  Created by Anand Subba Rao on 11/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageGapDetector.h"
#import "YAMessageInfo.h"

// Private class extension
@interface YAMessageGapDetector ()

// @property definitions

// methods

- (YAMessage *)earliestMessageWithMessages:(NSSet *)messages;
- (YAMessage *)latestMessageWithMessages:(NSSet *)messages;
@end

@implementation YAMessageGapDetector
// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize messageHandler = messageHandler_;

// Class methods
#pragma mark -
#pragma mark Class methods

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
#pragma mark MessageGapDetector methods
- (YAMessage *)messageImmediatelyBeforePossibleGapWithExistingMessages:(NSSet *)existingMessages
                                                           newMessages:(NSSet *)newMessages
                                                messageInfosWithIdOnly:(NSArray *)messageInfosWithIdOnly
{    
    if ([existingMessages count] == 0 && [messageInfosWithIdOnly count] && [newMessages count]) {
        return [self earliestMessageWithMessages:newMessages];
    }
        
    if (![messageInfosWithIdOnly count]) {
        return nil;
    }
    
    if (![newMessages count]) {
        return nil;
    }
    
    YAMessageInfo *earliestMessageFromServer = [messageInfosWithIdOnly objectAtIndex:0];    
    YAMessage *latestExistingMessage = [self latestMessageWithMessages:existingMessages];
    NSString *messageInfomessageID = [earliestMessageFromServer messageID];
    
    if ([messageInfomessageID isEqualToString:[[self messageHandler] messageIDForMessage:latestExistingMessage]])
        return nil;

    YAMessage *earliestExistingMessage = [self earliestMessageWithMessages:existingMessages];
    
    if ([messageInfomessageID isEqualToString:[[self messageHandler] messageIDForMessage:earliestExistingMessage]])
        return nil;

    for (YAMessage *message in existingMessages) {
        if ([messageInfomessageID isEqualToString:[[self messageHandler] messageIDForMessage:message]])
            return nil;
    }
    
    return latestExistingMessage;
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
#pragma mark YAMessageGapDetector ()
- (YAMessage *)earliestMessageWithMessages:(NSSet *)messages
{
    __block YAMessage *earliestMessage = nil;
    __block NSDate *earliestTimestamp = nil;
    [messages enumerateObjectsUsingBlock:^(YAMessage *obj, BOOL *stop) {
        if (earliestMessage) {
            NSDate *currentTimestamp = [[self messageHandler] timestampForMessage:obj];
            
            if ([earliestTimestamp compare:currentTimestamp] == NSOrderedDescending) {
                earliestTimestamp = currentTimestamp;
                earliestMessage = obj;
            }
        } else {
            earliestTimestamp = [[self messageHandler] timestampForMessage:obj];
            earliestMessage = obj;            
        }
    }];
    
    return earliestMessage;
    
}

- (YAMessage *)latestMessageWithMessages:(NSSet *)messages
{
    __block YAMessage *latestMessage = nil;
    __block NSDate *latestTimestamp = nil;
    [messages enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if (latestMessage) {
            NSDate *currentTimestamp = [[self messageHandler] timestampForMessage:obj];
            
            if ([latestTimestamp compare:currentTimestamp] == NSOrderedAscending) {
                latestTimestamp = currentTimestamp;
                latestMessage = obj;
            }
        } else {
            latestTimestamp = [[self messageHandler] timestampForMessage:obj];
            latestMessage = obj;
        }
    }];
    
    return latestMessage;
}
@end
