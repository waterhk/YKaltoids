//
//  YAContactPickerViewController.h
//  altoids
//
//  Created by Derrick Whittle on 3/28/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactPickerViewController.h"
#import "ContactPickerTableViewDataSourceDelegate.h"
#import "ContactPickerDetailViewControllerDelegate.h"
@protocol ContactPickerTableViewDataSourceInstanceFactory, NavigationBarButtonItemRepository, ContactPickerDetailViewControllerInstanceFactory, UIAlertViewFactory;
@protocol ContactPickerViewControllerDelegate;
@protocol ContactPickerTableViewDataSource;

@interface YAContactPickerViewController : UITableViewController <ContactPickerViewController, UINavigationControllerDelegate, ContactPickerTableViewDataSourceDelegate, ContactPickerDetailViewControllerDelegate>

// injected dependencies
@property (nonatomic, strong) id<ContactPickerTableViewDataSourceInstanceFactory> contactPickerTableViewDataSourceInstanceFactory;
@property (nonatomic, strong) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;
@property (nonatomic, strong) id<ContactPickerDetailViewControllerInstanceFactory> contactPickerDetailViewControllerInstanceFactory;
@property (nonatomic, strong) id<UIAlertViewFactory> alertViewFactory;

// operational parameters
@property (nonatomic, assign) id<ContactPickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSSet* participantInfos;    // [YAParticipantInfo*]
@property (nonatomic, readonly) BOOL modal;

- (id) initWithDelegate:(id<ContactPickerViewControllerDelegate>)delegate participantInfos:(NSSet*)participantInfos modal:(BOOL)modal;

// state
@property (nonatomic, strong) id<ContactPickerTableViewDataSource> dataSource;


- (void) onCancel:(id)sender;
- (void) onDone:(id)sender;
- (void) alertUserThatMaxParticipantsHaveAlreadyBeenSelected;
- (void) pushContactDetailsForIndexPath:(NSIndexPath*)indexPath;
- (void) notifyDelegateOfCompletedSelection;

@end
