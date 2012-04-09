//
//  YAContactsListViewControllerTests.m
//  altoids
//
//  Created by Derrick Whittle on 2/24/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import <objc/runtime.h>
#import "AppFactory.h"
#import "YAContactsListViewController.h"
#import "ContactsTableViewDataSource.h"
#import "ContactDetailViewController.h"
#import "NavigationBarButtonItemRepository.h"
#import "YAContact.h"

@interface YAContactsListViewControllerTests : YATestCase
{
    YAContactsListViewController* vc;
    
    id detailVCInstanceFactoryMock;
    id dataSourceInstanceFactoryMock;
    id navigationBarButtonItemRepositoryMock;
    
    id dataSourceMock;
    id dataSourceNiceMock;
    id tableViewMock;
    id tableViewNiceMock;
}
@end


@implementation YAContactsListViewControllerTests

- (void) setUp
{
    detailVCInstanceFactoryMock = [OCMockObject mockForProtocol:@protocol(ContactDetailViewControllerInstanceFactory)];
    dataSourceInstanceFactoryMock = [OCMockObject mockForProtocol:@protocol(ContactsTableViewDataSourceInstanceFactory)];
    navigationBarButtonItemRepositoryMock = [OCMockObject mockForProtocol:@protocol(NavigationBarButtonItemRepository)];

    dataSourceMock = [OCMockObject mockForProtocol:@protocol(ContactsTableViewDataSource)];
    dataSourceNiceMock = [OCMockObject niceMockForProtocol:@protocol(ContactsTableViewDataSource)];
    tableViewMock = [OCMockObject mockForClass:[UITableView class]];
    tableViewNiceMock = [OCMockObject niceMockForClass:[UITableView class]];

    vc = [[YAContactsListViewController alloc] init];
    [vc setContactDetailViewControllerInstanceFactory:detailVCInstanceFactoryMock];
    [vc setContactsTableViewDataSourceInstanceFactory:dataSourceInstanceFactoryMock];
    [vc setNavigationBarButtonItemRepository:navigationBarButtonItemRepositoryMock];
}


//
// initWithNibName:bundle:
//

- (void) testInitWithNibNameBundleShouldSetPropertiesAndTitle
{
    NSString* testNibName = @"test nib name";
    NSBundle* testBundle = [[NSBundle alloc] init];
    
    vc = [[YAContactsListViewController alloc] initWithNibName:testNibName bundle:testBundle];
    
    STAssertEquals(testNibName, [vc nibName], nil);
    STAssertEquals(testBundle, [vc nibBundle], nil);
    STAssertEquals(kContactsListTitle, [vc title], nil);
    // it's not really worth swizzling the UIImage class method imageNamed to verify the tab bar item is set up correctly...
    // we can revisit making a reuseable method to test this across the tab VCs
}

//
// dealloc
//

- (void) testDeallocShouldClearSelfAsDelegateFromDataSource
{
    [[dataSourceMock expect] clearDelegate:OCMOCK_ANY]; // we can't expect clearDelegate:self because OCMock would retain self, preventing dealloc

    [vc setDataSource:dataSourceMock];
    
    vc = nil;
    [dataSourceMock verify];
}

//
// didReceiveMemoryWarning
//

- (void) testDidReceiveMemoryWarningShouldNotifyDataSource
{
    [[dataSourceMock expect] didReceiveMemoryWarning];
    
    [vc setDataSource:dataSourceMock];
    
    [vc didReceiveMemoryWarning];
    [dataSourceMock verify];
}

//
// viewDidLoad
//

- (void) testViewDidLoadShouldCreateDataSourceWithSelfDelegateAndSetDelegatePropertyOfSelfAndTableViewAndLoadDataSourceWhenNoDelegateAlreadySet
{
    [[navigationBarButtonItemRepositoryMock stub] addContactButtonItemWithTarget:OCMOCK_ANY action:@selector(newContact:)];
    [[navigationBarButtonItemRepositoryMock stub] backButtonItemItemWithTitle:kBackButtonText target:nil action:nil];
    [[[dataSourceInstanceFactoryMock expect] andReturn:dataSourceMock] createContactsTableViewDataSourceWithDelegate:vc];
    [(id<ContactsTableViewDataSource>)[dataSourceMock expect] load];

    STAssertNil([vc dataSource], nil);
    [vc tableView];         // this causes viewDidLoad to be invoked, without unnaturally making viewDidLoad reentrant as a result of the [self tableView] in it
    STAssertEquals(dataSourceMock, [vc dataSource], nil);
    STAssertEquals(dataSourceMock, [[vc tableView] dataSource], nil);
    [dataSourceInstanceFactoryMock verify];
    [dataSourceMock verify];
}

- (void) testViewDidLoadShouldSetDelegatePropertyOfTableViewToExistingDataSourceAndLoadDataSourceWhenDelegateAlreadySet
{
    [[navigationBarButtonItemRepositoryMock stub] addContactButtonItemWithTarget:OCMOCK_ANY action:@selector(newContact:)];
    [[navigationBarButtonItemRepositoryMock stub] backButtonItemItemWithTitle:kBackButtonText target:nil action:nil];
    // no stub for dataSourceInstanceFactoryMock; shouldn't create a new instance in this case
    [(id<ContactsTableViewDataSource>)[dataSourceMock expect] load];

    [vc setDataSource:dataSourceMock];

    [vc tableView];         // this causes viewDidLoad to be invoked, without unnaturally making viewDidLoad reentrant as a result of the [self tableView] in it
    STAssertEquals(dataSourceMock, [[vc tableView] dataSource], nil);
    [dataSourceMock verify];
}

//
// contactsTableViewDataSourceDidLoadContacts
//

- (void) testContactsTableViewDataSourceDidLoadContactsShouldReloadDataOfTableView
{
    [[tableViewMock expect] reloadData];

    // We must swizzle in our table view mock because directly attempting to setTableView: leads to a UIViewController crash
    id swizzler = (^UITableView*() { return tableViewMock; });
    [self swizzleSelector:@selector(tableView) inClass:[YAContactsListViewController class] withBlock:swizzler asSelector:@selector(tableView) inClass:[self class] executeBlock:^(void)
     {
         [vc contactsTableViewDataSourceDidLoadContacts:dataSourceMock];         
     }];

    [tableViewMock verify];
}

//
// tableView:DidSelectRowAtIndexPath:
//

- (void) tableViewDidSelectRowAtIndexPathShouldNotCreateDetailVCWhenDataSourceHasNoContactForGivenIndexPath
{
    NSIndexPath* indexPath = [[NSIndexPath alloc] init];
    [[[dataSourceMock expect] andReturn:nil] contactAtIndexPath:indexPath];
    
    [vc tableView:tableViewMock didSelectRowAtIndexPath:indexPath];
    [dataSourceMock verify];
}

- (void) tableViewDidSelectRowAtIndexPathShouldCreateDetailVCWithContactFromDataSourceForGivenIndexPathAndPushDetailVC
{
    YAContact* contact = [[YAContact alloc] init];
    NSIndexPath* indexPath = [[NSIndexPath alloc] init];
    id contactDetailViewControllerMock = [OCMockObject mockForProtocol:@protocol(ContactDetailViewController)];
    UIViewController* contactDetailViewController = [[UIViewController alloc] init];
    id navigationControllerMock = [OCMockObject mockForClass:[UINavigationController class]];

    [[[dataSourceMock expect] andReturn:contact] contactAtIndexPath:indexPath];
    [[[detailVCInstanceFactoryMock expect] andReturn:contactDetailViewControllerMock] createContactDetailViewControllerWithContact:contact];
    [[[contactDetailViewControllerMock expect] andReturn:contactDetailViewController] viewController];
    [[navigationControllerMock expect] pushViewController:contactDetailViewController animated:YES];

    // We have to swizzle to inject our own navigation controller; there's no seam to verify that we've pushed the new VC onto it
    id swizzler = (^UINavigationController*() { return navigationControllerMock; });
    [self swizzleSelector:@selector(navigationController) inClass:[YAContactsListViewController class] withBlock:swizzler asSelector:@selector(navigationController) inClass:[self class] executeBlock:^(void)
     {
         [vc tableView:tableViewMock didSelectRowAtIndexPath:indexPath];
     }];

    [dataSourceMock verify];
    [detailVCInstanceFactoryMock verify];
    [contactDetailViewControllerMock verify];
    [navigationControllerMock verify];
}


@end
