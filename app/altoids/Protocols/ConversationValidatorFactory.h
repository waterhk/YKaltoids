//
//  ConversationValidatorFactory.h
//  altoids
//
//  Created by Jon Herron on 8/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationValidator.h"
#import "YAConversation.h"

@protocol ConversationValidatorFactory <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<ConversationValidator>)createValidatorForConversation:(YAConversation *)aConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
