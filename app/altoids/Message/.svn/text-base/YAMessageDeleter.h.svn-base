//
//  YAMessageDeleter.h
//  altoids
//
//  Created by Jon Herron on 10/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageDeleter.h"
#import "MessageFetchRequestCreator.h"
#import "MessageHandler.h"
#import "MessageErrorCreator.h"

@interface YAMessageDeleter : NSObject <MessageDeleter>

@property (strong, nonatomic) id<MessageFetchRequestCreator> messageFetchRequestCreator;
@property (strong, nonatomic) id<MessageHandler> messageHandler;
@property (strong, nonatomic) id<MessageErrorCreator> messageErrorCreator;

@end
