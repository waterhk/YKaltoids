//
//  YAContactPickerDetailViewController.m
//  altoids
//
//  Created by Derrick Whittle on 3/29/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactPickerDetailViewController.h"
#import "AppFactory.h"
#import "ContactDetailTableViewDataSource.h"
#import "ContactPickerDetailViewControllerDelegate.h"
#import "NavigationBarButtonItemRepository.h"
#import "YAContactEndpoint.h"
#import "YAContactAddress.h"

@implementation YAContactPickerDetailViewController

@synthesize contactDetailTableViewDataSourceInstanceFactory = contactDetailTableViewDataSourceInstanceFactory_,
            navigationBarButtonItemRepository = navigationBarButtonItemRepository_;
@synthesize delegate = delegate_,
            contact = contact_,
            immutableSelection = immutableSelection_;
@synthesize dataSource = dataSource_,
            initiallySelectedAddress = initiallySelectedAddress_;


- (id) initWithDelegate:(id<ContactPickerDetailViewControllerDelegate>)delegate contact:(YAContact*)contact selectedAddress:(YAContactAddress*)selectedAddress immutableSelection:(BOOL)immutableSelection
{
    NSAssert(delegate, @"expected delegate");
    NSAssert(contact, @"expected contact");

    self = [super init];
    if(self)
    {
        delegate_ = delegate;
        contact_ = contact;
        initiallySelectedAddress_ = selectedAddress;
        immutableSelection_ = immutableSelection;
    }
    return self;
}

- (void) viewDidLoad
{
    UINavigationItem* navigationItem = [self navigationItem];
    [navigationItem setTitle:kContactViewTitle];
    [navigationItem setRightBarButtonItem:[navigationBarButtonItemRepository_ cancelButtonItemWithTarget:self action:@selector(onCancel:)]];

    dataSource_ = [contactDetailTableViewDataSourceInstanceFactory_ createContactDetailTableViewDataSourceWithDelegate:self contact:contact_ selectedAddress:initiallySelectedAddress_];
    [[self tableView] setDataSource:dataSource_];
    [dataSource_ load];

    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
    [[self navigationController] setDelegate:self];
    [super viewDidAppear:animated];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    [dataSource_ didReceiveMemoryWarning];
}

- (void) dealloc
{
    // We have to nil the delegate here, or it leaks (the contact picker VC will never be freed).
    // ARC should have taken care of this automatically, because it's a strong pointer, right?
    // (The delegate property is strong because we need to cause the contact picker VC to stay alive
    //  to maintain its selection state and be available for us to inform of selection;
    //  since the contact picker VC does not hold a reference to us, it's safe).
    delegate_ = nil;

    // Similarly, unless we manually nil dataSource_ here, it isn't being released/dealloced!
    [dataSource_ clearDelegate:self];
    dataSource_ = nil;

    // TODO -- what is ARC doing??
    // This manual implementation of dealloc should be completely unnecesary, yet our manual nilling fixes real leaks.
}


#pragma mark UINavigationControllerDelegate methods

- (void) navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    // Resigning as the navigation controller delegate here works better than in viewWillDisappear (which causes us to not get this notification).
    // We can't resign in viewDidDisappear, because by then our navigationController property has been nilled.
    if(viewController != self && [navigationController delegate] == self)
    {
        [navigationController setDelegate:nil];
    }

    // Notify our delegate of selection changes if we're being pushed off of the stack.
    if(![[navigationController viewControllers] containsObject:self])
    {
        YAContactAddress* address = [dataSource_ selectedAddress];
        if(address)
        {
            [delegate_ contactPickerDetailViewController:self didSelectContactEndpoint:[[YAContactEndpoint alloc] initWithContact:[dataSource_ contact] address:address]];
        }
    }
}


#pragma mark ContactDetailTableViewDataSourceDelegate methods

- (void) contactDetailTableViewDataSource:(id<ContactDetailTableViewDataSource>)dataSource didLoadContact:(YAContact*)contact
{
    contact_ = contact;
    [[self tableView] reloadData];
}


#pragma mark ViewControllerAccessor methods
- (UIViewController*) viewController
{
    return self;
}


#pragma mark UITableViewController delegate methods

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(immutableSelection_)
    {
        return;
    }

    YAContactEndpoint* contactEndpoint = [dataSource_ contactEndpointForIndexPath:indexPath];
    if(contactEndpoint)
    {
        [dataSource_ setSelectedAddress:[contactEndpoint address]];
        [[self tableView] reloadData];
    }
}


#pragma mark UI event handlers

- (void) onCancel:(id)sender
{
    [dataSource_ setSelectedAddress:initiallySelectedAddress_];
    [[self navigationController] popViewControllerAnimated:YES];
}


@end
