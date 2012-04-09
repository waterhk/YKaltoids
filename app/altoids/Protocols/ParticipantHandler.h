//
//  ParticipantHandler.h
//  altoids
//
//  Created by Jon Herron on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "YAAddress.h"
#import "YAConversation.h"
#import "YAParticipant.h"
#import "YAPersonImage.h"

@protocol ParticipantHandler <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAParticipant *)createParticipantEntityInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (void)saveParticipant:(YAParticipant *)theParticipant inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

- (void)setAddress:(YAAddress *)anAddress forParticipant:(YAParticipant *)aParticipant;
- (void)setFirstName:(NSString *)aFirstName forParticipant:(YAParticipant *)aParticipant;
- (void)setLastName:(NSString *)aLastName forParticipant:(YAParticipant *)aParticipant;
- (void)setPhotoURL:(NSString *)thePhotoURL forParticipant:(YAParticipant *)aParticipant;
- (void)setParticipantID:(NSString *)aParticipantID forParticipant:(YAParticipant *)aParticipant;
- (void)setTimestamp:(NSDate *)aTimestamp forParticipant:(YAParticipant *)aParticipant;
- (void)setIsUser:(BOOL)isUser forParticipant:(YAParticipant *)theParticipant;
- (void)setParticipant:(YAParticipant *)aParticipant asCreatorOfParticipant:(YAParticipant *)anotherParticipant;
- (void)setPersonImage:(YAPersonImage *)personImage forParticipant:(YAParticipant *)participant;

- (YAAddress *)addressForParticipant:(YAParticipant *)theParticipant;
- (NSString *)firstNameForParticipant:(YAParticipant *)theParticipant;
- (NSString *)lastNameForParticipant:(YAParticipant *)theParticipant;
- (NSString *)photoURLForParticipant:(YAParticipant *)theParticipant;
- (NSString *)participantIDForParticipant:(YAParticipant *)theParticipant;
- (NSDate *)timestampForParticipant:(YAParticipant *)theParticipant;
- (BOOL)participantIsUser:(YAParticipant *)theParticipant;
- (YAPersonImage *)personImageForParticipant:(YAParticipant *)participant;

- (YAConversation *)conversationForParticipant:(YAParticipant *)participant;
   
@end
