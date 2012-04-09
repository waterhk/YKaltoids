//
//  ParticipantRepository.h
//  altoids
//
//  Created by Jon Herron on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "ParticipantRepositoryImageDelegate.h"
#import "YAConversation.h"
#import "YAParticipant.h"
#import "YAParticipantInfo.h"

@protocol ParticipantRepository <NSObject>

#pragma mark -
#pragma mark @required
@required

-(YAParticipant *)createParticipantFromParticipantInfo:(YAParticipantInfo *)aParticipantInfo inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError;

- (NSSet *)createParticipantsFromArrayOfParticipantInfo:(NSArray *)anArrayOfParticipantInfo inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError;

- (NSSet *)mergeParticipants:(NSArray *)anArrayOfParticipantInfo withExistingParticipants:(NSSet *)theExistingParticipants usingParticipantIDMap:(NSDictionary *)theParticipantIDMap inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext error:(NSError **)anError;

- (void)validateParticipants:(NSArray *)participants;

- (void)saveParticipant:(YAParticipant *)theParticipant inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

- (void)retrieveImageForParticipant:(YAParticipant *)theParticipant;

- (UIImage *)imageForParticipant:(YAParticipant *)participant;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
