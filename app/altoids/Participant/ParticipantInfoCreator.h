//
//  ParticipantInfoCreator.h
//  altoids
//
//  Created by Derrick Whittle on 4/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YAParticipantInfo, YAContactEndpoint, YAParticipant;


@protocol ParticipantInfoCreator <NSObject>

- (YAParticipantInfo*) participantInfoWithContactEndpoint:(YAContactEndpoint*)contactEndpoint;

- (YAParticipantInfo*) participantInfoWithUserInput:(NSString*)userInput;

- (YAParticipantInfo*) participantInfoWithParticipant:(YAParticipant*)participant;

- (YAParticipantInfo*) participantInfoForCurrentUser;

@end
