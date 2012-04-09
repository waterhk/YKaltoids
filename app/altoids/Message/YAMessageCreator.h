//
//  YAMessageCreator.h
//  altoids
//
//  Created by Xianzhe Ma on 4/2/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageCreator.h"

@protocol MessageHandler;

@interface YAMessageCreator : NSObject <MessageCreator>

- (id)initWithMessageHandler:(id<MessageHandler>)aMessageHandler;

@end
