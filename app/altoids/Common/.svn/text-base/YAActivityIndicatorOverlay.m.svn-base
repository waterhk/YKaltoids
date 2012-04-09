//
//  YANetworkActivityIndicatorOverlay.m
//  altoids
//
//  Created by Devin Doman on 02/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAActivityIndicatorOverlay.h"

@interface YAActivityIndicatorOverlay ()

- (void)showOverlayWithText:(NSString *)text inView:(UIView*)view;
- (void)hideOverlay;

- (void)centerView:(UIView *)view inParentView:(UIView *)parentView;
- (void)horizontallyCenterView:(UIView *)view inParentView:(UIView *)parentView;

@end

@implementation YAActivityIndicatorOverlay

@synthesize mainThreader = mainThreader_;
@synthesize updatingLabel = updatingLabel_;
@synthesize activityStatusView;
@synthesize activityIndicatorSpinner;
@synthesize activityCompleteCheckMark;

-(id) init
{
    self = [super init];
    
    if (self)
    {
        NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:@"YAActivityIndicatorOverlay" owner:self options:nil];
        self = (YAActivityIndicatorOverlay*)[nibs objectAtIndex:0];
        
        [[self layer] setCornerRadius:8.0];
    }
    return self;
}

- (void)showActivityIndicatorOverylayWithUpdatingTextInParentView:(UIView*)view
{
    [mainThreader_ performSelector:@selector(showOverlayWithText:inView:) onTarget:self withObject:kUpdatingText andObject:view];
}

- (void)showActivityIndicatorOverylayWithSendingSMSTextInParentView:(UIView*)view
{
    [mainThreader_ performSelector:@selector(showOverlayWithText:inView:) onTarget:self withObject:kSendingSMSText andObject:view];
}

- (void)hideActivityIndicatorOverlay
{
    [mainThreader_ performSelector:@selector(hideOverlay) onTarget:self];
}

- (void)indicateCurrentActivityHasCompleted
{
    [activityIndicatorSpinner setHidden:YES];
    [activityCompleteCheckMark setHidden:NO];
    
    [updatingLabel_ setText:kCompleteText];
}

- (void)showOverlayWithText:(NSString *)text inView:(UIView*)view
{
    CGRect updatingLabelFrame = [updatingLabel_ frame];
    CGSize defaultLabelSize = updatingLabelFrame.size;
    CGSize requiredLabelSize = [text sizeWithFont:[updatingLabel_ font]];
    
    CGRect frame = [self frame];
    
    if (requiredLabelSize.width > defaultLabelSize.width) 
    {
        CGFloat defaultPadding = frame.size.width - defaultLabelSize.width;
        
        updatingLabelFrame.size.width = requiredLabelSize.width;
        frame.size.width = requiredLabelSize.width + defaultPadding;
        
        [updatingLabel_ setFrame:updatingLabelFrame];
        [self setFrame:frame];
        
        [self horizontallyCenterView:activityStatusView inParentView:self];
    }
    
    [self centerView:self inParentView:view];
    [updatingLabel_ setText:text];
    
    [view addSubview:self]; 
}

- (void)hideOverlay
{
    [self removeFromSuperview];
}

- (void)centerView:(UIView *)view inParentView:(UIView *)parentView
{
    CGRect frame = [view frame];
    CGRect parentFrame = [parentView frame];
    
    frame.origin.x = (parentFrame.size.width - frame.size.width) / 2;
    frame.origin.y = (parentFrame.size.height - frame.size.height) / 2;
    
    [view setFrame:frame];
}

- (void)horizontallyCenterView:(UIView *)view inParentView:(UIView *)parentView
{
    CGRect frame = [view frame];
    CGRect parentFrame = [parentView frame];
    
    frame.origin.x = (parentFrame.size.width - frame.size.width) / 2;
    
    [view setFrame:frame];
}

@end