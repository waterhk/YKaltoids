//
//  ContactViewSelectionDelegate.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/6/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAContactInfo.h"
#import <AddressBook/AddressBook.h>

@protocol ContactViewSelectionDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required

- (BOOL)shouldSelectContact:(ABRecordRef)contact withInfo:(YAContactInfo*)info;
- (void)didSelectContact:(ABRecordRef)contact withInfo:(YAContactInfo*)info;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
