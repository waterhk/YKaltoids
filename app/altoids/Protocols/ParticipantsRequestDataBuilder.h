//
//  ParticipantsRequestDataBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParticipantsRequestDataBuilder <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSArray *)requestDataForParticipants:(NSSet *)theParticipants;
- (NSArray *)requestDataForSendingParticipantsByID:(NSArray *)theParticipants;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
