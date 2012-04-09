//
//  ParticipantImageLoaderCommandDelegate.h
//  altoids
//
//  Created by Jon Herron on 11/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAParticipant.h"

@protocol ParticipantImageLoaderCommandDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)imageData:(NSData *)theParticipantImage forParticipant:(YAParticipant *)theParticipant withCallbackData:(id)theCallbackData;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
