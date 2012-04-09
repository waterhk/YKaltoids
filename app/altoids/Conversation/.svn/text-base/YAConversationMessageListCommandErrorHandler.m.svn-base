//
//  YAConversationMessageListCommandErrorHandler.m
//  altoids
//
//  Created by Anand Biligiri on 11/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationMessageListCommandErrorHandler.h"

// Private class extension
@interface YAConversationMessageListCommandErrorHandler ()

// @property definitions
@property (strong, nonatomic) NSManagedObjectID *conversationObjectID;
// methods

@end

@implementation YAConversationMessageListCommandErrorHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize conversationObjectID = conversationObjectID_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithConversationObjectID:(NSManagedObjectID *)conversationID managedObjectContextFactory:(id<ManagedObjectContextFactory>)managedObjectContextFactory
{
    self = [super initWithManagedObjectContextFactory:managedObjectContextFactory];
    if (self) {
        conversationObjectID_ = conversationID;
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
#pragma mark methods
- (void)handleError:(NSError *)theError
{
    //do something with the conversation object that is stored
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
#pragma mark YAConversationMessageListCommandErrorHandler ()

@end
