//
//  YAConversationEditErrorHandler.m
//  altoids
//
//  Created by Jon Herron on 11/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationEditErrorHandler.h"

// Private class extension
@interface YAConversationEditErrorHandler ()

// @property definitions
@property (strong, nonatomic) id<ConversationHandler> conversationHandler;
@property (strong, nonatomic) NSManagedObjectID *conversationObjectID;

// methods

@end

@implementation YAConversationEditErrorHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize conversationHandler = conversationHandler_;
@synthesize conversationObjectID = conversationObjectID_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithConversationHandler:(id<ConversationHandler>)theConversationHandler 
      managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory 
             conversationObjectID:(NSManagedObjectID *)theConversationObjectID
{
    self = [super initWithManagedObjectContextFactory:theManagedObjectContextFactory];
    
    if (self) 
    {
        conversationHandler_ = theConversationHandler;
        conversationObjectID_ = theConversationObjectID;
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
#pragma mark ErrorHandler delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

- (void)handleMgrErrorParticipantAddFailed:(NSError *)theError
{
    
}

- (void)handleMgrErrorParticipantAddressNotSupported:(NSError *)theError
{
    
}

- (void)handleMgrErrorParticipantDeleteFailed:(NSError *)theError
{
    
}

- (void)handleMgrErrorParticipantDoesNotExist:(NSError *)theError
{
    
}

- (void)handleMgrErrorParticipantExists:(NSError *)theError
{
    
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAConversationEditErrorHandler ()

@end
