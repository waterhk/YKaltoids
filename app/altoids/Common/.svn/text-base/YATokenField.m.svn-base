//
//  YATokenField.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAGradientLayer.h>

#import "YATokenField.h"

@interface YATokenField() 

@property (nonatomic, copy) NSString* text;
@property (nonatomic, assign) BOOL representsValidAddress;
@property (nonatomic, assign) BOOL cancelledSelection;
@property (nonatomic, strong) id<TokenFieldDelegate> delegate;

@end

@implementation YATokenField

@synthesize selected = selected_;
@synthesize text = text_;
@synthesize representsValidAddress = representsValidAddress_;
@synthesize cancelledSelection = cancelledSelection_;

@synthesize delegate = delegate_;

- (id)initWithFrame:(CGRect)frame 
               text:(NSString *)text
representsValidAddress:(BOOL)representsValidAddress
           delegate:(id<TokenFieldDelegate>)delegate
{
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        text_ = text;
        representsValidAddress_ = representsValidAddress;
        delegate_ = delegate;
        selected_ = NO;
        
        [[self layer] setCornerRadius:12.0];
        [[self layer] setBorderWidth:1.0];
        
        [self setBackgroundAndBorderColors];
        [self setNeedsDisplay];
    }
    
    return self;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)setBackgroundAndBorderColors
{
    UIColor *backgroundColor;
    UIColor *borderColor;
    UIColor *fillColor;
    
    if (selected_) 
    {
        backgroundColor = kSelectedLozengeBackgroundColor;
        borderColor = kSelectedLozengeBorderColor;
        
        fillColor = kSelectedLozengeFillColor;
    }
    else
    {
        if (representsValidAddress_)
        {
            backgroundColor = kLozengeBackgroundColorForParticipantWithValidAddress;
            borderColor = kLozengeBorderColorForParticipantWithValidAddress;
        }
        else
        {
            backgroundColor = kLozengeBackgroundColorForParticipantWithInvalidAddress;
            borderColor = kLozengeBorderColorForParticipantWithInvalidAddress;
        }
        
        fillColor = kLozengeFillColor;
    }
    
    [self setBackgroundColor:[UIColor clearColor]];
    [[self layer] setBackgroundColor:[backgroundColor CGColor]];
    [[self layer] setBorderColor:[borderColor CGColor]];
    
    [fillColor set];
}

- (void)drawRect:(CGRect)rect
{
    if (![self hasText]) 
    {
        return;
    }
    
    [self setBackgroundAndBorderColors];
    
    UIFont *font = [UIFont boldSystemFontOfSize:14];
    
	CGSize numberSize = [text_ sizeWithFont:font forWidth:200 lineBreakMode:UILineBreakModeMiddleTruncation];
	float radius = numberSize.height/1.8;
	float startPoint = (rect.size.width - (numberSize.width + numberSize.height))/2.0;
    
	[text_ drawInRect:CGRectMake(startPoint + radius, rect.size.height/2-numberSize.height/2, rect.size.width, rect.size.height) withFont:font];
}

- (void)setSelected:(BOOL)isSelected
{
    selected_ = isSelected;
    
    if (isSelected) 
    {
        [self becomeFirstResponder];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegate_ willSelectToken:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setCancelledSelection:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{        
    if (cancelledSelection_) {
        [self setSelected:NO];
        [self setCancelledSelection:NO];
        
        return;
    }
    
    [delegate_ didSelectToken:self];
}

- (void)deleteBackward
{
    [self resignFirstResponder];
    
    [delegate_ willDeleteToken:self];

    [self setHidden:YES];
    
    [delegate_ didDeleteToken:self];
    
    [self removeFromSuperview];
}

- (void)insertText:(NSString *)text
{
    YALogDebug(@"insertText on token field not implemented");
}

- (BOOL)hasText
{
    return [text_ length] > 0;
}

@end
