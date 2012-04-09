//
//  YAContactDetailTableViewDataSource.m
//  altoids
//
//  Created by Derrick Whittle on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactDetailTableViewDataSource.h"
#import "ContactDetailTableViewDataSourceDelegate.h"
#import "YAContact.h"
#import "YAContactPhoneNumberAddress.h"
#import "ContactRepository.h"
#import "TableViewCellCreator.h"
#import "ContactAddressFormatter.h"
#import "YAParticipantInfo.h"
#import "YAAddressInfo.h"
#import "YAContactEndpoint.h"

#define kContactDetailTableViewDataSourceSectionName                    0
#define kContactDetailTableViewDataSourceSectionPhoneNumberAddresses    1
#define kContactDetailTableViewDataSourceSectionEmailAddresses          2

@implementation YAContactDetailTableViewDataSource

@synthesize delegate = delegate_,
            contact = contact_,
            contactRecordID = contactRecordID_;
@synthesize contactRepository = contactRepository_,
            tableViewCellCreator = tableViewCellCreator_,
            contactAddressFormatter = contactAddressFormatter_;
@synthesize selectedAddress = selectedAddress_;


- (id) initWithDelegate:(id<ContactDetailTableViewDataSourceDelegate>)delegate contact:(YAContact*)contact selectedAddress:(YAContactAddress*)selectedAddress
{
    self = [super init];
    if(self)
    {
        delegate_ = delegate;
        contact_ = contact;
        contactRecordID_ = [contact recordID];
        selectedAddress_ = selectedAddress;
    }
    return self;
}

- (void) dealloc
{
    [self unload];
}


#pragma mark Delegater methods

- (void) clearDelegate:(id)delegate
{
    if(delegate == delegate_)
    {
        delegate_ = nil;
    }
}


#pragma mark TableViewDataSource methods

- (void) load
{
    [contactRepository_ addSubscriber:self];
}

- (void) unload
{
    [contactRepository_ removeSubscriber:self];
}

- (void) didReceiveMemoryWarning
{
    // we don't hold any state to free up
}


#pragma mark ContactDetailTableViewDataSource methods

- (YAContactEndpoint*) contactEndpointForIndexPath:(NSIndexPath*)indexPath
{
    NSUInteger section = [indexPath section];
    if(section == kContactDetailTableViewDataSourceSectionPhoneNumberAddresses)
    {
        YAContactPhoneNumberAddress* phoneNumberAddress = [[contact_ phoneNumberAddresses] objectAtIndex:[indexPath row]];
        return [[YAContactEndpoint alloc] initWithContact:contact_ address:phoneNumberAddress];
    }

    return nil;
}

#pragma mark UITableViewDataSource methods

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
    return 3;       // name, phone numbers, email addresses
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == kContactDetailTableViewDataSourceSectionName)
    {
        return 1;
    }
    if(section == kContactDetailTableViewDataSourceSectionPhoneNumberAddresses)
    {
        return [[contact_ phoneNumberAddresses] count];
    }
    if(section == kContactDetailTableViewDataSourceSectionEmailAddresses)
    {
        return [[contact_ emailAddresses] count];
    }
    
    return 0;
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    // TODO this is just temporary/prototype implementation, pending a future sprint story for real UI implementation

    NSString* text;
    BOOL selected = NO;

    // TODO this needs rewritten (in a future sprint) to use cell classes/xibs instead of these conditionals
    NSUInteger section = [indexPath section];
    if(section == kContactDetailTableViewDataSourceSectionName)
    {
        text = [contact_ compositeName];
    }
    else if(section == kContactDetailTableViewDataSourceSectionPhoneNumberAddresses)
    {
        YAContactPhoneNumberAddress* address = [[contact_ phoneNumberAddresses] objectAtIndex:[indexPath row]];
        text = [contactAddressFormatter_ formattedAddressAndLabel:address];
        selected = address == selectedAddress_;
    }
    else if(section == kContactDetailTableViewDataSourceSectionEmailAddresses)
    {
        YAContactAddress* address = [[contact_ emailAddresses] objectAtIndex:[indexPath row]];
        selected = address == selectedAddress_;
    }
    
    UITableViewCell* cell = [tableViewCellCreator_ createForTableView:tableView withStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    [[cell textLabel] setText:text];
    [cell setAccessoryType:(selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone)];

    return cell;
}


#pragma mark ContactRepositorySubscriber methods

- (void) contactRepositoryDidLoadContacts:(id<ContactRepository>)contactRepository
{
    contact_ = [contactRepository contactWithRecordID:contactRecordID_];
    [delegate_ contactDetailTableViewDataSource:self didLoadContact:contact_];
}


@end
