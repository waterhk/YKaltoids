//
//  YAConversationTitleFormatter.m
//  altoids
//
//  Created by Xianzhe Ma on 2/28/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAConversationTitleFormatter.h"
#import "FormattedUILabel.h"
#import "YAConversation.h"
#import "ParticipantDescriptionBuilder.h"
#import "AttributedStringCreator.h"
#import "AttributedStringBuilder.h"

@implementation YAConversationTitleFormatter

@synthesize participantDescriptionBuilder = participantDescriptionBuilder_;
@synthesize attributedStringCreator = attributedStringCreator_;
@synthesize attributedStringBuilder = attributedStringBuilder_;

- (void)formatConversationTitleLabel:(id<FormattedUILabel>)aLabel withConversation:(YAConversation *)aConversation {
    NSString *conversationTitle = [[self participantDescriptionBuilder] descriptionForParticipants:[[aConversation participants] allObjects] sizeWithFont:[aLabel font] constraintedToSize:CGSizeMake(240, 20)];
    
    CTFontRef originalFont = [aLabel originalFont ];
    CTFontRef originalFontWithBold = [aLabel originalFontWithBold];
    
    NSRange range = [conversationTitle rangeOfString:@"&"];
    
    NSMutableAttributedString *attributedString = [[self attributedStringCreator] createMutableAttributedStringWithString:conversationTitle];
    
    attributedString = [[self attributedStringBuilder] addAttributesForAttributedString:attributedString attributeName:(id)kCTFontAttributeName value:originalFontWithBold range:NSMakeRange(0, [attributedString length])];
    
    attributedString = [[self attributedStringBuilder] addAttributesForAttributedString:attributedString attributeName:(id)kCTFontAttributeName value:originalFont range:range];
    
    [aLabel setAttributedString:attributedString];
}

@end
