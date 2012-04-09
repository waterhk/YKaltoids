//
//  ParticipantResponseParser.h
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YAValidateParticipantResponse;

@protocol ParticipantResponseParser <NSObject>

#pragma mark -
#pragma mark @required
@required
- (YAValidateParticipantResponse *)parseValidateParticipantResponse:(NSData *)response error:(NSError *)error;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
