//
//  MMCMessageToMessageInfoTranslator.h
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAMMCRecentMessage.h"
#import "YAMMCMessage.h"
#import "YAMessageInfo.h"

@protocol MMCMessageToMessageInfoTranslator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAMessageInfo *)messageInfoFromMMCRecentMessage:(YAMMCRecentMessage *)anMMCRecentMessage;
- (YAMessageInfo *)messageInfoFromMMCRecentMessage:(YAMMCRecentMessage *)anMMCRecentMessage withSender:(YAParticipantInfo *)theSender;
- (YAMessageInfo *)messageInfoFromMMCMessage:(YAMMCMessage *)anMMCMessage;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
