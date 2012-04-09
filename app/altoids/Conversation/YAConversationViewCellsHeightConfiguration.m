//
//  YAConversationViewCellsHeightConfiguration.m
//  altoids
//
//  Created by Xianzhe Ma on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationViewCellsHeightConfiguration.h"
#import "YAMessage.h"
#import "MessageStatus.h"

@interface YAConversationViewCellsHeightConfiguration ()

@property (nonatomic, assign) CGFloat systemMessageCellHeight;
@property (nonatomic, assign) CGFloat gapCellHeight;
@property (nonatomic, assign) CGFloat userMessageCellDefaultHeight;
@property (nonatomic, assign) CGFloat userMessageCellMessageBodyLabelWidth;
@property (nonatomic, assign) CGFloat userMessageCellMessageBodyLabelDefaultHeight;
@property (nonatomic, assign) CGFloat userMessageCellMessageBodyDefaultFontSize;

@end

@implementation YAConversationViewCellsHeightConfiguration

@synthesize systemMessageCellHeight = systemMessageCellHeight_;
@synthesize gapCellHeight = gapCellHeight_;
@synthesize userMessageCellDefaultHeight = userMessageCellDefaultHeight_;
@synthesize userMessageCellMessageBodyLabelWidth = userMessageCellMessageBodyLabelWidth_;
@synthesize userMessageCellMessageBodyLabelDefaultHeight = userMessageCellMessageBodyLabelDefaultHeight_;
@synthesize userMessageCellMessageBodyDefaultFontSize = userMessageCellMessageBodyDefaultFontSize_;

- (id)init
{
    if (self = [super init]) {
        systemMessageCellHeight_ = 44.0;
        gapCellHeight_ = 42.0;
        userMessageCellDefaultHeight_ = 75.0;
        userMessageCellMessageBodyLabelDefaultHeight_ = 16.0;
        userMessageCellMessageBodyLabelWidth_ = 251.0;
        userMessageCellMessageBodyDefaultFontSize_ = 14.0;
    }
    return self;
}

- (CGFloat)heightOfCellForMessage:(YAMessage *)aMessage
{   
    YAMessageStatus messageStatus = [[aMessage status] intValue];
    
    if (messageStatus == YAMessageStatusSystemMessage) {
        return systemMessageCellHeight_;
    } else if (messageStatus == YAMessageStatusGapPlaceholder) {
        return gapCellHeight_;
    } else {
        CGFloat height = userMessageCellDefaultHeight_ - userMessageCellMessageBodyLabelDefaultHeight_ + [aMessage heightWithFont:[UIFont systemFontOfSize:userMessageCellMessageBodyDefaultFontSize_] width:userMessageCellMessageBodyLabelWidth_];
        return height;
    }
}

@end
