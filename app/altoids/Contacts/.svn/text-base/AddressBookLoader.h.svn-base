//
//  AddressBookLoader.h
//  altoids
//
//  Created by Derrick Whittle on 2/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YAContact;

// intended for use only by ContactRepository (see docs/design/ContactRepository.md)

@protocol AddressBookLoader <NSObject>

- (NSArray*) contactsFromAddressBook;
- (NSData*) imageDataForContact:(YAContact*)contact;

@end
