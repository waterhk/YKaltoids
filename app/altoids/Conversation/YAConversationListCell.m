//
//  YAConversationListCell.m
//  altoids
//
//  Created by Xianzhe Ma on 2/6/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationListCell.h"
#import "YAConversation.h"
#import "ConversationListDetailTextFormatter.h"
#import "FormattedUILabel.h"
#import "TimestampLabelFormatter.h"
#import "ConversationTitleFormatter.h"
#import "YAMessage.h"
#import "MessageStatus.h"

NSString * const kConversationListCellIdentifier = @"YAConversationListCell";

@interface YAConversationListCell ()

typedef enum {
    ConversationListCellStateNormal,
    ConversationListCellStateFailure,
} ConversationListCellState;

@property (nonatomic, assign) ConversationListCellState state;

@end

@implementation YAConversationListCell

@synthesize conversationTitleLabel = conversationTitleLabel_;
@synthesize conversationDetailLabel = conversationDetailLabel_;
@synthesize timestampLabel = timestampLabel_;
@synthesize actionButton = actionButton_;

@synthesize conversationListDetailTextFormatter = conversationListDetailTextFormatter_;
@synthesize timestampLabelFormatter = timestampLabelFormatter_;
@synthesize conversationTitleFormatter = conversationTitleFormatter_;

@synthesize state = state_;

- (id)init {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kConversationListCellIdentifier];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:kConversationListCellIdentifier owner:self options:nil];
        self = (YAConversationListCell *)[nibs objectAtIndex:0];
        
        [self setState:ConversationListCellStateNormal];
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

- (void)bindConversation:(YAConversation *)aConversation 
{
    [[self conversationTitleFormatter] formatConversationTitleLabel:[self conversationTitleLabel] withConversation:aConversation];
    
    if ([[[aConversation mostRecentMessage] status] intValue] == YAMessageStatusPendingWithErrors) {
        [self setState:ConversationListCellStateFailure];
    } else {
        [self setState:ConversationListCellStateNormal];
        [[self timestampLabelFormatter] formatLabel:[self timestampLabel] withConversation:aConversation];
    }
    
    //detail label content
    [[self conversationListDetailTextFormatter] formatDetailLabel:[self conversationDetailLabel] forConversation:aConversation];
}

- (void)setState:(ConversationListCellState)aState
{
    switch (aState) {
        case ConversationListCellStateNormal:
            [[self actionButton] setHidden:YES];
            [((UILabel *)[self timestampLabel]) setHidden:NO];
            [[self conversationDetailLabel] setAlpha:1];
            break;
        case ConversationListCellStateFailure:
            [[self actionButton] setHidden:NO];
            [((UILabel *)[self timestampLabel]) setHidden:YES];
            [[self conversationDetailLabel] setAlpha:0.5];
            break;
        default:
            break;
    }
    state_ = aState;
}

@end
