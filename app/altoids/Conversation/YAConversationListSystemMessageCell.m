//
//  YAConversationListSystemMessageCell.m
//  altoids
//
//  Created by Xianzhe Ma on 2/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationListSystemMessageCell.h"
#import "YAConversation.h"
#import "ConversationListDetailTextFormatter.h"
#import "FormattedUILabel.h"
#import "TimestampLabelFormatter.h"
#import "ConversationTitleFormatter.h"

NSString * const kConversationListSystemMessageCellReuseIdentifier = @"YAConversationListSystemMessageCell";

@implementation YAConversationListSystemMessageCell

@synthesize conversationTitleLabel = conversationTitleLabel_;
@synthesize systemMessageLabel = systemMessageLabel_;
@synthesize timestampLabel = timestampLabel_;

@synthesize conversationListDetailTextFormatter = conversationListDetailTextFormatter_;
@synthesize timestampLabelFormatter = timestampLabelFormatter_;
@synthesize conversationTitleFormatter = conversationTitleFormatter_;

- (id)init {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kConversationListSystemMessageCellReuseIdentifier];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:kConversationListSystemMessageCellReuseIdentifier owner:self options:nil];
        self = (YAConversationListSystemMessageCell *)[nibs objectAtIndex:0];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)bindConversation:(YAConversation *)aConversation {
    [[self conversationTitleFormatter] formatConversationTitleLabel:[self conversationTitleLabel] withConversation:aConversation];
    [[self timestampLabelFormatter] formatLabel:[self timestampLabel] withConversation:aConversation];

    //system message label content
    NSString *detailText = [[self conversationListDetailTextFormatter] detailTextForConversation:aConversation];
    [[self systemMessageLabel] setText:detailText];
}

@end
