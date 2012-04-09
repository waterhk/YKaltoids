//
//  YAConversationListGapCell.m
//  altoids
//
//  Created by Xianzhe Ma on 2/24/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationListGapCell.h"

NSString * const kConversationListGapCellIdentifier = @"YAConversationListGapCell";

@implementation YAConversationListGapCell
@synthesize gapTextLabel = gapTextLabel_;
@synthesize activityIndicator = activityIndicator_;

- (id)init {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kConversationListGapCellIdentifier];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:kConversationListGapCellIdentifier owner:self options:nil];
        self = (YAConversationListGapCell *)[nibs objectAtIndex:0];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
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

    // Configure the view for the selected state
}

- (void)bindConversation:(YAConversation *)aConversation {
    [[self activityIndicator] startAnimating];
    return;
}

@end
