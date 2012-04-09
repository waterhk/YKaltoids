//
//  ParticipantUpdater.h
//  altoids
//
//  Created by Jon Herron on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAAddress.h"
#import "YAParticipant.h"
#import "YAParticipantInfo.h"

@protocol ParticipantUpdater <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)updateParticipant:(YAParticipant *)theParticipant fromParticipantInfo:(YAParticipantInfo *)theParticipantInfo withAddress:(YAAddress *)theAddress;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
