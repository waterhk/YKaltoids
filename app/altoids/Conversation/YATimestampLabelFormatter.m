//
//  YATimestampLabelFormatter.m
//  altoids
//
//  Created by Xianzhe Ma on 2/28/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATimestampLabelFormatter.h"
#import "YAConversation.h"
#import "FormattedUILabel.h"
#import "ConversationHandler.h"
#import "AttributedStringCreator.h"
#import "AttributedStringBuilder.h"
#import "TimestampFormatter.h"
#import "YAMessage.h"

@implementation YATimestampLabelFormatter

@synthesize conversationHandler = conversationHandler_;
@synthesize attributedStringCreator = attributedStringCreator_;
@synthesize attributedStringBuilder = attributedStringBuilder_;
@synthesize timestampFormatter = timestampFormatter_;

- (void)formatLabel:(id<FormattedUILabel>)aLabel withString:(NSString *)aString {
    if (!aString) {
        aString = @"";
    }
    
    CTFontRef originalFontForTimeStamp = [aLabel originalFont];
    CTFontRef originalFontForTimeStampWithBold = [aLabel originalFontWithBold];
    
    NSString *timestampText = [aString uppercaseString];
    NSMutableAttributedString *timestampAttributedString = [[self attributedStringCreator] createMutableAttributedStringWithString:timestampText];;
    
    NSRange rangeForSlash = [timestampText rangeOfString:@"/"];
    //If there is a match for dd/dd/dd format
    if (rangeForSlash.location != NSNotFound) 
    {
        timestampAttributedString = [[self attributedStringBuilder] addAttributesForAttributedString:timestampAttributedString 
                                                                                       attributeName:(id)kCTFontAttributeName 
                                                                                               value:originalFontForTimeStamp 
                                                                                               range:NSMakeRange(0, [timestampAttributedString length])];
    } else {
        NSRange rangeForLastSpace = [timestampText rangeOfString:@" " options:NSBackwardsSearch];
        if (rangeForLastSpace.location != NSNotFound) {
            //part before last space
            timestampAttributedString = [[self attributedStringBuilder] addAttributesForAttributedString:timestampAttributedString 
                                                                                           attributeName:(id)kCTFontAttributeName 
                                                                                                   value:originalFontForTimeStampWithBold
                                                                                                   range:NSMakeRange(0, rangeForLastSpace.location)];
            
            //part after last space
            timestampAttributedString = [[self attributedStringBuilder] addAttributesForAttributedString:timestampAttributedString 
                                                                                           attributeName:(id)kCTFontAttributeName 
                                                                                                   value:originalFontForTimeStamp 
                                                                                                   range:NSMakeRange(rangeForLastSpace.location, [timestampAttributedString length] - rangeForLastSpace.location)];
        } else {
            timestampAttributedString = [[self attributedStringBuilder] addAttributesForAttributedString:timestampAttributedString 
                                                                                           attributeName:(id)kCTFontAttributeName 
                                                                                                   value:originalFontForTimeStamp 
                                                                                                   range:NSMakeRange(0, [timestampAttributedString length])];
        }
    }
    
    //set alignment of the NSAttributedString to be right alignment
    [[self attributedStringBuilder] addAlignment:kCTRightTextAlignment toAttributedString:timestampAttributedString];
    
    //set label's text to be the result NSAttributedString above
    [aLabel setAttributedString:timestampAttributedString];
}

- (void)formatLabel:(id<FormattedUILabel>)aLabel withConversation:(YAConversation *)aConversation {
    NSString *timestampLabelText = nil;
    if ([[self conversationHandler] conversationStatusIsPending:aConversation]) 
    {
        timestampLabelText = kPendingStatusMessage;
    } else {
        timestampLabelText = [timestampFormatter_ formatTimestampToString:[aConversation timestamp]];
    }
    [self formatLabel:aLabel withString:timestampLabelText];
    
    //set label's color
    if ([[self conversationHandler] hasUnreadMessagesForConversation:aConversation]) {
        [aLabel setTextColor:kUnreadMessageTimestampTextColor];
    } else {
        [aLabel setTextColor:kMessageTimestampTextColor];
    }
}

- (void)formatLabel:(id<FormattedUILabel>)aLabel withMessage:(YAMessage *)aMessage
{
    NSString *messageSentDescription = nil;
    if ([[aMessage messageID] length] > 0) 
    {
        messageSentDescription = [timestampFormatter_ formatTimestampToString:[aMessage timestamp]];
    }
    else
    {
        messageSentDescription = kPendingStatusMessage;
    }
    [self formatLabel:aLabel withString:messageSentDescription];
    
    //set label's color
    [aLabel setTextColor:[UIColor darkGrayColor]];
}

@end
