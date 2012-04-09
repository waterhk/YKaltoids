//
//  YAContactsTableViewDataSource.h
//  altoids
//
//  Created by Derrick Whittle on 2/14/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactsTableViewDataSource.h"
#import "ContactRepositorySubscriber.h"
@protocol ContactRepository, MutableDictionaryCreator, MutableArrayCreator, TableViewCellCreator, ContactsTableViewDataSourceDelegate;


@interface YAContactsTableViewDataSource : NSObject <ContactsTableViewDataSource, ContactRepositorySubscriber>

@property (assign, nonatomic) id<ContactsTableViewDataSourceDelegate> delegate;
@property (strong, nonatomic) NSArray* sectionIndexes;
@property (strong, nonatomic) NSMutableArray* contactsBySection;   // array of arrays of contacts, indexed by section

// injected dependencies
@property (strong, nonatomic) id<ContactRepository> contactRepository;
@property (strong, nonatomic) id<MutableDictionaryCreator> mutableDictionaryCreator;
@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;
@property (strong, nonatomic) id<TableViewCellCreator> tableViewCellCreator;
@property (copy, nonatomic) NSString* sectionIndexTitles;
@property (copy, nonatomic) NSString* sectionIndexTitlesDelimiter;
@property (copy, nonatomic) NSString* sectionIndexTitlesNonAlphabeticSection;

- (id) initWithDelegate:(id<ContactsTableViewDataSourceDelegate>)delegate;

@end
