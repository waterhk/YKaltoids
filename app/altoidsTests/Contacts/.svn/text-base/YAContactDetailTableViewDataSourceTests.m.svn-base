//
//  YAContactDetailTableViewDataSourceTests.m
//  altoids
//
//  Created by Derrick Whittle on 2/23/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "YAContactDetailTableViewDataSource.h"
#import "ContactDetailTableViewDataSourceDelegate.h"
#import "ContactRepository.h"
#import "TableViewCellCreator.h"
#import "ContactAddressFormatter.h"
#import "YAContact.h"
#import "YAContactRecordID.h"
#import "YAContactAddress.h"
#import "YAContactPhoneNumberAddress.h"
#import "YAContactEndpoint.h"

@interface YAContactDetailTableViewDataSourceTests : YATestCase
{
    YAContactDetailTableViewDataSource* dataSource;
    id delegateMock;
    id contactRepositoryMock;
    id tableViewCellCreatorMock;
    id contactAddressFormatterMock;
    
    id tableViewMock;

    YAContact* testContact;
    YAContactRecordID* testContactRecordID;
    NSArray* testPhoneNumbers;

    NSString* testGivenName;
    NSString* testFamilyName;
    NSString* testCompositeName;
    YAContactAddress* testAddress0;
    NSString* testAddressRawPhoneNumber0;
    NSString* testAddressYE164FormattedPhoneNumber0;
    NSString* testAddressLabel0;
    YAContactAddress* testAddress1;
    NSString* testAddressRawPhoneNumber1;
    NSString* testAddressYE164FormattedPhoneNumber1;
    NSString* testAddressLabel1;
    
    NSUInteger sectionName;
    NSUInteger sectionPhoneNumbers;
    NSUInteger sectionEmailAddresses;
}
@end

@implementation YAContactDetailTableViewDataSourceTests

- (void) setUp
{
    delegateMock = [OCMockObject mockForProtocol:@protocol(ContactDetailTableViewDataSourceDelegate)];
    contactRepositoryMock = [OCMockObject mockForProtocol:@protocol(ContactRepository)];
    tableViewCellCreatorMock = [OCMockObject mockForProtocol:@protocol(TableViewCellCreator)];
    contactAddressFormatterMock = [OCMockObject mockForProtocol:@protocol(ContactAddressFormatter)];
    
    tableViewMock = [OCMockObject mockForClass:[UITableView class]];
    
    sectionName = 0;
    sectionPhoneNumbers = 1;
    sectionEmailAddresses = 2;

    testAddressLabel0 = @"label 0";
    testAddressRawPhoneNumber0 = @"raw phone number 0";
    testAddressYE164FormattedPhoneNumber0 = @"normalized phone number 0";
    testAddress0 = [[YAContactPhoneNumberAddress alloc] initWithDisplayPhoneNumber:testAddressRawPhoneNumber0 label:testAddressLabel0];

    testAddressLabel1 = @"label 1";
    testAddressRawPhoneNumber1 = @"raw phone number 1";
    testAddressYE164FormattedPhoneNumber1 = @"normalized phone number 1";
    testAddress1 = [[YAContactPhoneNumberAddress alloc] initWithDisplayPhoneNumber:testAddressRawPhoneNumber1 label:testAddressLabel1];
    
    testGivenName = @"given name";
    testFamilyName = @"family name";
    testCompositeName = @"composite name";
    
    testPhoneNumbers = [NSArray arrayWithObjects:testAddress0, testAddress1, nil];
    testContactRecordID = [[YAContactRecordID alloc] initWithABRecordID:1234];
    testContact = [[YAContact alloc] initWithRecordID:testContactRecordID givenName:testGivenName familyName:testFamilyName compositeName:testCompositeName phoneNumberAddresses:testPhoneNumbers];

    dataSource = [[YAContactDetailTableViewDataSource alloc] initWithDelegate:delegateMock contact:testContact selectedAddress:nil];
    [dataSource setContactRepository:contactRepositoryMock];
    [dataSource setTableViewCellCreator:tableViewCellCreatorMock];
    [dataSource setContactAddressFormatter:contactAddressFormatterMock];
}


//
// initWithContact
//

- (void) testInitWithContactShouldSetContactProperty
{
    STAssertEquals(testContact, [dataSource contact], nil);
}

//
// contactEndpointForIndexPath
//

- (void) testContactEndpointForIndexPathShouldReturnNilGivenIndexPathForNameSection
{
    YAContactEndpoint* result = [dataSource contactEndpointForIndexPath:[NSIndexPath indexPathForRow:0 inSection:sectionName]];
    STAssertNil(result, nil);
}

- (void) testContactEndpointForIndexPathShouldReturnNilGivenIndexPathForEmailSectionAtLeastForNow
{
    YAContactEndpoint* result = [dataSource contactEndpointForIndexPath:[NSIndexPath indexPathForRow:0 inSection:sectionEmailAddresses]];
    STAssertNil(result, nil);
}

- (void) testContactEndpointForIndexPathShouldReturnContactEndpointHavingInitialContact
{
    YAContactEndpoint* result = [dataSource contactEndpointForIndexPath:[NSIndexPath indexPathForRow:0 inSection:sectionPhoneNumbers]];
    STAssertEquals(testContact, [result contact], nil);
}

- (void) testContactEndpointForIndexPathShouldReturnContactEndpointHavingFirstPhoneNumberWhenGivenFirstRowOfPhoneNumberSection
{
    YAContactEndpoint* result = [dataSource contactEndpointForIndexPath:[NSIndexPath indexPathForRow:0 inSection:sectionPhoneNumbers]];
    STAssertEquals(testAddress0, [result address], nil);
}

- (void) testContactEndpointForIndexPathShouldReturnContactEndpointHavingSecondPhoneNumberWhenGivenSecondRowOfPhoneNumberSection
{
    YAContactEndpoint* result = [dataSource contactEndpointForIndexPath:[NSIndexPath indexPathForRow:1 inSection:sectionPhoneNumbers]];
    STAssertEquals(testAddress1, [result address], nil);
}


//
// load, unload
//

- (void) testLoadShouldSubscribeToContactRepository
{
    [[contactRepositoryMock expect] addSubscriber:dataSource];

    [dataSource load];
}

- (void) testUnloadShouldUnsubscribeFromContactRepository
{
    [[contactRepositoryMock expect] removeSubscriber:dataSource];

    [dataSource unload];
}

- (void) testDeallocShouldUnsubscribeFromContactRepository
{
    [[contactRepositoryMock expect] removeSubscriber:OCMOCK_ANY];   // we can't expect dataSource itself, or it'll retain it and not get dealloced when we nil it below
    dataSource = nil;
}


//
// clearDelegate
//

- (void) testClearDelegateShouldNilDelegate
{
    [dataSource clearDelegate:delegateMock];
    STAssertNil([dataSource delegate], nil);
}

- (void) testClearDelegateShouldNotNilDelegateWhenGivenNonDelegate
{
    [dataSource clearDelegate:[OCMockObject mockForProtocol:@protocol(ContactDetailTableViewDataSourceDelegate)]];
    STAssertEquals(delegateMock, [dataSource delegate], nil);
    STAssertNotNil([dataSource delegate], nil);
}


//
// contactRepositoryDidLoadContacts
//

- (void) testContactRepositoryDidLoadContactsShouldUpdateContactPropertyFromContactRepositoryUsingOriginalContactRecordID
{
    YAContact* contact = [[YAContact alloc] init];
    id contactRepository = [OCMockObject mockForProtocol:@protocol(ContactRepository)];
    [[[contactRepository expect] andReturn:contact] contactWithRecordID:testContactRecordID];
    [[delegateMock stub] contactDetailTableViewDataSource:OCMOCK_ANY didLoadContact:OCMOCK_ANY];

    [dataSource contactRepositoryDidLoadContacts:contactRepository];
    STAssertEquals(contact, [dataSource contact], nil);
}

- (void) testContactRepositoryDidLoadContactsShouldNotifyDelegateWithNewContact
{
    YAContact* contact = [[YAContact alloc] init];
    id contactRepository = [OCMockObject mockForProtocol:@protocol(ContactRepository)];
    [[[contactRepository expect] andReturn:contact] contactWithRecordID:testContactRecordID];
    [[delegateMock expect] contactDetailTableViewDataSource:dataSource didLoadContact:contact];
    
    [dataSource contactRepositoryDidLoadContacts:contactRepository];
}


//
// numberOfSecondsInTableView
//

- (void) testNumberOfSecondsInTableViewShouldReturn3
{
    NSUInteger number = [dataSource numberOfSectionsInTableView:tableViewMock];
    STAssertTrue(number == 3, nil);
}

//
// tableViewNumberOfRowsInSection
//

- (void) testTableViewNumberOfRowsInSectionShouldReturn1ForNameSection
{
    NSUInteger number = [dataSource tableView:tableViewMock numberOfRowsInSection:sectionName];
    STAssertTrue(number == 1, nil);
}

- (void) testTableViewNumberOfRowsInSectionShouldReturn0ForEmailSectionAtLeastForNow
{
    NSUInteger number = [dataSource tableView:tableViewMock numberOfRowsInSection:sectionEmailAddresses];
    STAssertTrue(number == 0, nil);
}

- (void) testTableViewNumberOfRowsInSectionShouldReturnNumberOfPhoneNumberAddressesForPhoneNumberSection
{
    NSUInteger number = [dataSource tableView:tableViewMock numberOfRowsInSection:sectionPhoneNumbers];
    STAssertTrue(number == [testPhoneNumbers count], nil);
}

//
// tableViewCellForRowAtIndexPath
//

// I expect tableView:cellForRowAtIndexPath: will be refactored in a future sprint to support per-cell-type classes/xibs,
// so there's no sense in testing the placeholder implementation now.


@end
