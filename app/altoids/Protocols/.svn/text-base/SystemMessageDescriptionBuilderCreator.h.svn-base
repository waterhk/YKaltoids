//
//  SystemMessageDescriptionBuilderCreator.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 11/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemMessageDescriptionBuilder.h"
#import "MMCParticipantToParticipantInfoTranslator.h"

@protocol SystemMessageDescriptionBuilderCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<SystemMessageDescriptionBuilder>)createSystemMessageDescriptionBuilderWithCanonicalMessageData:(NSDictionary *)theCanonicalMessageData 
                                                           mmcParticipantToParticipantInfoTranslator:(id<MMCParticipantToParticipantInfoTranslator>)anMMCParticipantToParticipantInfoTranslator;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
