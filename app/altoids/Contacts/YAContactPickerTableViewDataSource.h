//
//  YAContactPickerTableViewDataSource.h
//  altoids
//
//  Created by Derrick Whittle on 3/29/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactPickerTableViewDataSource.h"
#import "ContactsTableViewDataSourceDelegate.h"
@protocol ContactsTableViewDataSourceInstanceFactory, ContactLocator, TableViewCellCreator;
@protocol ContactsTableViewDataSource, ContactPickerTableViewDataSourceDelegate;

@interface YAContactPickerTableViewDataSource : NSObject <ContactPickerTableViewDataSource, ContactsTableViewDataSourceDelegate>


// injected dependencies
@property (nonatomic, strong) id<ContactsTableViewDataSourceInstanceFactory> contactsTableViewDataSourceInstanceFactory;
@property (nonatomic, strong) id<ContactLocator> contactLocator;
@property (nonatomic, strong) id<TableViewCellCreator> tableViewCellCreator;
@property (nonatomic, assign) NSUInteger maxParticipants;
@property (nonatomic, strong) NSMutableDictionary* contactRecordIDToSelectedContactEndpoints; // [YAContactRecordID* => YAContactEndpoint*]

// operational dependencies
@property (nonatomic, assign) id<ContactPickerTableViewDataSourceDelegate> delegate;
@property (nonatomic, strong) NSSet* participantInfos;    // [YAParticipantInfo*]

- (id) initWithDelegate:(id<ContactPickerTableViewDataSourceDelegate>) delegate participantInfos:(NSSet*)participantInfos;

// state
@property (nonatomic, strong) id<ContactsTableViewDataSource> contactsTableViewDataSource;
@property (nonatomic, strong) NSSet* participantContactRecords; // [YAContactRecordID*]


@end
