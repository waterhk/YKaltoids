//
//  ContactPickerTableViewDataSource.h
//  altoids
//
//  Created by Derrick Whittle on 3/29/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactsTableViewDataSource.h"
#import "Delegater.h"
@class YAContactEndpoint, YAContactAddress;

@protocol ContactPickerTableViewDataSource <ContactsTableViewDataSource, Delegater>

@property (nonatomic, readonly) NSUInteger maxParticipants;
- (BOOL) maxParticipantsAlreadySelected;

- (NSUInteger) numberOfAddressesForContactAtIndexPath:(NSIndexPath*)indexPath;
- (YAContactAddress*) selectedAddressForContact:(YAContact*)address;
- (NSSet*) selectedContactEndpoints;

- (BOOL) contactIsSelected:(YAContact*)contact;
- (BOOL) contactIsExistingParticipant:(YAContact*)contact;

- (BOOL) selectDefaultAddressForContact:(YAContact*)contact;
- (BOOL) selectContactEndpoint:(YAContactEndpoint*)contactEndpoint;
- (BOOL) deselectContact:(YAContact*)contact;
- (void) deselectAllContacts;

@end
