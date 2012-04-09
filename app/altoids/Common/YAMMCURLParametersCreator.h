//
//  YAMMCURLParametersCreator.h
//  altoids
//
//  Created by Jon Herron on 9/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCURLParametersCreator.h"
#import "ConversationHandler.h"
#import "MessageHandler.h"
#import "URLParameterEncoder.h"

@interface YAMMCURLParametersCreator : NSObject <MMCURLParametersCreator>

@property (strong, nonatomic) id<ConversationHandler> conversationHandler;
@property (strong, nonatomic) id<MessageHandler> messageHandler;
@property (strong, nonatomic) id<URLParameterEncoder> urlParameterEncoder;

@end
