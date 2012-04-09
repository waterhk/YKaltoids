//
//  YATabBarController.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TabBarControllerAccessor.h"
#import "ConversationComposeViewController.h"
#import "ViewControllerContainer.h"
@protocol ContactsListViewController;

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YATabBarController : UITabBarController<TabBarControllerAccessor>

#pragma mark @property declarations
@property (nonatomic, strong) id<ViewControllerContainer> navigationControllerContainer;
@property (nonatomic, strong) id<ViewControllerAccessor> conversationListViewController;
@property (nonatomic, strong) id<ContactsListViewController> contactsListViewController;
@property (nonatomic, strong) id<ViewControllerAccessor> settingsListViewController;

#pragma mark  Class methods

#pragma mark Instance methods

@end