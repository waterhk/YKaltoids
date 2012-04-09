//
//  ConversationCreateRequestDataBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAConversation.h"

@protocol ConversationCreateRequestDataBuilder <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSDictionary *)requestDataForConversation:(YAConversation *)theConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
