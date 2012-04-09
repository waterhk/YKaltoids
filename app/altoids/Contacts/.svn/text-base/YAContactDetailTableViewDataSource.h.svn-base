//
//  YAContactDetailTableViewDataSource.h
//  altoids
//
//  Created by Derrick Whittle on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactDetailTableViewDataSource.h"
#import "ContactRepositorySubscriber.h"
@class YAContact, YAContactRecordID;
@protocol ContactRepository, TableViewCellCreator, ContactAddressFormatter, ContactDetailTableViewDataSourceDelegate;

@interface YAContactDetailTableViewDataSource : NSObject <ContactDetailTableViewDataSource, ContactRepositorySubscriber>

// operational parameters
@property (nonatomic, strong) YAContact* contact;
@property (nonatomic, strong) YAContactRecordID* contactRecordID;
@property (nonatomic, assign) id<ContactDetailTableViewDataSourceDelegate> delegate;

// injected dependencies
@property (nonatomic, strong) id<ContactRepository> contactRepository;
@property (nonatomic, strong) id<TableViewCellCreator> tableViewCellCreator;
@property (nonatomic, strong) id<ContactAddressFormatter> contactAddressFormatter;

- (id) initWithDelegate:(id<ContactDetailTableViewDataSourceDelegate>)delegate contact:(YAContact*)contact selectedAddress:(YAContactAddress*)selectedAddress;


@end
