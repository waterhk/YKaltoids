//
//  YAParticipantPickerViewController.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ParticipantPickerDelegate.h"
#import "ViewControllerAccessor.h"
#import "ContactRepositorySubscriber.h"

@protocol ContactRepository, ContactLocator, TableViewCellCreator, ContactAddressFormatter, ParticipantInfoCreator;

@interface YAParticipantPickerViewController : UITableViewController<ParticipantPickerViewController, ContactRepositorySubscriber>

@property (nonatomic, strong) id<ContactRepository> contactRepository;
@property (nonatomic, strong) id<TableViewCellCreator> tableViewCellCreator;
@property (nonatomic, strong) id<ContactAddressFormatter> contactAddressFormatter;
@property (nonatomic, strong) id<ContactLocator> contactLocator;
@property (nonatomic, strong) id<ParticipantInfoCreator> participantInfoCreator;

@property (nonatomic, assign) id<ParticipantPickerDelegate> pickerDelegate;

- (id)initWithDelegate:(id<ParticipantPickerDelegate>)delegate;

@end
