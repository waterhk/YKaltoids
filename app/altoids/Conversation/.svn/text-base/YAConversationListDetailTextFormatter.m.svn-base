//
//  YAConversationListDetailTextFormatter.m
//  altoids
//
//  Created by Jon Herron on 11/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationListDetailTextFormatter.h"
#import "YAMessage.h"
#import "YAParticipant.h"
#import "FormattedUILabel.h"
#import "AttributedStringCreator.h"
#import "AttributedStringBuilder.h"

@interface YAConversationListDetailTextFormatter ()

- (YAMessage *)mostRecentMessageForConversation:(YAConversation *)theConversation;

@end

@implementation YAConversationListDetailTextFormatter

@synthesize conversationHandler = conversationHandler_;
@synthesize messageHandler = messageHandler_;
@synthesize participantNameFormatter = participantNameFormatter_;
@synthesize attributedStringCreator = attributedStringCreator_;
@synthesize attributedStringBuilder = attributedStringBuilder_;

- (YAMessage *)mostRecentMessageForConversation:(YAConversation *)theConversation
{   
    return [[self conversationHandler] mostRecentMessageForConversation:theConversation];
}

- (NSString *)detailTextForConversation:(YAConversation *)theConversation
{
    YAMessage *mostRecentMessage = [self mostRecentMessageForConversation:theConversation];
    NSString *snippet = [[self messageHandler] snippetForMessage:mostRecentMessage];
    if (!snippet) {
        return @"";
    }
    return snippet;
}

- (NSString *)senderDisplayNameForConversation:(YAConversation *)theConversation
{
    YAMessage *mostRecentMessage = [self mostRecentMessageForConversation:theConversation];
    if (!mostRecentMessage) 
    {
        return @"";
    }
    
    YAParticipant *mostRecentMessageSender = [[self messageHandler] senderForMessage:mostRecentMessage];    
    NSString *mostRecentMessageSenderDisplayName = [[self participantNameFormatter] formatShortNameForParticipant:mostRecentMessageSender];
    BOOL mostRecentMessageSenderDisplayNameAvailable = [mostRecentMessageSenderDisplayName length] > 0;    
    
    if (mostRecentMessageSenderDisplayNameAvailable) 
    {
        return [NSString stringWithFormat:@"%@: ", mostRecentMessageSenderDisplayName];
    }
    else 
    {
        return @"";
    }    
}

- (void)formatDetailLabel:(UILabel<FormattedUILabel> *)aDetailLabel forConversation:(YAConversation *)aConversation
{
    //detail label content
    NSString *detailText = [self detailTextForConversation:aConversation];
    NSString *senderText = [self senderDisplayNameForConversation:aConversation];
    NSString *displayText = [NSString stringWithFormat:@"%@%@", senderText, detailText];
        
    NSMutableAttributedString *boldedSenderDisplayText = [[self attributedStringCreator] createMutableAttributedStringWithString:displayText];
    
    NSRange senderTextRange = [displayText rangeOfString:senderText];
    boldedSenderDisplayText = [[self attributedStringBuilder] addAttributesForAttributedString:boldedSenderDisplayText 
                                                                                 attributeName:(id)kCTFontAttributeName 
                                                                                         value:[aDetailLabel originalFontWithBold] 
                                                                                         range:senderTextRange];
    
    NSRange detailTextRange = [displayText rangeOfString:detailText];
    boldedSenderDisplayText = [[self attributedStringBuilder] addAttributesForAttributedString:boldedSenderDisplayText 
                                                                                 attributeName:(id)kCTFontAttributeName 
                                                                                         value:[aDetailLabel originalFont] 
                                                                                         range:detailTextRange];
    
    [aDetailLabel setAttributedString:boldedSenderDisplayText];
}

@end
