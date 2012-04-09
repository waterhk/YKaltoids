//
//  ParticipantPickerViewController.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ViewControllerAccessor.h"

@protocol ParticipantPickerViewController <NSObject, ViewControllerAccessor>

#pragma mark -
#pragma mark @required
@required

- (void)findParticipantsForQueryString:(NSString*)queryString;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
