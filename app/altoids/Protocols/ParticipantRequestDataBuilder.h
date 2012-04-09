//
//  ParticipantRequestDataBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAParticipant.h"

@protocol ParticipantRequestDataBuilder <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSDictionary *)requestDataForParticipant:(YAParticipant *)theParticipant;
- (NSDictionary *)requestDataForSendingParticipantByPID:(YAParticipant *)theParticipant;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
