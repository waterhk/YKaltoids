//
//  YAMessageSetToArrayOfMessageIDsConverter.m
//  altoids
//
//  Created by Jon Herron on 12/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageListToArrayOfMessageIDsConverter.h"
#import "YAMessage.h"

// Private class extension
@interface YAMessageListToArrayOfMessageIDsConverter ()

// @property definitions

// methods

@end

@implementation YAMessageListToArrayOfMessageIDsConverter

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize mutableArrayCreator = mutableArrayCreator_;
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
#pragma mark MessageListToArrayOfMessageIDsConverter delegate methods

- (NSArray *)arrayOfMessageIDsFromSetOfMessages:(NSSet *)theMessageSet
{
    NSMutableArray *arrayOfMessageIDs = [[self mutableArrayCreator] mutableArrayWithCapacity:[theMessageSet count]];
    
    [theMessageSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [arrayOfMessageIDs addObject:[[self messageHandler] messageIDForMessage:obj]];
    }];
    
    return arrayOfMessageIDs;
}

- (NSArray *)arrayOfMessageIDsFromArrayOfMessages:(NSArray *)theMessageArray
{
    NSMutableArray *arrayOfMessageIDs = [[self mutableArrayCreator] mutableArrayWithCapacity:[theMessageArray count]];
    
    [theMessageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *messageID = [[self messageHandler] messageIDForMessage:obj];
        if (messageID)
            [arrayOfMessageIDs addObject:messageID];
    }];
        
    return arrayOfMessageIDs;    
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
#pragma mark YAMessageSetToArrayOfMessageIDsConverter ()

@end
