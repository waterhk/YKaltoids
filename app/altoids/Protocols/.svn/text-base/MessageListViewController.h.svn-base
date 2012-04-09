//
//  MessageListViewController.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 10/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerAccessor.h"

@protocol MessageListViewController <ViewControllerAccessor>

#pragma mark -
#pragma mark @required
@required

- (void)replyWithText:(NSString *)messageText;
- (void)scrollToMostAppropriateMessage;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
