//
//  YAMessageUpdater.m
//  altoids
//
//  Created by Jon Herron on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageUpdater.h"

// Private class extension
@interface YAMessageUpdater ()

// @property definitions

// methods

@end

@implementation YAMessageUpdater

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize messageHandler = messageHandler_;

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
#pragma mark MessageUpdater delegate methods

- (void)updateMessage:(YAMessage *)theMessage fromMessageInfo:(YAMessageInfo *)theMessageInfo withSender:(YAParticipant *)theSender
{
    NSParameterAssert(theMessage);
    NSParameterAssert(theMessageInfo);
    
    [[self messageHandler] setMessageID:[theMessageInfo messageID] forMessage:theMessage];
    
    if ([theMessageInfo isMessageIdOnly]) 
    {
        [[self messageHandler] setStatusAsGapPlaceholderForMessage:theMessage];
        [[self messageHandler] setRead:YES forMessage:theMessage];
        
        return;
    }
    
    NSString *messageBody;
    
    if ([theMessageInfo isSystemMessage]) 
    {
        [[self messageHandler] setStatusAsSystemMessageForMessage:theMessage];
        
        messageBody = [theMessageInfo systemMessage];
    }
    else
    {
        messageBody = [theMessageInfo body];
    }
    
    [[self messageHandler] setBody:messageBody forMessage:theMessage];
    [[self messageHandler] setRead:[theMessageInfo read] forMessage:theMessage];
    [[self messageHandler] setSnippet:[theMessageInfo snippet] forMessage:theMessage];
    [[self messageHandler] setTimestamp:[theMessageInfo timestamp] forMessage:theMessage];
    [[self messageHandler] setParticipantAsSender:theSender ofMessage:theMessage];
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
#pragma mark YAMessageUpdater ()

@end
