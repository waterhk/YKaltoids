//
//  MessageFlagRequestDataBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageFlagRequestDataBuilder <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSDictionary *)requestDataForFlaggingMessagesAsRead:(NSArray *)theMessages;
- (NSDictionary *)requestDataForFlaggingMessagesAsUnread:(NSArray *)theMessages;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
