//
//  YANavigationBarButtonItemRepository.h
//  altoids
//
//  Created by Derrick Whittle on 1/18/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavigationBarButtonItemRepository.h"

@protocol ButtonCreator;
@protocol BarButtonItemCreator;

// navigation bar button backgrounds
#define kNavigationBarButtonNormalImageBackground @"btn-header-default"
#define kNavigationBarButtonNormalPressedImageBackground @"btn-header-tapped"
#define kNavigationBarButtonEmphasizedImageBackground @"btn-header-blue-default"
#define kNavigationBarButtonEmphasizedPressedImageBackground @"btn-header-blue-tapped"
// navigation bar button icons
#define kNavigationBarButtonIconAddContact @"icn-add-contact"
#define kNavigationBarButtonIconCompose @"icn-startconvo"
#define kNavigationBarButtonIconRefresh @"icn-refresh"
#define kNavigationBarButtonIconSettings @"icn-manage"
static NSString * const kNavigationBarButtonIconBackDefault = @"btn-header-back-default";
static NSString * const kNavigationBarButtonIconBackTapped = @"btn-header-back-tapped";

@interface YANavigationBarButtonItemRepository : NSObject <NavigationBarButtonItemRepository>

@property (nonatomic, strong) id<ButtonCreator> buttonCreator;
@property (nonatomic, strong) id<BarButtonItemCreator> barButtonItemCreator;

@end