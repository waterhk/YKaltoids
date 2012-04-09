//
//  YAConversationMessagesListMessagesView.m
//  altoids
//
//  Created by Jon Herron on 10/25/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationMessageListMessagesView.h"

#define kConversationMessageViewNibName @"YAConversationMessageListMessagesView"

@implementation YAConversationMessageListMessagesView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) 
    {
        NSArray *viewsInNib = [[NSBundle mainBundle] loadNibNamed:kConversationMessageViewNibName owner:self options:nil];
        
        [self addSubview:[viewsInNib objectAtIndex:0]];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
