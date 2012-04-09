//
//  YAContactPickerViewController.m
//  altoids
//
//  Created by Derrick Whittle on 3/28/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactPickerViewController.h"
#import "AppFactory.h"
#import "ContactPickerTableViewDataSource.h"
#import "ContactPickerViewControllerDelegate.h"
#import "NavigationBarButtonItemRepository.h"
#import "ContactPickerDetailViewController.h"
#import "UIAlertViewFactory.h"


@implementation YAContactPickerViewController

@synthesize contactPickerTableViewDataSourceInstanceFactory = contactPickerTableViewDataSourceInstanceFactory_,
            navigationBarButtonItemRepository = navigationBarButtonItemRepository_,
            contactPickerDetailViewControllerInstanceFactory = contactPickerDetailViewControllerInstanceFactory_,
            alertViewFactory = alertViewFactory_;
@synthesize delegate = delegate_,
            participantInfos = participantInfos_,
            modal = modal_;
@synthesize dataSource = dataSource_;

- (id) initWithDelegate:(id<ContactPickerViewControllerDelegate>)delegate participantInfos:(NSSet*)participantInfos modal:(BOOL)modal
{
    self = [super init];
    if(self)
    {
        delegate_ = delegate;
        participantInfos_ = participantInfos;
        modal_ = modal;
    }
    return self;
}

- (void) viewDidLoad
{
    UINavigationItem* navigationItem = [self navigationItem];
    [navigationItem setTitle:kContactPickerTitle];

    UIBarButtonItem* cancelButton = [navigationBarButtonItemRepository_ cancelButtonItemWithTarget:self action:@selector(onCancel:)];

    // make this screen appear as "Back" instead of "Select Contacts" in the contact picker details screen's back button
    [navigationItem setBackBarButtonItem:[navigationBarButtonItemRepository_ backButtonItemItemWithTitle:kBackButtonText target:nil action:nil]];

    if(modal_)
    {
        [navigationItem setLeftBarButtonItem:cancelButton];
        [navigationItem setRightBarButtonItem:[navigationBarButtonItemRepository_ doneButtonItemWithTarget:self action:@selector(onDone:)]];
    }
    else
    {
        [navigationItem setRightBarButtonItem:cancelButton];
    }

    // because we must maintain state when this view controller disappears and reappears (as we push contact details onto the navigation stack), we load our data source when viewDidLoad and keep it until dealloc
    if(!dataSource_)
    {
        dataSource_ = [contactPickerTableViewDataSourceInstanceFactory_ createContactPickerTableViewDataSourceWithDelegate:self participantInfos:participantInfos_];
        [dataSource_ load];
    }
    [[self tableView] setDataSource:dataSource_];

    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
    if(!modal_)
    {
        [[self navigationController] setDelegate:self];
    }
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
    if(modal_)
    {
        return;
    }

    // Resigning as the navigation controller delegate here works better than in viewWillDisappear (which causes us to not get this notification).
    // We can't resign in viewDidDisappear, because by then our navigationController property has been nilled.
    if(viewController != self && [navigationController delegate] == self)
    {
        [navigationController setDelegate:nil];
    }

    // Notify our delegate of selection changes if we're being pushed off of the stack
    // (but not if something -- Contact Picker Details -- is being pushed on top of us).
    if(![[navigationController viewControllers] containsObject:self])
    {
        [self notifyDelegateOfCompletedSelection];
    }
}


#pragma mark ViewControllerAccessor methods

- (UIViewController*) viewController
{
    return self;
}


#pragma mark ContactPickerTableViewDataSourceDelegate methods

- (void) contactsTableViewDataSourceDidLoadContacts:(id<ContactsTableViewDataSource>)dataSource
{
    [[self tableView] reloadData];
}


#pragma mark UITableViewDelegate methods

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    YAContact* contact = [dataSource_ contactAtIndexPath:indexPath];
    if([dataSource_ contactIsSelected:contact])
    {
        [dataSource_ deselectContact:contact];
        [[self tableView] reloadData];
        return;
    }
    
    if([dataSource_ maxParticipantsAlreadySelected])
    {
        [self alertUserThatMaxParticipantsHaveAlreadyBeenSelected];
        return;
    }
    
    if([dataSource_ numberOfAddressesForContactAtIndexPath:indexPath] > 1)
    {
        [self pushContactDetailsForIndexPath:indexPath];
    }
    else
    {
        [dataSource_ selectDefaultAddressForContact:contact];
        [[self tableView] reloadData];
    }
}

- (void) tableView:(UITableView*)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath
{
    BOOL contactAlreadySelected = [dataSource_ contactIsSelected:[dataSource_ contactAtIndexPath:indexPath]];
    if(!contactAlreadySelected && [dataSource_ maxParticipantsAlreadySelected])
    {
        [self alertUserThatMaxParticipantsHaveAlreadyBeenSelected];
        return;
    }

    [self pushContactDetailsForIndexPath:indexPath];
}


#pragma mark ContactPickerDetailViewControllerDelegate methods

- (void) contactPickerDetailViewController:(id<ContactPickerDetailViewController>)contactPickerDetailViewController didSelectContactEndpoint:(YAContactEndpoint*)contactEndpoint
{
    [dataSource_ selectContactEndpoint:contactEndpoint];
    [[self tableView] reloadData];
}


#pragma mark UI event handlers

- (void) onCancel:(id)sender
{
    [dataSource_ deselectAllContacts];
    [delegate_ contactPickerDidCancel:self];
}

- (void) onDone:(id)sender
{
    [self notifyDelegateOfCompletedSelection];
}

- (void) alertUserThatMaxParticipantsHaveAlreadyBeenSelected
{
    [[alertViewFactory_ createWithTitle:[NSString stringWithFormat:kContactPickerMaxParticipantsAlertTitle, [dataSource_ maxParticipants]]
                                message:[NSString stringWithFormat:kContactPickerMaxParticipantsAlert, [dataSource_ maxParticipants]]
                               delegate:nil
                      cancelButtonTitle:kOkButtonText
                      otherButtonTitles:nil] show];
}

- (void) pushContactDetailsForIndexPath:(NSIndexPath*)indexPath
{
    YAContact* contact = [dataSource_ contactAtIndexPath:indexPath];

    id<ContactPickerDetailViewController> contactPickerDetailViewController = [contactPickerDetailViewControllerInstanceFactory_ createContactPickerDetailViewControllerWithDelegate:self contact:contact selectedAddress:[dataSource_ selectedAddressForContact:contact] immutableSelection:[dataSource_ contactIsExistingParticipant:contact]];

    [[self navigationController] pushViewController:[contactPickerDetailViewController viewController] animated:YES];    
}

- (void) notifyDelegateOfCompletedSelection
{
    [delegate_ contactPicker:self didPickContactEndpoints:[dataSource_ selectedContactEndpoints]];
}


@end
