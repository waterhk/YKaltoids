//
//  YAConversationListSystemMessageCell.h
//  altoids
//
//  Created by Xianzhe Ma on 2/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversationListCell.h"

@protocol FormattedUILabel;
@protocol ConversationListDetailTextFormatter;
@protocol FormattedUILabel;
@protocol TimestampLabelFormatter;
@protocol ConversationTitleFormatter;

extern NSString * const kConversationListSystemMessageCellReuseIdentifier;

@interface YAConversationListSystemMessageCell : UITableViewCell <ConversationListCell>

@property (nonatomic, strong) id<FormattedUILabel> conversationTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *systemMessageLabel;
@property (nonatomic, strong) id<FormattedUILabel> timestampLabel;

@property (nonatomic, strong) id<ConversationListDetailTextFormatter> conversationListDetailTextFormatter;
@property (nonatomic, strong) id<TimestampLabelFormatter> timestampLabelFormatter;
@property (nonatomic, strong) id<ConversationTitleFormatter> conversationTitleFormatter;

@end
