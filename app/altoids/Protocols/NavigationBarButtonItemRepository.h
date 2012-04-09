//
//  NavigationBarButtonItemRepository.h
//  altoids
//
//  Created by Derrick Whittle on 1/18/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NavigationBarButtonItemRepository <NSObject>

#pragma mark -
#pragma mark emphasized (blue) buttons
- (UIBarButtonItem *)doneButtonItemWithTarget:(id)target action:(SEL)action;
- (UIBarButtonItem *)sendButtonItemWithTarget:(id)target action:(SEL)action;

#pragma mark -
#pragma mark normal (gray) buttons
- (UIBarButtonItem *)editButtonItemWithTarget:(id)target action:(SEL)action;
- (UIBarButtonItem *)cancelButtonItemWithTarget:(id)target action:(SEL)action;
- (UIBarButtonItem *)composeButtonItemWithTarget:(id)target action:(SEL)action;
- (UIBarButtonItem *)refreshButtonItemWithTarget:(id)target action:(SEL)action;
- (UIBarButtonItem *)addContactButtonItemWithTarget:(id)target action:(SEL)action;
- (UIBarButtonItem *)settingsButtonItemWithTarget:(id)target action:(SEL)action;
- (UIBarButtonItem *)backButtonItemItemWithTitle:(NSString *)aTitle target:(id)aTarget action:(SEL)aAction;

@end
