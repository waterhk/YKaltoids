//
//  YAConversationListCell.h
//  altoids
//
//  Created by Xianzhe Ma on 2/6/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConversationListCell.h"
#import "AttributedStringCreator.h"
#import "AttributedStringBuilder.h"

extern NSString * const kConversationListCellIdentifier;

@protocol FormattedUILabel;
@protocol ConversationListDetailTextFormatter;
@protocol TimestampLabelFormatter;
@protocol ConversationTitleFormatter;

@interface YAConversationListCell : UITableViewCell <ConversationListCell>

@property (nonatomic, strong) IBOutlet UILabel<FormattedUILabel> *conversationTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel<FormattedUILabel> *conversationDetailLabel;
@property (nonatomic, strong) IBOutlet UILabel<FormattedUILabel> *timestampLabel;
@property (nonatomic, strong) IBOutlet UIButton *actionButton;

@property (nonatomic, strong) id<ConversationListDetailTextFormatter> conversationListDetailTextFormatter;
@property (nonatomic, strong) id<TimestampLabelFormatter> timestampLabelFormatter;
@property (nonatomic, strong) id<ConversationTitleFormatter> conversationTitleFormatter;

@end
