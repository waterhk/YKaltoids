//
//  ButtonCreator.m
//  altoids
//
//  Created by Derrick Whittle on 1/19/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import "YAButtonCreator.h"

// Private class extension
@interface YAButtonCreator ()

// @property definitions

// methods

- (UIButton*)autosizingNavigationBarButtonWithNormalBackgroundImageName:(NSString*)normalBackgroundImageName pressedBackgroundImageName:(NSString*)pressedBackgroundImageName target:(id)target action:(SEL)action;

@end

@implementation YAButtonCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

// Dealloc
#pragma mark -
#pragma mark dealloc

- (void) dealloc
{
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

- (UIButton*)autosizingNavigationBarButtonWithTitle:(NSString*)title normalBackgroundImageName:(NSString*)normalBackgroundImageName pressedBackgroundImageName:(NSString*)pressedBackgroundImageName target:(id)target action:(SEL)action
{
    UIButton* button = [self autosizingNavigationBarButtonWithNormalBackgroundImageName:normalBackgroundImageName pressedBackgroundImageName:pressedBackgroundImageName target:target action:action];

    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:kNavigationBarButtonTitleFontSize]];
    [[button titleLabel] setShadowColor:[UIColor colorWithHue:0 saturation:0 brightness:0 alpha:kNavigationBarButtonTitleShadowAlpha]];
    [[button titleLabel] setShadowOffset:kNavigationBarButtonTitleShadowOffset];
    [[button titleLabel] setLineBreakMode:UILineBreakModeTailTruncation];

    [button setTitle:title forState:UIControlStateNormal];
    
    CGRect buttonBounds = [button bounds];
    if(title)
    {
        buttonBounds.size.width = [[NSString stringWithString:title] sizeWithFont:[[button titleLabel] font]].width + kNavigationBarButtonHorizontalPadding;
    }
    [button setBounds:buttonBounds];
    
    return button;
}

- (UIButton*)autosizingNavigationBarButtonWithImageNamed:(NSString*)imageName normalBackgroundImageName:(NSString*)normalBackgroundImageName pressedBackgroundImageName:(NSString*)pressedBackgroundImageName target:(id)target action:(SEL)action
{
    UIButton* button = [self autosizingNavigationBarButtonWithNormalBackgroundImageName:normalBackgroundImageName pressedBackgroundImageName:pressedBackgroundImageName target:target action:action];

    UIImage* image = [UIImage imageNamed:imageName];
    [button setImage:image forState:UIControlStateNormal];

    CGRect buttonBounds = [button bounds];
    if(image)
    {
        buttonBounds.size.width = [image size].width + kNavigationBarButtonHorizontalPadding;
    }
    [button setBounds:buttonBounds];
    
    return button;
}


// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark ButtonCreator ()

- (UIButton*)autosizingNavigationBarButtonWithNormalBackgroundImageName:(NSString*)normalBackgroundImageName pressedBackgroundImageName:(NSString*)pressedBackgroundImageName target:(id)target action:(SEL)action
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setContentMode:UIViewContentModeScaleAspectFit];
    
    UIImage* backgroundImage = [UIImage imageNamed:normalBackgroundImageName];
    UIImage* pressedBackgroundImage = [UIImage imageNamed:pressedBackgroundImageName];
    
    CGSize imageSize = [backgroundImage size];
    [button setBounds:CGRectMake(0, 0, imageSize.width, imageSize.height)];    
    NSInteger leftCapWidth = floorf(imageSize.width / 2);
    
    // use backgroundImage rather than image to get the image to stretch to fit the button
    [button setBackgroundImage:[backgroundImage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:0] forState:UIControlStateNormal];
    [button setBackgroundImage:[pressedBackgroundImage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:0] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[pressedBackgroundImage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:0] forState:UIControlStateSelected];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end
