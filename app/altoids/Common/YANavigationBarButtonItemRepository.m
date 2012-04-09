//
//  YANavigationBarButtonItemRepository.m
//  altoids
//
//  Created by Derrick Whittle on 1/18/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import "YANavigationBarButtonItemRepository.h"
#import "ButtonCreator.h"
#import "BarButtonItemCreator.h"

@interface YANavigationBarButtonItemRepository ()

- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (UIButton *)emphasizedButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (UIButton *)buttonWithImageNamed:(NSString *)imageName target:(id)target action:(SEL)action;

@end

@implementation YANavigationBarButtonItemRepository

@synthesize buttonCreator = buttonCreator_;
@synthesize barButtonItemCreator = barButtonItemCreator_;

- (UIBarButtonItem *)doneButtonItemWithTarget:(id)target action:(SEL)action
{
    UIButton* button = [self emphasizedButtonWithTitle:kDoneButtonText target:target action:action];
    return [[self barButtonItemCreator] createBarButtonItemWithCustomView:button];
}

- (UIBarButtonItem *)sendButtonItemWithTarget:(id)target action:(SEL)action
{
    UIButton* button = [self emphasizedButtonWithTitle:kSendButtonText target:target action:action];
    return [[self barButtonItemCreator] createBarButtonItemWithCustomView:button];
}


- (UIBarButtonItem *)editButtonItemWithTarget:(id)target action:(SEL)action
{
    UIButton* button = [self buttonWithTitle:kEditButtonText target:target action:action];
    return [[self barButtonItemCreator] createBarButtonItemWithCustomView:button];
}

- (UIBarButtonItem *)cancelButtonItemWithTarget:(id)target action:(SEL)action
{
    UIButton* button = [self buttonWithTitle:kCancelButtonText target:target action:action];
    return [[self barButtonItemCreator] createBarButtonItemWithCustomView:button];
}

- (UIBarButtonItem *)composeButtonItemWithTarget:(id)target action:(SEL)action
{
    UIButton* button = [self buttonWithImageNamed:kNavigationBarButtonIconCompose target:target action:action];
    return [[self barButtonItemCreator] createBarButtonItemWithCustomView:button];
}

- (UIBarButtonItem *)refreshButtonItemWithTarget:(id)target action:(SEL)action
{
    UIButton* button = [self buttonWithImageNamed:kNavigationBarButtonIconRefresh target:target action:action];
    return [[self barButtonItemCreator] createBarButtonItemWithCustomView:button];
}

- (UIBarButtonItem *)addContactButtonItemWithTarget:(id)target action:(SEL)action
{
    UIButton* button = [self buttonWithImageNamed:kNavigationBarButtonIconAddContact target:target action:action];
    return [[self barButtonItemCreator] createBarButtonItemWithCustomView:button];
}

- (UIBarButtonItem *)settingsButtonItemWithTarget:(id)target action:(SEL)action
{
    UIButton* button = [self buttonWithImageNamed:kNavigationBarButtonIconSettings target:target action:action];
    return [[self barButtonItemCreator] createBarButtonItemWithCustomView:button];
}

- (UIBarButtonItem *)backButtonItemItemWithTitle:(NSString *)aTitle target:(id)aTarget action:(SEL)aAction
{
    UIBarButtonItem *newBackButtonItem = [[UIBarButtonItem alloc] initWithTitle:aTitle style:UIBarButtonItemStylePlain target:aTarget action:aAction];
    
    //iOS 5 and up specific API, before iOS 5 cannot customize back button background image
    if ([newBackButtonItem respondsToSelector:@selector(setBackButtonBackgroundImage:forState:barMetrics:)]) {
        NSString *titleWithLeftSpace = [NSString stringWithFormat:@"  %@", aTitle];
        [newBackButtonItem setTitle:titleWithLeftSpace];
        [newBackButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:kNavigationBarButtonIconBackDefault] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [newBackButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:kNavigationBarButtonIconBackTapped] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    }
    return newBackButtonItem;
}

- (UIButton*)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [[self buttonCreator] autosizingNavigationBarButtonWithTitle:title normalBackgroundImageName:kNavigationBarButtonNormalImageBackground pressedBackgroundImageName:kNavigationBarButtonNormalPressedImageBackground target:target action:action];
}

- (UIButton*)emphasizedButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [[self buttonCreator] autosizingNavigationBarButtonWithTitle:title normalBackgroundImageName:kNavigationBarButtonEmphasizedImageBackground pressedBackgroundImageName:kNavigationBarButtonEmphasizedPressedImageBackground target:target action:action];
}

- (UIButton*)buttonWithImageNamed:(NSString *)imageName target:(id)target action:(SEL)action
{
    return [[self buttonCreator] autosizingNavigationBarButtonWithImageNamed:imageName normalBackgroundImageName:kNavigationBarButtonNormalImageBackground pressedBackgroundImageName:kNavigationBarButtonNormalPressedImageBackground target:target action:action];
}
@end
