//
//  ParticipantCommandFactory.h
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/26/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Command;

@protocol ParticipantCommandFactory <NSObject>

#pragma mark -
#pragma mark @required
@required
- (id<Command>)createValidateParticipantsCommandWithParticipants:(NSArray *)participants;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
