//
//  YAMessageStatusUpdater.m
//  altoids
//
//  Created by Jon Herron on 12/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageStatusUpdater.h"
#import "Command.h"

#define kMaxMessagesPerRequest 10

// Private class extension
@interface YAMessageStatusUpdater ()

// @property definitions

// methods

@end

@implementation YAMessageStatusUpdater

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize arraySplitter = arraySplitter_;
@synthesize mmcCommandQueue = mmcCommandQueue_;
@synthesize conversationCommandFactory = conversationCommandFactory_;
@synthesize messageListToArrayOfMessageIDsConverter = messageListToArrayOfMessageIDsConverter_;
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
#pragma mark MessageStatusUpdater delegate methods

- (BOOL)markMesssageAsRead:(NSArray *)theUnreadMessages forConversation:(YAConversation *)theConversation
{
    NSArray *messageIDs = [[self messageListToArrayOfMessageIDsConverter] arrayOfMessageIDsFromArrayOfMessages:theUnreadMessages];
        
    if (![messageIDs count])
        return YES;
    
    // Mark all messages as read locally
    for (YAMessage *message in theUnreadMessages) {
        [[self messageHandler] setRead:YES forMessage:message];
    }

    NSError *error = nil;
    [[theConversation managedObjectContext] save:&error];
    
    id<Command> markMessagesAsReadCommand;

    NSArray *messageIDBatches= [[self arraySplitter] splitArray:messageIDs intoGroupsOfSize:kMaxMessagesPerRequest];
    
    for (NSArray *batchOfMessageIDs in messageIDBatches) 
    {
        markMessagesAsReadCommand = [[self conversationCommandFactory] conversationMessagesFlagAsReadCommandWithConversation:theConversation messageIDs:batchOfMessageIDs];
        
        [[self mmcCommandQueue] append:markMessagesAsReadCommand];
    }
    
    return YES;
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
#pragma mark YAMessageStatusUpdater ()

@end
