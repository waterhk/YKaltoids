//
//  YAParticipantHandler.m
//  altoids
//
//  Created by Jon Herron on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "YAParticipantHandler.h"

// Private class extension
@interface YAParticipantHandler ()

// @property definitions

// methods

@end

@implementation YAParticipantHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

- (YAParticipant *)createParticipantEntityInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext
{
    YAParticipant *participant = [NSEntityDescription insertNewObjectForEntityForName:PARTICIPANT_ENTITY_NAME inManagedObjectContext:aManagedObjectContext];
    
    [participant setCreator:nil];
    [participant setConversationSender:nil];
    
    return participant;
}

- (void)saveParticipant:(YAParticipant *)theParticipant inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    NSError *error;
    
    [theManagedObjectContext save:&error];
    
    if (error) 
    {
        YALogError(@"Failed to save participant");
    }
}

- (void)setAddress:(YAAddress *)anAddress forParticipant:(YAParticipant *)aParticipant
{
    [aParticipant setAddress:anAddress];
}

- (void)setFirstName:(NSString *)aFirstName forParticipant:(YAParticipant *)aParticipant
{
    [aParticipant setFirstName:aFirstName];
}

- (void)setLastName:(NSString *)aLastName forParticipant:(YAParticipant *)aParticipant
{
    [aParticipant setLastName:aLastName];
}

- (void)setPhotoURL:(NSString *)thePhotoURL forParticipant:(YAParticipant *)aParticipant
{
    [aParticipant setPhotoUrl:thePhotoURL];
}

- (void)setParticipantID:(NSString *)aParticipantID forParticipant:(YAParticipant *)aParticipant
{
    [aParticipant setParticipantID:aParticipantID];
}

- (void)setTimestamp:(NSDate *)aTimestamp forParticipant:(YAParticipant *)aParticipant
{
    [aParticipant setTimestamp:aTimestamp];
}

- (void)setParticipant:(YAParticipant *)aParticipant asCreatorOfParticipant:(YAParticipant *)anotherParticipant
{
    [anotherParticipant setCreator:aParticipant];
}

- (void)setIsUser:(BOOL)isUser forParticipant:(YAParticipant *)theParticipant
{
    [theParticipant setIsUser:[NSNumber numberWithBool:isUser]];
}

- (void)setPersonImage:(YAPersonImage *)personImage forParticipant:(YAParticipant *)participant
{
    [participant setImage:personImage];    
}

- (YAAddress *)addressForParticipant:(YAParticipant *)theParticipant
{
    return [theParticipant address];
}

- (NSString *)firstNameForParticipant:(YAParticipant *)theParticipant
{
    return [theParticipant firstName];
}

- (NSString *)lastNameForParticipant:(YAParticipant *)theParticipant
{
    return [theParticipant lastName];
}

- (NSString *)photoURLForParticipant:(YAParticipant *)theParticipant
{
    return [theParticipant photoUrl];
}

- (NSString *)participantIDForParticipant:(YAParticipant *)theParticipant
{
    return [theParticipant participantID];
}

- (NSDate *)timestampForParticipant:(YAParticipant *)theParticipant
{
    return [theParticipant timestamp];
}

- (BOOL)participantIsUser:(YAParticipant *)theParticipant
{
    return [[theParticipant isUser] boolValue];
}

- (YAPersonImage *)personImageForParticipant:(YAParticipant *)participant
{
    return [participant image];
}

- (YAConversation *)conversationForParticipant:(YAParticipant *)participant
{
    return [participant conversation];
}

@end
