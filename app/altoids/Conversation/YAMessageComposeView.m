//
//  YAMessageComposeView.m
//  altoids
//
//  Created by Jon Herron on 10/25/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "YAMessageComposeView.h"

@interface YAMessageComposeView()
{
    UIColor* ghostTextColor;
    UIColor* defaultTextColor;
    UIColor* defaultCharCountColor;
    UIColor* charCountExceededColor;
}
- (void)setupButton:(UIButton *)theButton withImage:(NSString*)theImage forState:(UIControlState)aState;
@end

#define kMessageReplyViewNibName @"YAMessageComposeView"

CGFloat const kReplyViewCornerRadius = 20.0;
CGFloat const kReplyViewShadowRadius = 10.0;
CGFloat const kReplyViewShadowOpacity = 0.8;

CGFloat const kReplyViewOriginX = 4.0;
CGFloat const kReplyViewOriginY = 15.0;
CGFloat const kReplyViewPaddingRight = 8.0;

CGFloat const kReplyViewTextFieldOriginXOffset = 5.0;
CGFloat const kReplyViewTextFieldOriginYOffset = 3.0;
CGFloat const kReplyViewTextFieldPaddingRight = 10.0;
CGFloat const kReplyViewTextFieldPaddingBottom = 5.0;

@implementation YAMessageComposeView

@synthesize textFieldContainterView = textFieldContainterView_;
@synthesize charCountView = charCountView_;
@synthesize currentCharacterCount = currentCharacterCount_;
@synthesize sendButton = sendButton_;
@synthesize messageComposeTextView = messageComposeTextView_;
@synthesize messageComposeView = messageComposeView_;

@synthesize messageComposeViewDelegate = messageComposeViewDelegate_;
@synthesize maximumCharactersAllowed = maximumCharactersAllowed_;
@synthesize originalViewFrame = originalViewFrame_;
@synthesize state = state_;
@synthesize minHeight = minHeight_;
@synthesize maxHeight = maxHeight_;

@synthesize textViewSingleLineHeight = textViewSingleLineHeight_;
@synthesize textViewMaxHeight = textViewMaxHeight_;
@synthesize textViewDefaultFrame = textViewDefaultFrame_;
@synthesize textViewMaxFrame = textViewMaxFrame_;
@synthesize containerViewDefaultFrame = containerViewDefaultFrame_;
@synthesize containerViewFrameWithControls = containerViewFrameWithControls_;
@synthesize userInputMaxSize = userInputMaxSize_;
@synthesize messageComposeDefaultFrame = messageComposeDefaultFrame_;

@synthesize ghostTextColorUED = ghostTextColorUED_;
@synthesize cornerRadiusUED = cornerRadiusUED_;
@synthesize borderWidthUED = borderWidthUED_;
@synthesize borderColorUED = borderColorUED_;
@synthesize charExceededColorUED = charExceededColorUED_;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) 
    {
        [self initialize];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        [self initialize];
    }
    
    return self;
}

- (void)initialize
{
    NSArray *viewsInNib = [[NSBundle mainBundle] loadNibNamed:kMessageReplyViewNibName owner:self options:nil];
    UIView *viewFromNib = [viewsInNib objectAtIndex:0];
    [viewFromNib setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kConversationReplyViewBackgroundImage]]];
    [viewFromNib setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:viewFromNib];
    
    [messageComposeTextView_ setText:kReplyToConversationHint];
    
    CALayer *textFieldContainerLayer = [[self textFieldContainterView] layer];
    [textFieldContainerLayer setCornerRadius:[[cornerRadiusUED_ text] floatValue]];
    [textFieldContainerLayer setBorderWidth:[[borderWidthUED_ text] floatValue]];
    [textFieldContainerLayer setBorderColor:[[borderColorUED_ backgroundColor] CGColor]];    

    [self setupButton:sendButton_ withImage:kMessageComposeSendButton forState:UIControlStateNormal];
    [sendButton_ setTitle:kSendButtonText forState:UIControlStateNormal];
    
    defaultTextColor = [messageComposeTextView_ textColor];
    ghostTextColor = [ghostTextColorUED_ backgroundColor];
    [messageComposeTextView_ setTextColor:ghostTextColor];
    defaultCharCountColor = [currentCharacterCount_ textColor];
    charCountExceededColor = [charExceededColorUED_ backgroundColor];
    
    [[self charCountView] setHidden:YES];
    
    [self calculateAndStoreTextViewAndContainerDefaultValues];
    [self renderDefaultState];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)injectWithMessageComposeViewDelegate:(id<MessageComposeViewDelegate>)delegate 
                                         maximumCharactersAllowed:(NSUInteger)theMaximumCharactersAllowed
{
    [self setMessageComposeViewDelegate:delegate];
    [self setMaximumCharactersAllowed:theMaximumCharactersAllowed];    
}

- (IBAction)messageSendTouchDown:(id)sender
{
    if ([self state]==ReplyStateUp) {
        [[self messageComposeViewDelegate] didEndComposingMessage];
    }
    
    [messageComposeTextView_ setText:kTextViewPlaceHolderText];
    [messageComposeTextView_ setTextColor:ghostTextColor];

    [[self messageComposeViewDelegate] messageComposedWithText:[messageComposeTextView_ text]];
    
    [self setState:ReplyStateDown];

    [messageComposeTextView_ setText:kTextViewPlaceHolderText];
    [messageComposeTextView_ setTextColor:ghostTextColor];
    
    [messageComposeTextView_ resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self state]==ReplyStateDown) {
        [[self messageComposeViewDelegate] didBeginComposingMessage];
    }

    if ([[textView text] isEqualToString:kTextViewPlaceHolderText]) 
    {
        //TODO: make the cursor go back to beginning, don't know why this didn't do the trick
        [textView setSelectedRange:NSMakeRange(0, 0)];
    }
    
    CGRect textContainerFrame = [textFieldContainterView_ frame];
    textContainerFrame.size.width = containerViewFrameWithControls_.size.width;
    [[self textFieldContainterView] setFrame:textContainerFrame];
    
    [self updateCharacterCountAndSendButtonEnabledStatusForUserInput:[textView text]];
    [self resizeContainerViewFrameToFitUserInput];
    
    [sendButton_ setHidden:NO];
    [self alignBottomOfSendButtonWithBottomOfTextField];
    
    [self setState:ReplyStateUp];   
}

- (void)textViewDidEndEditing:(UITextView *)textView
{    
    if ([self state]==ReplyStateUp) {
        [[self messageComposeViewDelegate] didEndComposingMessage];
    }
    
    if ([[textView text] isEqualToString:@""]) 
    {
        [textView setText:kTextViewPlaceHolderText];
        [textView setTextColor:ghostTextColor];
    }
    
    CGRect textContainerFrame = [textFieldContainterView_ frame];
    textContainerFrame.size.width = containerViewDefaultFrame_.size.width;
    [[self textFieldContainterView] setFrame:textContainerFrame];
    [self resizeContainerViewFrameToFitUserInput];
    
    [[self charCountView] setHidden:YES];
    [sendButton_ setHidden:YES];

    [self setState:ReplyStateDown];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // send message
    [textField resignFirstResponder];
    [[self charCountView] setHidden:YES];
    
    if ([self state]==ReplyStateUp) {
        [[self messageComposeViewDelegate] didEndComposingMessage];
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([[textView text] isEqualToString:kTextViewPlaceHolderText]) 
    {
        [textView setText:@""];
        [textView setTextColor:defaultTextColor];
        
        //TODO: make the cursor go back to beginning, don't know why this didn't do the trick
        [textView setSelectedRange:NSMakeRange(0, 0)];
    }
    
    [self updateCharacterCountAndSendButtonEnabledStatusForUserInput:[textView text]];
    [self resizeContainerViewFrameToFitUserInput];
    
    return YES;
}

- (void)updateCharacterCountAndSendButtonEnabledStatusForUserInput:(NSString *)userInput
{
    NSUInteger userInputLength = [userInput length];
    bool inErrorState = (state_ == ReplyStateError);
    BOOL sendButtonEnabled = (userInputLength > 0) && !inErrorState;
    
    if (userInputLength > maximumCharactersAllowed_)
    {
        if (!inErrorState)
        {
            [currentCharacterCount_ setTextColor:charCountExceededColor];
            [self setState:ReplyStateError];
            sendButtonEnabled = false;
        }
    }
    else 
    {
        if (inErrorState)
        {
            [currentCharacterCount_ setTextColor:defaultCharCountColor];
            [self setState:ReplyStateUp];
            sendButtonEnabled = true;
        }
    }
    [currentCharacterCount_ setText:[NSString stringWithFormat:@"%d", userInputLength]];
    
    if (sendButtonEnabled) 
    {
        sendButtonEnabled = [messageComposeViewDelegate_ messageComposeViewCanEnableSendButton];
    }
    
    [sendButton_ setEnabled:sendButtonEnabled];
}

- (void)resizeContainerViewFrameToFitUserInput
{
    NSString *userInput = [messageComposeTextView_ text];
    
    CGSize userInputSize = [userInput sizeWithFont:[messageComposeTextView_ font] constrainedToSize:userInputMaxSize_];
    
    if (userInputSize.height < textViewDefaultFrame_.size.height) 
    {
        userInputSize.height = textViewDefaultFrame_.size.height;
    }
    
    CGRect textViewFrame = [messageComposeTextView_ frame];
    CGRect charCountFrame = [charCountView_ frame];
    NSInteger lineHeight = 19;
    NSInteger numLines = userInputSize.height / lineHeight;
    bool isOneLineOrLess = (numLines <= 1);
    
    [charCountView_ setHidden:isOneLineOrLess];
    
    if (userInputSize.height != textViewFrame.size.height) 
    {        
        //Readjust the textView size to accomodate more lines
        NSInteger pad = (isOneLineOrLess ? 0 : 10);
        textViewFrame.size.height = userInputSize.height;
        [messageComposeTextView_ setFrame:textViewFrame];
        
        CGRect containerViewFrame = [textFieldContainterView_ frame];
        CGRect newContainerViewFrame = containerViewFrame;
        
        newContainerViewFrame.size.height = userInputSize.height + pad;
        [textFieldContainterView_ setFrame:newContainerViewFrame];
        
        //Modify messageCompose height
        CGFloat heightDiff = newContainerViewFrame.size.height - containerViewFrame.size.height;
        CGRect messageComposeFrame = [messageComposeView_ frame];
        messageComposeFrame.size.height += heightDiff;
        [messageComposeView_ setFrame:messageComposeFrame];
        
        [messageComposeViewDelegate_ messageComposeViewDidResizeFromFrame:containerViewFrame toFrame:newContainerViewFrame];
        
        //Position and display the character counter and send button
        
        NSInteger newY = newContainerViewFrame.origin.y;
        
        if (numLines == 3)
        {
            newY += 10;
        }
        charCountFrame.origin.y = newY;
        [charCountView_ setFrame:charCountFrame];
        [self alignBottomOfSendButtonWithBottomOfTextField];
    }
}

- (void)renderDefaultState
{
    [self setState:ReplyStateDown];
    [[self currentCharacterCount] setText:@"0"];
    [[self sendButton] setEnabled:NO];
    [[self textFieldContainterView] setFrame:containerViewDefaultFrame_];
    [[self charCountView] setHidden:YES];
    [sendButton_ setHidden:YES];
}

- (void)messageComposeShouldEnd
{
    [messageComposeTextView_ resignFirstResponder];
}

- (void)renderSingleLineEditMode
{
    [messageComposeTextView_ setText:kReplyToConversationHint];
}

- (void)calculateAndStoreTextViewAndContainerDefaultValues
{
    messageComposeDefaultFrame_ = [messageComposeView_ frame];
    CGSize hintTextSize = [[messageComposeTextView_ text] sizeWithFont:[messageComposeTextView_ font]];
    
    textViewSingleLineHeight_ = hintTextSize.height + 4; // text view line height padding, sizeWithFont does not know about this value
    textViewMaxHeight_ = textViewSingleLineHeight_ * 3; // max three lines for the text view
    
    textViewDefaultFrame_ = [messageComposeTextView_ frame];
    containerViewFrameWithControls_ = [textFieldContainterView_ frame];
    
    CGFloat buttonWidth = [sendButton_ frame].size.width;
    CGFloat buttonPad = ([messageComposeView_ frame].size.width - (containerViewFrameWithControls_.size.width + buttonWidth)) / 3;
    containerViewDefaultFrame_ = [textFieldContainterView_ frame];
    containerViewDefaultFrame_.size.width += buttonWidth + buttonPad;
    
    textViewMaxFrame_ = textViewDefaultFrame_;
    textViewMaxFrame_.size.height = textViewMaxHeight_;
    
    CGRect charCountFrame = [charCountView_ frame];
    userInputMaxSize_ = textViewMaxFrame_.size;
    userInputMaxSize_.width -= charCountFrame.size.width;
    userInputMaxSize_.width -= kReplyViewTextFieldPaddingRight;
}

- (void)clearDelegate:(id)delegate
{
    if (messageComposeViewDelegate_ == delegate) 
    {
        messageComposeViewDelegate_ = nil;
    }
}

//TODO: move this code into a common object for button creation
- (void)setupButton:(UIButton *)theButton withImage:(NSString*)theImage forState:(UIControlState)aState
{
    UIImage* buttonImage = [UIImage imageNamed:theImage];
    
    CGSize imageSize = [buttonImage size];   
    NSInteger leftCapWidth = floorf(imageSize.width / 2);
    
    [theButton setBackgroundImage:[buttonImage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:0] forState:aState];
}

- (void) alignBottomOfSendButtonWithBottomOfTextField
{
    CGRect textFieldFrame = [textFieldContainterView_ frame];
    CGRect sendBtnFrame = [sendButton_ frame];
    sendBtnFrame.origin.y = (textFieldFrame.size.height - sendBtnFrame.size.height) + textFieldFrame.origin.y;
    [sendButton_ setFrame:sendBtnFrame];
}

@end
