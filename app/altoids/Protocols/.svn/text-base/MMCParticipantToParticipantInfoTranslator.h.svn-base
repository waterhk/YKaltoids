//
//  MMCParticipantToParticipantInfoTranslator.h
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAParticipantInfo.h"
#import "YAMMCParticipant.h"

@protocol MMCParticipantToParticipantInfoTranslator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAParticipantInfo *)participantInfoFromMMCParticipant:(YAMMCParticipant *)anMMCParticipant withTransientID:(NSString *)theTransientID;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
