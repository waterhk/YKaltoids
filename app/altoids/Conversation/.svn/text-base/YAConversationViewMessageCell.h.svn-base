//
//  YAConversationViewMessageCell.h
//  altoids
//
//  Created by Xianzhe Ma on 2/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversationViewCell.h"

@protocol MessageFailToSendDelegate;
@protocol ParticipantNameFormatter;
@protocol ParticipantRepository;
@protocol ImageScaler;
@protocol FormattedUILabel;
@protocol TimestampLabelFormatter;

extern NSString * const kConversationViewMessageCellReuseIdentifier;

@interface YAConversationViewMessageCell : UITableViewCell <ConversationViewCell, UIActionSheetDelegate>

@property (nonatomic, strong) id<ParticipantNameFormatter> participantNameFormatter;
@property (nonatomic, strong) id<ParticipantRepository> participantRepository;
@property (nonatomic, strong) id<ImageScaler> imageScaler;
@property (nonatomic, strong) id<TimestampLabelFormatter> timestampLabelFormatter;

@property (nonatomic, strong) IBOutlet UILabel *senderNameLabel;
@property (nonatomic, strong) IBOutlet UILabel<FormattedUILabel> *timestampLabel;
@property (nonatomic, strong) IBOutlet UIImageView *avatarView;
@property (nonatomic, strong) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) IBOutlet UIButton *actionButton;

- (IBAction)presentActionSheet:(id)sender;

@end
