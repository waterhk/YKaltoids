//
//  YAConversationViewGapCell.h
//  altoids
//
//  Created by Xianzhe Ma on 2/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversationViewCell.h"

extern NSString * const kConversationViewGapCellReuseIdentifier;

@interface YAConversationViewGapCell : UITableViewCell <ConversationViewCell>

@property (nonatomic, strong) IBOutlet UILabel *gapMessageLabel;

@end
