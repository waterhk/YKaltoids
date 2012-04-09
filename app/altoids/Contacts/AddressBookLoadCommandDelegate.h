//
//  AddressBookLoadCommandDelegate.h
//  altoids
//
//  Created by Derrick Whittle on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AddressBookLoadCommand;


// intended for use only by ContactRepository (see docs/design/ContactRepository.md)

@protocol AddressBookLoadCommandDelegate <NSObject>

@required
- (void) addressBookLoadCommand:(id<AddressBookLoadCommand>)command didLoadContacts:(NSArray*)contacts;
- (void) addressBookLoadCommandDidFail:(id<AddressBookLoadCommand>)command;

@end
