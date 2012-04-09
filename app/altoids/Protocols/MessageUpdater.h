//
//  MessageUpdater.h
//  altoids
//
//  Created by Jon Herron on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAMessage.h"
#import "YAMessageInfo.h"
#import "YAParticipant.h"

@protocol MessageUpdater <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)updateMessage:(YAMessage *)theMessage fromMessageInfo:(YAMessageInfo *)theMessageInfo withSender:(YAParticipant *)theSender;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
