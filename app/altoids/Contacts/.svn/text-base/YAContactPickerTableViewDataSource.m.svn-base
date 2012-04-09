//
//  YAContactPickerTableViewDataSource.m
//  altoids
//
//  Created by Derrick Whittle on 3/29/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactPickerTableViewDataSource.h"
#import "AppFactory.h"
#import "ContactsTableViewDataSource.h"
#import "ContactLocator.h"
#import "TableViewCellCreator.h"
#import "ContactPickerTableViewDataSourceDelegate.h"
#import "YAContact.h"
#import "YAContactAddress.h"
#import "YAContactEndpoint.h"

@implementation YAContactPickerTableViewDataSource

@synthesize contactsTableViewDataSourceInstanceFactory = contactsTableViewDataSourceInstanceFactory_,
            contactLocator = contactLocator_,
            tableViewCellCreator = tableViewCellCreator_,
            maxParticipants = maxParticipants_,
            contactRecordIDToSelectedContactEndpoints = contactRecordIDToSelectedContactEndpoints_;
@synthesize delegate = delegate_,
            participantInfos = participantInfos_;
@synthesize contactsTableViewDataSource = contactsTableViewDataSource_,
            participantContactRecords = participantContactRecords_;

- (id) initWithDelegate:(id<ContactPickerTableViewDataSourceDelegate>)delegate participantInfos:(NSSet*)participantInfos
{
    NSAssert(delegate, @"expected delegate");
    self = [super init];
    if(self)
    {
        delegate_ = delegate;
        participantInfos_ = participantInfos;
    }
    return self;
}

- (void) setContactsTableViewDataSourceInstanceFactory:(id<ContactsTableViewDataSourceInstanceFactory>)contactsTableViewDataSourceInstanceFactory
{
    NSAssert(!contactsTableViewDataSource_, @"unexpected reinitialization");
    contactsTableViewDataSourceInstanceFactory_ = contactsTableViewDataSourceInstanceFactory;
    contactsTableViewDataSource_ = [contactsTableViewDataSourceInstanceFactory_ createContactsTableViewDataSourceWithDelegate:delegate_];
}

- (void) dealloc
{
    [contactsTableViewDataSource_ clearDelegate:self];
}


#pragma mark TableViewDataSource methods

- (void) load
{
    [contactsTableViewDataSource_ load];

    NSMutableSet* participantContactRecords = [NSMutableSet setWithCapacity:maxParticipants_];
    for(YAParticipantInfo* participantInfo in participantInfos_)
    {
        YAContactEndpoint* contactEndpoint = [contactLocator_ contactEndpointMatchingParticipantInfo:participantInfo];
        if(contactEndpoint)
        {
            YAContactRecordID* contactRecordID = [[contactEndpoint contact] recordID];
            [contactRecordIDToSelectedContactEndpoints_ setObject:contactEndpoint forKey:contactRecordID];
            [participantContactRecords addObject:contactRecordID];
        }
    }

    participantContactRecords_ = participantContactRecords;
}

- (void) unload
{
    [contactsTableViewDataSource_ unload];
}

- (void) didReceiveMemoryWarning
{
    [contactsTableViewDataSource_ didReceiveMemoryWarning];
}


#pragma mark private methods

- (NSUInteger) numberOfAddressesForContact:(YAContact*) contact
{
    return [[contact phoneNumberAddresses] count] + [[contact emailAddresses] count];
}

- (UIImage*) imageForContact:(YAContact*) contact
{
    YAContactRecordID* contactRecordID = [contact recordID];
    NSString* imageName = kTableCellUncheckedImage;
    if([participantContactRecords_ containsObject:contactRecordID])
    {
        imageName = kTableCellCheckedDisabledImage;
    }
    else if([contactRecordIDToSelectedContactEndpoints_ objectForKey:contactRecordID])
    {
        imageName = kTableCellCheckedImage;
    }

    return [UIImage imageNamed:imageName];
}


#pragma mark Delegater methods

- (void) clearDelegate:(id)delegate
{
    if(delegate_ == delegate)
    {
        delegate_ = nil;
    }
    [contactsTableViewDataSource_ clearDelegate:delegate];
}


#pragma mark ContactsTableViewDataSourceDelegate methods

- (void) contactsTableViewDataSourceDidLoadContacts:(id<ContactsTableViewDataSource>)dataSource
{
    [delegate_ contactsTableViewDataSourceDidLoadContacts:dataSource];
}


#pragma mark ContactPickerTableViewDataSource methods

- (BOOL) maxParticipantsAlreadySelected
{
    return [contactRecordIDToSelectedContactEndpoints_ count] >= maxParticipants_;
}

- (NSUInteger) numberOfAddressesForContactAtIndexPath:(NSIndexPath*)indexPath
{
    return [self numberOfAddressesForContact:[contactsTableViewDataSource_ contactAtIndexPath:indexPath]];
}

- (YAContactAddress*) selectedAddressForContact:(YAContact*)contact
{
    YAContactEndpoint* contactEndpoint = contact ? [contactRecordIDToSelectedContactEndpoints_ objectForKey:[contact recordID]] : nil;
    return [contactEndpoint address];
}

- (NSSet*) selectedContactEndpoints
{
    NSMutableSet* contactEndpoints = [NSMutableSet setWithCapacity:[contactRecordIDToSelectedContactEndpoints_ count]];
    for(YAContactRecordID* contactRecordID in contactRecordIDToSelectedContactEndpoints_)
    {
        if(![participantContactRecords_ containsObject:contactRecordID])
        {
            [contactEndpoints addObject:[contactRecordIDToSelectedContactEndpoints_ objectForKey:contactRecordID]];
        }
    }

    return contactEndpoints;
}

- (BOOL) contactIsSelected:(YAContact*)contact
{
    return [contactRecordIDToSelectedContactEndpoints_ objectForKey:[contact recordID]] != nil;
}

- (BOOL) contactIsExistingParticipant:(YAContact*)contact
{
    return [participantContactRecords_ containsObject:[contact recordID]];
}

- (BOOL) selectDefaultAddressForContact:(YAContact*)contact
{
    if([self maxParticipantsAlreadySelected])
    {
        return NO;
    }

    YAContactAddress* defaultAddress = [[contact phoneNumberAddresses] objectAtIndex:0];
    if(!defaultAddress)
    {
        defaultAddress = [[contact emailAddresses] objectAtIndex:0];
        if(!defaultAddress)
        {
            return NO;
        }
    }

    [contactRecordIDToSelectedContactEndpoints_ setObject:[[YAContactEndpoint alloc] initWithContact:contact address:defaultAddress] forKey:[contact recordID]];
    return YES;
}

- (BOOL) selectContactEndpoint:(YAContactEndpoint*)contactEndpoint
{
    if([self maxParticipantsAlreadySelected] && ![contactRecordIDToSelectedContactEndpoints_ objectForKey:[[contactEndpoint contact] recordID]])
    {
        return NO;
    }

    [contactRecordIDToSelectedContactEndpoints_ setObject:contactEndpoint forKey:[[contactEndpoint contact] recordID]];
    return YES;
}

- (BOOL) deselectContact:(YAContact*)contact
{
    if([participantContactRecords_ containsObject:[contact recordID]])
    {
        return NO;
    }

    [contactRecordIDToSelectedContactEndpoints_ removeObjectForKey:[contact recordID]];
    return YES;
}

- (void) deselectAllContacts
{
    [contactRecordIDToSelectedContactEndpoints_ removeAllObjects];
}


#pragma mark ContactTableViewDataSource methods

- (YAContact*) contactAtIndexPath:(NSIndexPath*)indexPath
{
    return [contactsTableViewDataSource_ contactAtIndexPath:indexPath];
}


#pragma mark UITableViewDataSource methods

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
    return [contactsTableViewDataSource_ numberOfSectionsInTableView:tableView];
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contactsTableViewDataSource_ tableView:tableView numberOfRowsInSection:section];
}

- (NSArray*) sectionIndexTitlesForTableView:(UITableView*)tableView
{
    return [contactsTableViewDataSource_ sectionIndexTitlesForTableView:tableView];
}

- (NSInteger) tableView:(UITableView*)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index
{
    return [contactsTableViewDataSource_ tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
}

- (NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    return [contactsTableViewDataSource_ tableView:tableView titleForHeaderInSection:section];
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    YAContact* contact = [self contactAtIndexPath:indexPath];

    UITableViewCell* cell = [tableViewCellCreator_ createForTableView:tableView withStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];

    [[cell textLabel] setText:[contact compositeName]];
    [[cell imageView] setImage:[self imageForContact:contact]];

    return cell;
}



@end
