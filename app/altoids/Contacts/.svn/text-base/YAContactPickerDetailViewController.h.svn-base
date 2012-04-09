//
//  YAContactPickerDetailViewController.h
//  altoids
//
//  Created by Derrick Whittle on 3/29/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactPickerDetailViewController.h"
#import "ContactDetailTableViewDataSourceDelegate.h"
@protocol ContactPickerDetailViewControllerDelegate, ContactDetailTableViewDataSourceInstanceFactory, ContactDetailTableViewDataSource, NavigationBarButtonItemRepository;
@class YAContact, YAContactAddress;

@interface YAContactPickerDetailViewController : UITableViewController <ContactPickerDetailViewController, ContactDetailTableViewDataSourceDelegate, UINavigationControllerDelegate>

// injected dependencies
@property (nonatomic, strong) id<ContactDetailTableViewDataSourceInstanceFactory> contactDetailTableViewDataSourceInstanceFactory;
@property (nonatomic, strong) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;

// operational parameters
@property (nonatomic, strong) id<ContactPickerDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) YAContact* contact;
@property (nonatomic, readonly) BOOL immutableSelection;

- (id) initWithDelegate:(id<ContactPickerDetailViewControllerDelegate>)delegate contact:(YAContact*)contact selectedAddress:(YAContactAddress*)selectedAddress immutableSelection:(BOOL)immutableSelection;

// state
@property (nonatomic, strong) id<ContactDetailTableViewDataSource> dataSource;
@property (nonatomic, strong) YAContactAddress* initiallySelectedAddress;

- (void) onCancel:(id)sender;


@end
