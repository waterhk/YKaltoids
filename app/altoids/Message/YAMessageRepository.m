//
//  YAMessageRepository.m
//  altoids
//
//  Created by Jon Herron on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageRepository.h"

// Private class extension
@interface YAMessageRepository ()

// @property definitions

// methods

@end

@implementation YAMessageRepository

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize messageHandler = messageHandler_;
@synthesize messageDeleter = messageDeleter_;
@synthesize participantRepository = participantRepository_;
@synthesize messageErrorCreator = messageErrorCreator_;
@synthesize messageUpdater = messageUpdater_;

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
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

- (YAMessage *)createMessageFromMessageInfo:(YAMessageInfo *)aMessageInfo inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError
{
    NSError *error;
    YAMessage *message;
    YAParticipant *sender;
    YAParticipantInfo *participantInfo;
    
    message = [[self messageHandler] createMessageEntityInManagedObjectContext:aManagedObjectContext];
    participantInfo = [aMessageInfo sender];
    
    if (participantInfo) 
    {
        sender = [[self participantRepository] createParticipantFromParticipantInfo:participantInfo inManagedObjectContext:aManagedObjectContext error:&error];
        
        if (!sender) 
        {
            *anError = [[self messageErrorCreator] errorWithCode:YAMessageErrorCodeFailedToCreateMessageLocally underlyingError:error];
            
            return nil;
        }
    }
    
    [[self messageUpdater] updateMessage:message fromMessageInfo:aMessageInfo withSender:sender];
    
    return message;
}

- (BOOL)deleteAllMessagesInConversationWithID:(NSString *)theConversationID inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext error:(NSError **)anError
{
    BOOL deletedMessages;
    NSError *error;
    
    deletedMessages = [[self messageDeleter] deleteAllMessagesInConversationWithID:theConversationID inManagedObjectContext:theManagedObjectContext error:&error];
    
    if (!deletedMessages) 
    {
        *anError = [[self messageErrorCreator] errorWithCode:YAMessageErrorCodeFailedToDeleteAllMessagesInConversation underlyingError:error];
        
        return NO;
    }
    
    return YES;
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAMessageRepository ()

@end
