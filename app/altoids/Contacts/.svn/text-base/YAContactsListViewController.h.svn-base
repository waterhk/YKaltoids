//
//  YAContactsListViewController.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewControllerAccessor.h"
#import "ContactsListViewController.h"
#import "ContactsTableViewDataSourceDelegate.h"

@protocol NavigationBarButtonItemRepository;
@protocol ContactDetailViewControllerInstanceFactory;
@protocol ContactsTableViewDataSourceInstanceFactory, ContactsTableViewDataSource;

@interface YAContactsListViewController : UITableViewController<ContactsListViewController, ContactsTableViewDataSourceDelegate>

@property (strong, nonatomic) id<ContactsTableViewDataSource> dataSource;

@property (strong, nonatomic) id<ContactDetailViewControllerInstanceFactory> contactDetailViewControllerInstanceFactory;
@property (strong, nonatomic) id<ContactsTableViewDataSourceInstanceFactory> contactsTableViewDataSourceInstanceFactory;
@property (strong, nonatomic) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;

@end
