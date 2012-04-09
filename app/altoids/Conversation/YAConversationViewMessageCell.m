//
//  YAConversationViewMessageCell.m
//  altoids
//
//  Created by Xianzhe Ma on 2/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationViewMessageCell.h"
#import "YAParticipant.h"
#import "YAMessage.h"
#import "ParticipantNameFormatter.h"
#import "ParticipantRepository.h"
#import "ImageScaler.h"
#import "MessageFailToSendDelegate.h"
#import "MessageStatus.h"
#import "TimestampLabelFormatter.h"
#import "FormattedUILabel.h"

NSString * const kConversationViewMessageCellReuseIdentifier = @"YAConversationViewMessageCell";

@interface YAConversationViewMessageCell ()

typedef enum {
    ConversationViewMessageCellStateNormal,
    ConversationViewMessageCellStateFailure,
} ConversationViewMessageCellState;

@property (nonatomic, strong) YAMessage *message;

@property (nonatomic, assign) ConversationViewMessageCellState state;

@end

@implementation YAConversationViewMessageCell

@synthesize participantNameFormatter = participantNameFormatter_;
@synthesize participantRepository = participantRepository_;
@synthesize imageScaler = imageScaler_;
@synthesize timestampLabelFormatter = timestampLabelFormatter_;

@synthesize senderNameLabel = senderNameLabel_;
@synthesize timestampLabel = timestampLabel_;
@synthesize avatarView = avatarView_;
@synthesize messageLabel = messageLabel_;
@synthesize actionButton = actionButton_;
@synthesize delegate = delegate_;

@synthesize state = state_;
@synthesize message = message_;

- (id)init {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kConversationViewMessageCellReuseIdentifier];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:kConversationViewMessageCellReuseIdentifier owner:self options:nil];
        self = (YAConversationViewMessageCell *)[nibs objectAtIndex:0];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self setState:ConversationViewMessageCellStateNormal];
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

- (void) setAvatar:(UIImage *)image 
{
    [[self avatarView] setImage:image];
}

- (void)greyOutAvatarAndTimeStampAndSenderNameAndMessageBody
{
    [[self timestampLabel] setAlpha:0.5];
    [[self messageLabel] setAlpha:0.5];
    [[self avatarView] setAlpha:0.5];
    [[self senderNameLabel] setAlpha:0.5];
}

- (void)restoreAlphaOfAvatarAndTimeStampAndSenderNameAndMessageBody
{
    [[self timestampLabel] setAlpha:1];
    [[self messageLabel] setAlpha:1];
    [[self avatarView] setAlpha:1];
    [[self senderNameLabel] setAlpha:1];
}

- (void)bindMessage:(YAMessage *)aMessage {
    [self setMessage:aMessage];
    
    switch ([[aMessage status] intValue]) {
        case YAMessageStatusPendingWithErrors:
            [self setState:ConversationViewMessageCellStateFailure];
            [self greyOutAvatarAndTimeStampAndSenderNameAndMessageBody];
            break;
        case YAMessageStatusPending:
            [self setState:ConversationViewMessageCellStateNormal];
            [self greyOutAvatarAndTimeStampAndSenderNameAndMessageBody];
            break;
        default:
            [self setState:ConversationViewMessageCellStateNormal];
            [self restoreAlphaOfAvatarAndTimeStampAndSenderNameAndMessageBody];
            break;
    }
    
    /* sender */
    YAParticipant *messageSender = [aMessage sender];
    NSString *messageSenderName = [[self participantNameFormatter] formatDisplayNameForParticipant:messageSender];
    [[self senderNameLabel] setText:messageSenderName];
    
    /* message */
    [[self messageLabel] setText:[aMessage body]];
    
    /* avatar */
    UIImage *participantImage = [[self participantRepository] imageForParticipant:messageSender]; 
    
    if (!participantImage) 
    {
        participantImage = [UIImage imageNamed:kIconDefaultUserProfileImage];
    }
    
    if (participantImage) 
    {
        participantImage = [[self imageScaler] scaleImage:participantImage toSize:[[self avatarView] frame].size];
        [self setAvatar:participantImage];
    }
    
    /* timestamp */
    [[self timestampLabelFormatter] formatLabel:[self timestampLabel] withMessage:aMessage];
    
    /* bg colors */
    if ([[aMessage read] boolValue]==NO) {        
        UIView *backgroundView = [[UIView alloc] initWithFrame:[self frame]];
        [backgroundView setBackgroundColor:kUnreadMessageBackgroundColor];
        [self setBackgroundView:backgroundView];
        
        [[self senderNameLabel] setBackgroundColor:kUnreadMessageBackgroundColor];
        [[self messageLabel] setBackgroundColor:kUnreadMessageBackgroundColor];
        [[self contentView] setBackgroundColor:kUnreadMessageBackgroundColor];
        [[self timestampLabel] setBackgroundColor:kUnreadMessageBackgroundColor];
    } else {
        [[self backgroundView] removeFromSuperview];
        
        [[self senderNameLabel] setBackgroundColor:[UIColor whiteColor]];
        [[self messageLabel] setBackgroundColor:[UIColor whiteColor]];
        [[self contentView] setBackgroundColor:[UIColor whiteColor]];
        [[self timestampLabel] setBackgroundColor:[UIColor whiteColor]];
    }
}

typedef enum {
    FailToSendActionSheetButtonIndexResend = 0,
    FailToSendActionSheetButtonIndexDelete = 1,
    FailToSendActionSheetButtonIndexCancel = 2,
} FailToSendActionSheetButtonIndex;

- (IBAction)presentActionSheet:(id)sender {
    UIActionSheet *failToSendActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [failToSendActionSheet addButtonWithTitle:kActionSheetResendButtonLabel];
    [failToSendActionSheet addButtonWithTitle:kActionSheetDeleteButtonLabel];
    [failToSendActionSheet addButtonWithTitle:kActionSheetCancelButtonLabel];
    [failToSendActionSheet setDestructiveButtonIndex:FailToSendActionSheetButtonIndexDelete];
    [failToSendActionSheet setCancelButtonIndex:FailToSendActionSheetButtonIndexCancel];
    [failToSendActionSheet showInView:[[self superview] superview]];
}

- (void)setState:(ConversationViewMessageCellState)aState {
    switch (aState) {
        case ConversationViewMessageCellStateNormal:
            [[self timestampLabel] setHidden:NO];
            [[self actionButton] setHidden:YES];
            break;
        case ConversationViewMessageCellStateFailure:
            [[self timestampLabel] setHidden:YES];
            [[self actionButton] setHidden:NO];
            break;
        default:
            break;
    }
    state_ = aState;
}

#pragma mark -
#pragma mark UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)aButtonIndex {
    switch (aButtonIndex) {
        case FailToSendActionSheetButtonIndexDelete:
            [[self delegate] didRequestToDeleteMessage:[self message]];
            break;
        case FailToSendActionSheetButtonIndexResend:
            [[self delegate] didRequestToResendMessage:[self message]];
            break;
        default:
            break;
    }
}

@end
