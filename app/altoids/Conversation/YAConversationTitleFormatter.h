//
//  YAConversationTitleFormatter.h
//  altoids
//
//  Created by Xianzhe Ma on 2/28/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationTitleFormatter.h"

@protocol ParticipantDescriptionBuilder;
@protocol AttributedStringCreator;
@protocol AttributedStringBuilder;

@interface YAConversationTitleFormatter : NSObject <ConversationTitleFormatter>

@property (nonatomic, strong) id <ParticipantDescriptionBuilder> participantDescriptionBuilder;
@property (nonatomic, strong) id<AttributedStringCreator> attributedStringCreator;
@property (nonatomic, strong) id<AttributedStringBuilder> attributedStringBuilder;

@end
