//
//  YAMessageGapPlaceholderClearer.m
//  altoids
//
//  Created by Anand Subba Rao on 11/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageGapPlaceholderClearer.h"

// Private class extension
@interface YAMessageGapPlaceholderClearer ()

// @property definitions

// methods

@end

@implementation YAMessageGapPlaceholderClearer
// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize messageHandler = messageHandler_;
@synthesize mutableSetCreator = mutableSetCreator_;
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
#pragma mark MessageGapPlaceholderClearer methods
- (NSSet *)messagesWithGapPlaceholderRemovedInMessages:(NSSet *)messages managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSMutableSet *messagesWithoutGap = [[self mutableSetCreator] mutableSetWithCapacity:[messages count]];
    [messages enumerateObjectsUsingBlock:^(YAMessage *obj, BOOL *stop) {
        if (![[self messageHandler] messageHasGapPlaceholderStatus:obj]) {
            [messagesWithoutGap addObject:obj];
        } else {
            [[self messageHandler] deleteMessage:obj inManagedObjectContext:managedObjectContext];
        }
    }];
    
    return messagesWithoutGap;
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
#pragma mark YAMessageGapPlaceholderClearer ()

@end
