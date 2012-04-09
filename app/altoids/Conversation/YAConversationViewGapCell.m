//
//  YAConversationViewGapCell.m
//  altoids
//
//  Created by Xianzhe Ma on 2/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationViewGapCell.h"

NSString * const kConversationViewGapCellReuseIdentifier = @"YAConversationViewGapCell";

@implementation YAConversationViewGapCell

@synthesize gapMessageLabel = gapMessageLabel_;
@synthesize delegate = delegate_;

- (id)init {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kConversationViewGapCellReuseIdentifier];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:kConversationViewGapCellReuseIdentifier owner:self options:nil];
        self = (YAConversationViewGapCell *)[nibs objectAtIndex:0];
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

- (void)bindMessage:(YAMessage *)aMessage {
    return;
}

- (void) setAvatar:(UIImage *)image {
    
}

@end
