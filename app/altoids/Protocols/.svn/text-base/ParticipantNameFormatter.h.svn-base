//
//  ParticipantNameFormatter.h
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAParticipant.h"
#import "YAParticipantInfo.h"

@protocol ParticipantNameFormatter <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSString *)formatDisplayNameForParticipant:(YAParticipant *)theParticipant;
- (NSString *)formatDisplayNameForParticipantInfo:(YAParticipantInfo *)theParticipantInfo;
- (NSString *)formatShortNameForParticipant:(YAParticipant *)theParticipant;
- (NSString *)formatShortNameForParticipantInfo:(YAParticipantInfo *)theParticipantInfo;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
