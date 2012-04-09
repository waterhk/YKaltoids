//
//  YAConversationViewSystemMessageCell.m
//  altoids
//
//  Created by Xianzhe Ma on 2/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationViewSystemMessageCell.h"
#import "YAMessage.h"

NSString * const kConversationViewSystemMessageCellReuseIdentifier = @"YAConversationViewSystemMessageCell";
NSString * const kSystemMessageFlagImage = @"sysMsgFlg.png";

@implementation YAConversationViewSystemMessageCell

@synthesize systemMessageLabel = systemMessageLabel_;
@synthesize systemMessageFlagView = systemMessageFlagView_;
@synthesize delegate = delegate_;

- (id)init {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kConversationViewSystemMessageCellReuseIdentifier];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:kConversationViewSystemMessageCellReuseIdentifier owner:self options:nil];
        self = (YAConversationViewSystemMessageCell *)[nibs objectAtIndex:0];
        
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
}

- (void)bindMessage:(YAMessage *)aMessage {
    [[self systemMessageLabel] setText:[aMessage body]];
}

- (void) setAvatar:(UIImage *)image {
    
}

@end
