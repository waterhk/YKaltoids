//
//  YAMMCConversationToConversationInfoTranslator.h
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCConversationToConversationInfoTranslator.h"
#import "MMCMessageToMessageInfoTranslator.h"
#import "MMCParticipantToParticipantInfoTranslator.h"
#import "MutableArrayCreator.h"
#import "MutableDictionaryCreator.h"
#import "ArrayFilterer.h"

@interface YAMMCConversationToConversationInfoTranslator : NSObject <MMCConversationToConversationInfoTranslator>

@property (strong, nonatomic) id<MMCMessageToMessageInfoTranslator> mmcMessageToMessageInfoTranslator;
@property (strong, nonatomic) id<MMCParticipantToParticipantInfoTranslator> mmcParticipantToParticipantInfoTranslator;
@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;
@property (strong, nonatomic) id<MutableDictionaryCreator> mutableDictionaryCreator;
@property (strong, nonatomic) id<ArrayFilterer> arrayFilterer;

- (NSArray *)namePartsForSenderOfMostRecentMessage:(YAMMCRecentMessage *)mostRecentMessage;

@end
