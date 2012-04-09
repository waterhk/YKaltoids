//
//  ParticipantPickerDelegate.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ParticipantPickerViewController.h"
#import "YAParticipantInfo.h"

@protocol ParticipantPickerDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)participantPicker:(id<ParticipantPickerViewController>)participantPicker didPickParticipantWithInfo:(YAParticipantInfo *)participantInfo;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
