//
//  ConversationComposeViewController.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ViewControllerAccessor.h"

@protocol ConversationComposeViewController <ViewControllerAccessor>

#pragma mark -
#pragma mark @required
@required

@property (nonatomic, strong) NSArray* participants;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
