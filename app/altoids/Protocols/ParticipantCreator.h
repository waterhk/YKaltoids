//
//  ParticipantCreator.h
//  altoids
//
//  Created by Jon Herron on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAParticipant.h"
#import "YAParticipantInfo.h"

@protocol ParticipantCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

-(YAParticipant *)participantFromParticipantInfo:(YAParticipantInfo *)theParticipantInfo inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext error:(NSError **)anError;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
